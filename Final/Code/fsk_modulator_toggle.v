// =============================================================
// FSK Modulator for 115200 baud
// Generates two frequencies depending on input bit
// =============================================================
module fsk_modulator_toggle (
    input  wire clk,        // 50 MHz system clock
    input  wire uart_bit,   // 0 or 1 control input
    output reg  fsk_out     // FSK waveform output to GPIO
);
    parameter integer N0 = 32;  // Low frequency
    parameter integer N1 = 12;  // High frequency

    reg [7:0] counter = 0;
    reg [7:0] toggle_limit = N1;

    always @(posedge clk) begin
        toggle_limit <= uart_bit ? N1 : N0;

        if (counter >= toggle_limit) begin
            counter <= 0;
            fsk_out <= ~fsk_out;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule

`default_nettype wire
