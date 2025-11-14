`default_nettype none

module fsk_demodulator_toggle #(
    parameter integer CLK_FREQ     = 50_000_000, // FPGA clock frequency
    parameter integer SYMBOL_PERIOD = 434,       // in clock cycles (adjust for real system)
    parameter integer N0 = 32,                  // transmitter low frequency toggle
    parameter integer N1 = 16                   // transmitter high frequency toggle
)(
    input  wire clk,
    input  wire fsk_in,
    output reg [7:0] rx_byte = 8'd0,
    output reg rx_ready = 0
);

    // --- Edge detection ---
    reg fsk_in_d1 = 0;
    wire toggle_edge = fsk_in ^ fsk_in_d1;

    // --- Symbol timing ---
    reg [31:0] symbol_timer = 0;

    // --- Edge counter ---
    reg [31:0] edge_count = 0;

    // --- Bit assembly ---
    reg [7:0] bit_buffer = 0;
    reg [2:0] bit_index = 0; // 0-7 bits

    // --- Auto threshold ---
    localparam integer EDGES_LOW  = SYMBOL_PERIOD / N0;
    localparam integer EDGES_HIGH = SYMBOL_PERIOD / N1;
    localparam integer THRESHOLD  = (EDGES_LOW + EDGES_HIGH) / 2;

    always @(posedge clk) begin
        fsk_in_d1 <= fsk_in;
        rx_ready <= 0;

        // Count edges during symbol period
        if (toggle_edge)
            edge_count <= edge_count + 1;

        // Symbol timer
        if (symbol_timer >= SYMBOL_PERIOD - 1) begin
            symbol_timer <= 0;

            // Decide bit based on edge count
            //bit_buffer <= {((edge_count > THRESHOLD) ? 1'b1 : 1'b0), bit_buffer[7:1]};
				bit_buffer <= {bit_buffer[6:0], ((edge_count > THRESHOLD) ? 1'b1 : 1'b0)};


            bit_index <= bit_index + 1;
            edge_count <= 0;

            // Full byte received
            if (bit_index == 7) begin
                rx_byte <= bit_buffer;
                rx_ready <= 1;
                bit_index <= 0;
            end
        end else begin
            symbol_timer <= symbol_timer + 1;
        end
    end

endmodule

`default_nettype wire
