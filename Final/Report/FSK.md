# Final Project: FSK Generator
*Duncan Wood* <br>
*11/14/2025*

## Objective
The goal of this project was to design and implement a complete Frequency-Shift Keying (FSK) modem on an FPGA using a 50 MHz system clock. The system accepts asynchronous serial data from a PC, converts each received byte into a framed bitstream, and maps each bit to one of two discrete output frequencies using a toggle-based FSK modulator. This modulated waveform is looped back internally into an FSK demodulator, which classifies each symbol by counting waveform transitions and reconstructs the original byte stream for retransmission over UART. The project demonstrates an end-to-end digital communication link entirely in hardware—spanning byte framing, carrier modulation, symbol timing, and symbol decision logic—and provides an opportunity to explore practical synchronization challenges that arise when theoretical modulation schemes meet real hardware timing constraints.

## Top-Level Code / System Overview

<div align="center">
  <img src="img/fsk_system_block.jpg" alt="Top-Level" width="600"/><br>
  <em>Figure 1: Top-level block diagram </em>
</div>

At the top level, the UART receiver captures asynchronous serial data from the PC and delivers each byte to the transmit FSM, which generates a timed bitstream at the chosen symbol period. This bitstream drives the FSK modulator, which outputs one of two discrete frequencies depending on the current bit value. The resulting waveform is looped internally into the FSK demodulator, which counts transitions within each symbol window to determine whether the transmitted bit was a logical 0 or 1, reassembles bytes, and forwards them to the UART transmitter for verification on the PC. Throughout this flow, additional display and debug outputs provide real-time insight into internal modem activity.

### Module Header
```verilog
module main (
    input CLOCK_50,
    input [35:0] GPIO,
    output [6:0] HEX0,
    output [9:0] LEDR
);
```

- CLOCK_50 - 50 MHz master clock for the overall system.
- GPIO[35] - UART RX input from serial terminal.
- GPIO[33] - UART TX output back to terminal.
- GPIO[0] - Used to output FSK waveform on pin.
- HEX0 - 7-segment display output (to show received character).
- LEDR - Used to debug the outputs

  ### Parameters
```verilog
parameter SYMBOL_PERIOD = 434;  // 50e6 / 115200 ≈ 434
parameter N0 = 32;              // low-frequency toggle period
parameter N1 = 16;              // high-frequency toggle period
```


- SYMBOL_PERIOD
  - Number of clock cycles per bit.
  - Main clock frequency / baud rate = 50e6 / 115200 = 434
- N0 and N1
  - toggle limits for FSK frequencies
  - f0 = 50 mHz / (2xN0)
  - f1 = 50 MHz / (2xN1)

These parameters are passed into the FSM, modulator, and demodulator to keep them synchronized.

### Internal Wires
```verilog
wire [7:0] RxD_data;
wire RxD_data_ready;
wire [7:0] demod_byte;
wire demod_ready;
wire tx_bit;
wire tx_sending;
wire fsk_out;
```

- RxD_data / RxD_data_ready = byte and strobe from UART receiver.
- tx_bit - bit stream output from the FSK transmit FSM.
- tx_sending - asserted while FSM is in active transmission (for debug).
- fsk_out - modulated waveform toggling between two tones.
- demod_byte / demod_ready = outputs from demodulator (reconstructed bytes).

These wires help connect the submodules together.

### UART Receiver
```verilog
async_receiver #(.ClkFrequency(50000000), .Baud(115200))
    RX (.clk(CLOCK_50),
        .RxD(GPIO[35]),
        .RxD_data_ready(RxD_data_ready),
        .RxD_data(RxD_data));
```
- Converts the asynchronous serial input on GPIO[35] into clean, clock-synchronous bytes.
- Runs continuously at 115200 baus using internal oversampling logic.
- Each completed byte triggers RxD_data_ready
- Output feeds the FSK transmit FSM.

### FSK Transmit FSM

```verilog
fsk_tx_fsm #(.SYMBOL_PERIOD(SYMBOL_PERIOD))
    TX_FSM (.clk(CLOCK_50),
            .data_ready(RxD_data_ready),
            .data_in(RxD_data),
            .bit_out(tx_bit),
            .sending(tx_sending));
```

- When a new byte arrives (RxD_data_ready), it serializes the frame at the exact bit timing defined by SYMBOL_PERIOD.
- Produces a single-bit stream (tx_bit) for the modulator.
- tx_sending stays high while transmitting the 10 bits.
- Ensures one bit per defined number of clock cycles.

### FSK Modulator
```verilog
fsk_modulator_toggle #(.N0(N0), .N1(N1))
    MOD (.clk(CLOCK_50),
         .uart_bit(tx_bit),
         .fsk_out(fsk_out));
```

- Converts each tx_bit into one of two output frequencies:
  - bit=0 toggles every N0 clocks.
  - bit=1 toggles every N1 clocks.
- The square-wave fsk_out is the actual FSK carrier.
- This is the transmitter waveform that would normally drive an RF DAC or mixer; here it's a simple digital pin.

### FSK Demodulator
```verilog
fsk_demodulator_toggle #(.SYMBOL_PERIOD(SYMBOL_PERIOD),
                         .N0(N0), .N1(N1))
    DEMOD (.clk(CLOCK_50),
           .fsk_in(fsk_out),
           .rx_byte(demod_byte),
           .rx_ready(demod_ready));
```

- Reads the modulated waveform (fsk_out) directly.
- Counts edges per symbol window (434 clocks) and uses threshold about 20 edges to decide 0/1.
- Reassembles 8-bit bytes and asserts rx_ready when each byte is complete.
- Output goes to UART transmitter for verification.

### UART Transmitter
```verilog
async_transmitter #(.ClkFrequency(50000000), .Baud(115200))
    TX (.clk(CLOCK_50),
        .TxD(GPIO[33]),
        .TxD_start(demod_ready),
        .TxD_data(demod_byte),
        .TxD_busy());
```

- Takes demodulated bytes and re-sends them as standard UART back to the PC/serial terminal.
- Triggered each time demod_ready pulses.
- Provides a convenient loop-back verification path (type a character on your PC, it’s modulated, demodulated, then echoed back).

### 7-Segment Display
```verilog
char2seg SEG (.char(RxD_data), .segments(HEX0));
```
- Displays the most recently received ASCII character on the 7-segment display (HEX0).
- Helps confirm the UART reception before modulation.

### Assignments for Debugging
```verilog
assign GPIO[0] = fsk_out;   // observe modulated signal on scope
assign LEDR[0] = tx_bit;    // shows current bit being transmitted
assign LEDR[1] = tx_sending; // lit while FSM is active
assign LEDR[2] = RxD_data_ready;
```
- GPIO[0] outputs the FSK carrier so you can probe it.
- LEDR[0-2] indicates bit status 1/0.
  - Bit stream level, transmitting flag, and UART-RX ready flag.

All other LEDs remain unused and default to off.

## UART Receiver
The UART receiver receives serial bits from GPIO[35] and produces bytes (RxD_data) with a RxD_data_ready pulse when a full byte is received. This is the input to the FSK transmit FSM.
<br>
<br>

- receives serial bits from GPIO[35] and produces bytes (RxD_data) with a RxD_data_ready pulse when a full byte is received. This is the input to the FSK transmit FSM.
- the module implements oversampling (default Oversampling = 8) and uses a BaudTickGen to create OversamplingTick pulses. That lets it sample the RX line at 8× the baud rate and pick the mid-bit sample point.
- Synchronization and simple filter: incoming RxD is synchronized to the local clock (RxD_sync) and filtered (Filter_cnt) to remove short glitches before sampling.
- tate machine: looks for start bit (~RxD_bit), then advances states to collect 8 bits at sampleNow times. When a stop bit sampled as 1, it asserts RxD_data_ready for one clock.
- Idle / packet detection: RxD_idle and RxD_endofpacket computed by counting gaps between characters.

Overall, the uart receiver ensures reliable conversion of asynchronous serial data into aligned bytes that the FSK transmit FSM can use.


## FSK Transmitter FSM
The FSK transmitter FSM converts incoming UART bytes into a timed bit-stream (start bit, 8 data bits, stop bit) at a fixed symbol period (number of FPGA clocks per UART bit). Its output bit_out is the logical bit stream (0/1) that the FSK modulator maps to two tones.
<br>
<br>

Interface

- Inputs: clk, data_ready, data_in[7:0]
- Outputs: bit_out, sending
<br>
<br>

Key details

- Parameter SYMBOL_PERIOD, which is the clock cycles output per bit (calculations explained below).
- When data_ready arrives and the FSM is idle, it packages a frame {stop(1), data[7:0], start(0)} into a 10-bit frame register (LSB first).
- bit_count = 10 on start.
- symbol_timer increments on each clock; when it reaches SYMBOL_PERIOD - 1 the FSM advances: it outputs the current LSB of frame on bit_out, right-shifts frame, decrements bit_count. When bit_count reaches 1 the FSM clears sending.
- Idle condition: when not sending, bit_out is held at 0 (so the modulator sees one steady tone while idle).
<br>
<br>

Overall the fsk transmit fsm is essentially a byte-to-bit serializer whose timing is controlled in clocks via SYMBOL_PERIOD. It presents a stable bit for the exact duration of one UART bit (as measured in FPGA clocks).

### Symbol Period Calculation
To compute the required clocks per symbol, the following is used:
- Clock frequency: 50 MHz
- UART baud rate: 115200 symbols/second
The symbol period (SYMBOL_PERIOD) is calculated using the formula
- SYMBOL_PERIOD = Clk/Baud
- = 50,000,000 / 115,200
- = 434.0277778
- SYMBOL_PERIOD = 434 clock cycles / symbol
<br>
<br>

As mentioned previously, parameters were changed to make the FSK signal slow and noticeable on the oscilloscope for demonstration, thus the SYMBOL_PERIOD was incresed to a very high value (10M).
<br>
<br>
In order for everything to synchronize with the UART baud and successfully encode/decode the bits, the calculated SYMBOL_PERIOD value needs to be used. 



## FSK Modulator
The fsk modulator converts the logical uart_bit stream (0 or 1) into an FSK waveform (fsk_out) by toggling the output at two possible rates. One rate (N0) for bit=0, another (N1) for bit=1.
<br>
<br>

- Inputs: clk, uart_bit
- Output: fsk_out
- Parameters: N0 (low-frequency toggle interval), N1 (high-frequency toggle interval)
<br>
<br>
Implementation Details

- A counter increments each clk
- toggle_limit is set every cycle to N1 when uart_bit==1 else N0.
- When counter >= toggle_limit, counter resets and fsk_out toggles (i.e., fsk_out <= ~fsk_out).
- Thus each toggle is one edge. Frequency depends on how many clocks elapse between toggles.
<br>
<br>
Toggle Calculation

- f toggle_limit = N, a toggle occurs every ~N clocks, so a full waveform cycle (two toggles) is ~2×N clocks. Therefore:
  - f_toggle ≈ clk_freq / (2 * N)

<br>
<br>

Values used in main:

- N0 = 32: f_low ≈ 50e6 / (64) = 781,250 Hz
- N1 = 16: f_high ≈ 50e6 / (32) = 1,562,500 Hz

<br>
<br>
So the modulator maps logical 0→~0.78 MHz tone and logical 1: ~1.56 MHz tone (these are high relative to the baud; many cycles inside one symbol).
<br>
<br>
NOTE: the symbol period and frequency interval values were changed to enable a slow and observable working system; what is demonstrated in the videos/gifs.

## FSK Demodulator
The demodulator listens to the FSK analog-like fsk_in digital waveform, counts signal edges during each symbol interval and decides whether that symbol corresponded to a logical 0 or 1, then reconstructs bytes.
<br>
<br>
Interface
- Inputs: clk, fsk_in
- Outputs: rx_byte[7:0], rx_ready
<br>
<br>

Key details

- Edge detection: fsk_in_d1 is one-cycle delayed input; toggle_edge = fsk_in ^ fsk_in_d1.
- symbol_timer increments until it reaches SYMBOL_PERIOD - 1; during this symbol period the module increments edge_count on every toggle_edge.
- At end of symbol window:
  - Compute EDGES_LOW = SYMBOL_PERIOD / N0
  - Compute EDGES_HIGH = SYMBOL_PERIOD / N1
  - Compute THRESHOLD = (EDGES_LOW + EDGES_HIGH) / 2
  - If edge_count > THRESHOLD then symbol = 1 else 0
  - Shift that symbol into bit_buffer (LSB-first)
  - When 8 bits collected (bit_index wraps from 0..7), emit rx_byte and assert rx_ready for one cycle.
- Edge counter reset after each symbol window.
<br>
<br>

Notes on Robustness

- The demodulator is a simple edge-counting discriminator (non-coherent, energy-based). It assumes that high tone produces many more toggles during a symbol than the low tone. The threshold halfway between the expected edges for the two tones discriminates which tone was present.
- The chosen N0/N1 must produce a meaningful difference in edges per symbol (EDGES_HIGH - EDGES_LOW significantly bigger than jitter/noise).

## UART Transmitter
The uart transmitter takes reconstructed bytes (demod_byte) from demodulator, serializes them and sends bits to the serial terminal (GPIO[33]) using UART timing (115200 baud). The uart transmitter closes the loop of the FSK system.
<br>
<br>
Key Details

- BaudTickGen produces BitTick at requested baud (or in simulation BitTick=1).
- A small UART FSM sends start bit, 8 data bits LSB-first, and 2 stop bits (TX is configured for 2 stop bits in this code).
- TxD_busy indicates when transmitter is busy.
- The transmitter latches TxD_data on start and shifts it out on BitTick.
- It exposes current_bit (used by FSK modulator in modifications in file) so it can drive modulator directly in some setups.

## 7-Segment Decoder
The "char2seg" module maps ASCII byte (char) to 7-segment pattern (HEX0) for the on-board 7-seg display. This is purely for human convenience/debug: it displays the original received character (from UART RX) on board.
<br>
<br>

Key Details

- Lowercases uppercase letters (maps 65–90 to +32).
- A case mapping enumerates ASCII codes for digits and lowercase letters to 7-seg bit patterns.

## Demos, Issues, and Future Work


![FSK Scope](https://raw.githubusercontent.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/main/Final/Videos/scope_fsk.gif)
![Serial Terminal Output](https://raw.githubusercontent.com/duncanwood28/ENCE_4100_Duncan_Wood_2025/main/Final/Videos/serial_output_fsk.gif)

<br>
<br>
Higher quality videos available in "Videos" folder.
<br>
<br>
Overall, it can be seen that the incorrect characters are being printed in the serial terminal after it goes through the demodulator.



### Identified Issues

- Symbol boundary misalignment
  - The demodulator starts counting edges without synchronizing to the transmitter’s actual bit boundaries.
  - Even a small offset (a few clock cycles) causes a symbol window to overlap two transmitted bits, producing incorrect edge counts.
- Fixed threshold
  - The threshold, computed as the midpoint between expected low-tone and high-tone edge counts, assumes ideal conditions.
  - Small variations in toggle timing and jitter can push counts near the threshold and cause misclassification.
- Limited edge separation
  - With the current tone spacing (N₀ = 32, N₁ = 16), the difference in edges per symbol is modest (~13 and ~27).
  - This small spread reduces noise immunity and increases the chance of symbol errors.
- Lack of UART frame awareness
  - The demodulator collects 8 bits continuously without detecting UART start/stop bits.
  - A single incorrect bit shifts byte alignment and corrupts all subsequent data.
- No visibility into internal metrics
  - The system currently does not expose per-symbol edge counts or thresholds, making debugging more difficult.


### Potential Solutions

- Implement Symbol Sychronization
  - Detect the falling edge of the UART start bit and reset the demodulator’s symbol timer.
  - Ensures each 434-clock window aligns precisely with the transmitter’s bit boundaries.
- Increase tone separation
  - Choose N₀ and N₁ values with a larger ratio (ex. N₀ = 48, N₁ = 12).
  -  Produces a wider gap between low-tone and high-tone edge counts, reducing decision ambiguity.
- Add uART-frame validation at the receiver
  - Check for valid start and stop bits before accepting a reconstructed byte.
  - Prevents a single bit error from permanently shifting the bitstream.
- Smoothing/filtering edge detection
  -  low-pass filter the toggle signal to reduce accidental double-edge detection.







