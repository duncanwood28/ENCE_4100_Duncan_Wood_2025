`default_nettype none

module main(
    input         MAX10_CLK1_50,   // 50 MHz clock
    output [9:0]  LEDR,            // Debug LEDs
    output [7:0]  HEX0,            // 7-seg display for received char
    inout  [35:0] GPIO             // GPIO header
);

    wire clk = MAX10_CLK1_50;

    // =============================================================
    // Parameters
    // =============================================================
    parameter integer SYMBOL_PERIOD = 10_000_000; // number of clk cycles per symbol
    parameter integer N0 = 32;                // FSK low toggle
    parameter integer N1 = 16;                // FSK high toggle

    // =============================================================
    // UART Receiver (115200 baud)
    // =============================================================
    wire RxD_data_ready;
    wire [7:0] RxD_data;

    async_receiver RX(
        .clk(clk),
        .RxD(GPIO[35]),            
        .RxD_data_ready(RxD_data_ready),
        .RxD_data(RxD_data)
    );

    // =============================================================
    // FSK Transmitter State Machine
    // =============================================================
    wire        tx_bit; 
	 wire        tx_sending; 
	 
	 fsk_tx_fsm #( 
		  .SYMBOL_PERIOD(SYMBOL_PERIOD)        // 50 MHz / 115200 ≈ 434 
	 ) FSM ( 
		  .clk(clk), 
		  .data_ready(RxD_data_ready), 
		  .data_in(RxD_data), 
		  .bit_out(tx_bit), 
		  .sending(tx_sending) 
	 ); 


    // =============================================================
    // FSK Modulator
    // =============================================================
    wire fsk_out;

    fsk_modulator_toggle #(
        .N0(N0),
        .N1(N1)
    ) FSK_TX(
        .clk(clk),
        .uart_bit(tx_bit),
        .fsk_out(fsk_out)
    );

    // =============================================================
    // FSK Demodulator with Start-Bit Detection
    // =============================================================
    wire [7:0] demod_byte;
    wire demod_ready;

    fsk_demodulator_toggle #(
        .SYMBOL_PERIOD(SYMBOL_PERIOD),
        .N0(N0),
        .N1(N1)
    ) DEMOD(
        .clk(clk),
        .fsk_in(fsk_out),       // loopback
        .rx_byte(demod_byte),
        .rx_ready(demod_ready)
    );

    // =============================================================
    // UART Transmitter to Serial Terminal
    // =============================================================
    wire TxD_busy;

    async_transmitter TX(
        .clk(clk),
        .TxD(GPIO[33]),        
        .TxD_start(demod_ready),
        .TxD_data(demod_byte),
        .TxD_busy(TxD_busy)
    );

    // =============================================================
    // Display received character (original UART RX)
    // =============================================================
    char2seg HEX_DECODER(
        .char(RxD_data),
        .HEX0(HEX0)
    );

    // =============================================================
    // LEDs for debugging
    // =============================================================
    assign GPIO[0] = fsk_out;        // FSK output
    assign LEDR[0] = tx_bit;    // current transmitted bit
    assign LEDR[1] = tx_sending;        // transmission active
    assign LEDR[9] = RxD_data_ready; // new byte received

endmodule

`default_nettype wire

