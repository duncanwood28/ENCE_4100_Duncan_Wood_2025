`default_nettype none

// =============================================================
// FSK Transmit FSM
// Converts incoming UART bytes into a timed bit stream.
// =============================================================
module fsk_tx_fsm #(
    parameter integer SYMBOL_PERIOD = 434  // Bit duration in clock cycles
)(
    input  wire       clk,
    input  wire       data_ready,    // Asserted when a new byte arrives
    input  wire [7:0] data_in,       // Byte from UART RX
    output reg        bit_out,       // Bit stream output
    output reg        sending = 0    // 1 while transmitting
);
    reg [7:0]  shift_reg = 0;
    reg [3:0]  bit_count = 0;
    reg [31:0] symbol_timer = 0;
	 reg [9:0] frame; // start + 8 data + stop

	 always @(posedge clk) begin
    if (data_ready && !sending) begin
        // Load start + 8 data + stop bits (LSB first)
        frame <= {1'b1, data_in, 1'b0}; // stop + data + start
        bit_count <= 10;
        sending <= 1;
        symbol_timer <= 0;
    end else if (sending) begin
        if (symbol_timer == SYMBOL_PERIOD - 1) begin
            symbol_timer <= 0;
            bit_out <= frame[0];       // LSB first
            frame <= frame >> 1;
            bit_count <= bit_count - 1;
            if (bit_count == 1)
                sending <= 0;          // done after last bit
        end else begin
            symbol_timer <= symbol_timer + 1;
        end
    end else begin
        // IDLE CONDITION — constant tone when not sending
        bit_out <= 1'b0;
    end
end


endmodule

