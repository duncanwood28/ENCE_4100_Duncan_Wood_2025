```verilog
`default_nettype none

module FSM_Word_Detector(
    input clk,
    input reset,
    input [7:0] RxD_data,
    input RxD_data_ready,
    output reg [7:0] HEX0, HEX1, HEX2, HEX3, HEX4
);

    // States
    localparam [2:0]
        IDLE = 3'b000,
        S1   = 3'b001,
        S2   = 3'b010,
        S3   = 3'b011,
        S4   = 3'b100,
        DONE = 3'b101;

    reg [2:0] state, next_state;

    // 3-second timer (50 MHz clock)
    reg [27:0] counter;
    wire counter_done = (counter == 28'd150_000_000);

    // Blink timer
    reg [25:0] blink_counter;
    reg blink;

    // Timer logic
    always @(posedge clk) begin
        if (reset || state != DONE) begin
            counter <= 0;
            blink_counter <= 0;
            blink <= 1'b0;
        end else begin
            // 3-second counter
            if (!counter_done)
                counter <= counter + 1;

            // Blink counter
            if (blink_counter == 26'd25_000_000) begin
                blink <= ~blink;
                blink_counter <= 0;
            end else begin
                blink_counter <= blink_counter + 1;
            end
        end
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: if (RxD_data_ready && RxD_data == "H") next_state = S1;
            S1:   if (RxD_data_ready) next_state = (RxD_data == "E") ? S2 : IDLE;
            S2:   if (RxD_data_ready) next_state = (RxD_data == "L") ? S3 : IDLE;
            S3:   if (RxD_data_ready) next_state = (RxD_data == "L") ? S4 : IDLE;
            S4:   if (RxD_data_ready) next_state = (RxD_data == "O") ? DONE : IDLE;
            DONE: if (counter_done) next_state = IDLE;
        endcase
    end

    // Output logic with blinking
    always @(*) begin
        // Default: blank displays
        HEX0 = 8'hFF;
        HEX1 = 8'hFF;
        HEX2 = 8'hFF;
        HEX3 = 8'hFF;
        HEX4 = 8'hFF;

        if (state == DONE && blink) begin
            HEX0 = 8'b10100011; // o
            HEX1 = 8'b11000111; // L
            HEX2 = 8'b11000111; // L
            HEX3 = 8'b10000110; // E
            HEX4 = 8'b10001001; // H
        end
    end

endmodule

`default_nettype wire

```
