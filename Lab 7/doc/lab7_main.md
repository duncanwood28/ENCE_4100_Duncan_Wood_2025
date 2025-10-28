```verilog

`default_nettype none

module main(
    // Board I/Os
    input       MAX10_CLK1_50,
    input  [9:0] SW,
    output [9:0] LEDR,
    inout  [35:0] GPIO,
    output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4
);

    // Clock
    wire w_clk = MAX10_CLK1_50;

    // UART signals
    wire RxD_data_ready;
    wire [7:0] RxD_data;
    reg  [7:0] GPout;

    // Async UART receiver
    async_receiver RX(
        .clk(w_clk), 
        .RxD(GPIO[35]), 
        .RxD_data_ready(RxD_data_ready), 
        .RxD_data(RxD_data)
    );

    // Store latest received byte
    always @(posedge w_clk) begin
        if (RxD_data_ready)
            GPout <= RxD_data;
    end

    // Async UART transmitter (echo)
    async_transmitter TX(
        .clk(w_clk), 
        .TxD(GPIO[33]), 
        .TxD_start(RxD_data_ready), 
        .TxD_data(RxD_data)
    );

    // LEDs display received byte
    assign LEDR[7:0] = GPout;
	 
	// single-character HEX display
    wire [7:0] w_char2seg;
    char2seg Display(
        .char(GPout),
        .HEX0(w_char2seg)
    );

    // FSM Word Detector with blinking
    FSM_Word_Detector FSMD(
        .clk(w_clk),
        .reset(SW[9]),
        .RxD_data(GPout),
        .RxD_data_ready(RxD_data_ready),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4)
    );

endmodule

`default_nettype wire


```
