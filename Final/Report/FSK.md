# Final Project: FSK Generator
*Duncan Wood* <br>
*11/14/2025*

## Objective


## Top-Level Code / System Overview

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


## FSK Transmitter FSM


## FSK Modulator


## FSK Demodulator


## UART Transmitter


## 7-Segment Decoder










