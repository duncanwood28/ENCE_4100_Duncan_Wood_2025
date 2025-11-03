```verilog
////////////////////////////////////////////----------- MAIN ----------////////////////////////////////////////////////////
`default_nettype none

module main(
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [9:0] SW,
    inout [35:0] GPIO,
    output [9:0] LEDR,
    output [7:0] HEX0,
    output [7:0] HEX1,
    output [7:0] HEX2,
    output [7:0] HEX4,
    output [7:0] HEX5
);

localparam N = 4;

// ============================================================
// === USER WIRES ===
// ============================================================
wire w_clock = SW[9];
wire w_reset = SW[8];
wire [N-1:0] w_user_input = SW[3:0];
wire w_carry;
assign LEDR[9] = w_carry;
wire [N-1:0] w_rOut;
assign LEDR[3:0] = w_rOut;

// ============================================================
// === INTERNAL WIRES ===
// ============================================================
wire [N-1:0] w_IB_BUS;
wire [N-1:0] w_AluA;
wire [N-1:0] w_AluB;
wire [N-1:0] w_counter;
wire [N-1:0] w_data;
wire [N-1:0] w_instruction;

// ============================================================
// === FSM CONTROL WIRES ===
// ============================================================
wire w_LatchA;
wire w_EnableA;
wire w_LatchB;
wire w_EnableALU;
wire w_AddSub;
wire w_EnableIN;
wire w_EnableOut;
wire w_LoadInstr;
wire w_EnableInstr;
wire [N-1:0] w_ToInstr;
wire w_EnableCount;

// ============================================================
// === COMPONENTS ===
// ============================================================

// Accumulator A
Accumulator_A AccA(
    .MainClock(w_clock),
    .ClearA(w_reset),
    .LatchA(w_LatchA),
    .EnableA(w_EnableA),
    .A(w_IB_BUS),
    .IB_BUS(w_IB_BUS),
    .AluA(w_AluA)
);
seg7Decoder SEG1(.i_bin(w_AluA), .o_HEX(HEX1));

// Accumulator B
Accumulator_B AccB(
    .MainClock(w_clock),
    .ClearB(w_reset),
    .LatchB(w_LatchB),
    .B(w_IB_BUS),
    .AluB(w_AluB)
);
seg7Decoder SEG2(.i_bin(w_AluB), .o_HEX(HEX2));

// Arithmetic Unit
Arithmetic_Unit ALU(
    .EnableALU(w_EnableALU),
    .AddSub(w_AddSub),
    .A(w_AluA),
    .B(w_AluB),
    .Carry(w_carry),
    .IB_ALU(w_IB_BUS)
);
seg7Decoder SEG0(.i_bin(w_IB_BUS), .o_HEX(HEX0));

// Input Register
InRegister InReg(
    .EnableIN(w_EnableIN),
    .DataIn(w_user_input),
    .IB_BUS(w_IB_BUS)
);
seg7Decoder SEG4(.i_bin(w_user_input), .o_HEX(HEX4));

// Output Register
OutRegister OutReg(
    .MainClock(w_clock),
    .MainReset(w_reset),
    .EnableOut(w_EnableOut),
    .IB_BUS(w_IB_BUS),
    .rOut(w_rOut)
);
seg7Decoder SEG5(.i_bin(w_rOut), .o_HEX(HEX5));

// Instruction Register + ROM + FSM Controller
InstructionReg InstrReg(
    .MainClock(w_clock),
    .ClearInstr(w_reset),
    .LatchInstr(w_LoadInstr),
    .EnableInstr(w_EnableInstr),
    .Data(w_data),
    .Instr(w_instruction),
    .ToInstr(w_ToInstr),
    .IB_BUS(w_IB_BUS)
);

ProgramCounter ProgCounter(
    .MainClock(w_clock),
    .EnableCount(w_EnableCount),
    .ClearCounter(w_reset),
    .Counter(w_counter)
);

wire [7:0] w_rom_data;
ROM_Nx8 ROM(
    .address(w_counter[2:0]),
    .data(w_rom_data)
);
assign {w_instruction, w_data} = w_rom_data;

FSM_MicroInstr Controller(
    .clk(w_clock),
    .reset(w_reset),
    .IB_BUS(w_IB_BUS),
    .LatchA(w_LatchA),
    .EnableA(w_EnableA),
    .LatchB(w_LatchB),
    .EnableALU(w_EnableALU),
    .AddSub(w_AddSub),
    .EnableIN(w_EnableIN),
    .EnableOut(w_EnableOut),
    .LoadInstr(w_LoadInstr),
    .EnableInstr(w_EnableInstr),
    .ToInstr(w_ToInstr),
    .EnableCount(w_EnableCount)
);

// ============================================================
// === UART TRANSMITTER ===
// ============================================================
wire TxD;
assign GPIO[33] = TxD; // UART TX pin
wire TxD_start;
wire [7:0] TxD_data;
wire TxD_busy;

async_transmitter TX (
    .clk(MAX10_CLK1_50),
    .TxD(TxD),
    .TxD_start(TxD_start),
    .TxD_data(TxD_data),
    .TxD_busy(TxD_busy)
);

// ============================================================
// === UART SENDER FSM (External Module) ===
// ============================================================
wire [1:0] uart_state_dbg;

uart_send_fsm UART_FSM (
    .clk(MAX10_CLK1_50),
    .reset(w_reset),
    .enable_out(w_EnableOut),
    .data_in(w_rOut),
    .tx_busy(TxD_busy),
    .tx_start(TxD_start),
    .tx_data(TxD_data),
    .state_dbg(uart_state_dbg)
);



endmodule

`default_nettype wire
///////////////////////////////////----------------UART FSM-----------------/////////////////////////////////////////////
`default_nettype none

module uart_send_fsm(
    input wire clk,              // system clock (e.g., MAX10_CLK1_50)
    input wire reset,            // active-high reset
    input wire enable_out,       // signal to start sending
    input wire [3:0] data_in,    // 4-bit value to transmit
    input wire tx_busy,          // from async_transmitter
    output reg tx_start,         // to async_transmitter
    output reg [7:0] tx_data,    // to async_transmitter
    output reg [1:0] state_dbg   // for LED debug
);

// State encoding
localparam [1:0]
    UART_IDLE  = 2'b00,
    UART_SEND  = 2'b01,
    UART_WAIT  = 2'b10,
    UART_CR    = 2'b11;

reg [1:0] state = UART_IDLE;
reg [3:0] latched_data;
wire [7:0] ascii_data;

// Instantiate the nibble converter
nibble_to_ascii conv (
    .nib(latched_data),
    .ascii(ascii_data)
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state        <= UART_IDLE;
        tx_start     <= 1'b0;
        tx_data      <= 8'h00;
        latched_data <= 4'b0000;
    end else begin
        tx_start <= 1'b0; // default

        case (state)
            UART_IDLE: begin
                if (enable_out && !tx_busy) begin
                    latched_data <= data_in;
                    tx_data <= ascii_data; // Prepare data immediately
                    state <= UART_SEND;
                end
            end

            UART_SEND: begin
                // Send the start pulse
                tx_start <= 1'b1;
                state <= UART_WAIT;
            end

            UART_WAIT: begin
                // Wait for transmission to complete
                if (!tx_busy) begin
                    tx_data <= 8'h0D; // Prepare carriage return
                    state <= UART_CR;
                end
            end

            UART_CR: begin
                // Send carriage return
                tx_start <= 1'b1;
                state <= UART_IDLE;
            end
        endcase
    end
    state_dbg <= state;
end

endmodule

`default_nettype wire
////////////////////////////////////////-----------UART Drives------------///////////////////////////////////////////
////////////////////////////////////////////////////////
// RS-232 RX and TX module
// (c) fpga4fun.com & KNJN LLC - 2003 to 2016

// The RS-232 settings are fixed
// TX: 8-bit data, 2 stop, no-parity
// RX: 8-bit data, 1 stop, no-parity (the receiver can accept more stop bits of course)

//`define SIMULATION   // in this mode, TX outputs one bit per clock cycle
                       // and RX receives one bit per clock cycle (for fast simulations)

////////////////////////////////////////////////////////
module async_transmitter(
	input clk,
	input TxD_start,
	input [7:0] TxD_data,
	output TxD,
	output TxD_busy
);

// Assert TxD_start for (at least) one clock cycle to start transmission of TxD_data
// TxD_data is latched so that it doesn't have to stay valid while it is being sent

parameter ClkFrequency = 50000000;	// 50MHz
parameter Baud = 115200;

generate
	if(ClkFrequency<Baud*8 && (ClkFrequency % Baud!=0)) ASSERTION_ERROR PARAMETER_OUT_OF_RANGE("Frequency incompatible with requested Baud rate");
endgenerate

////////////////////////////////
`ifdef SIMULATION
wire BitTick = 1'b1;  // output one bit per clock cycle
`else
wire BitTick;
BaudTickGen #(ClkFrequency, Baud) tickgen(.clk(clk), .enable(TxD_busy), .tick(BitTick));
`endif

reg [3:0] TxD_state = 0;
wire TxD_ready = (TxD_state==0);
assign TxD_busy = ~TxD_ready;

reg [7:0] TxD_shift = 0;
always @(posedge clk)
begin
	if(TxD_ready & TxD_start)
		TxD_shift <= TxD_data;
	else
	if(TxD_state[3] & BitTick)
		TxD_shift <= (TxD_shift >> 1);

	case(TxD_state)
		4'b0000: if(TxD_start) TxD_state <= 4'b0100;
		4'b0100: if(BitTick) TxD_state <= 4'b1000;  // start bit
		4'b1000: if(BitTick) TxD_state <= 4'b1001;  // bit 0
		4'b1001: if(BitTick) TxD_state <= 4'b1010;  // bit 1
		4'b1010: if(BitTick) TxD_state <= 4'b1011;  // bit 2
		4'b1011: if(BitTick) TxD_state <= 4'b1100;  // bit 3
		4'b1100: if(BitTick) TxD_state <= 4'b1101;  // bit 4
		4'b1101: if(BitTick) TxD_state <= 4'b1110;  // bit 5
		4'b1110: if(BitTick) TxD_state <= 4'b1111;  // bit 6
		4'b1111: if(BitTick) TxD_state <= 4'b0010;  // bit 7
		4'b0010: if(BitTick) TxD_state <= 4'b0011;  // stop1
		4'b0011: if(BitTick) TxD_state <= 4'b0000;  // stop2
		default: if(BitTick) TxD_state <= 4'b0000;
	endcase
end

assign TxD = (TxD_state<4) | (TxD_state[3] & TxD_shift[0]);  // put together the start, data and stop bits
endmodule


////////////////////////////////////////////////////////
module async_receiver(
	input clk,
	input RxD,
	output reg RxD_data_ready = 0,
	output reg [7:0] RxD_data = 0,  // data received, valid only (for one clock cycle) when RxD_data_ready is asserted

	// We also detect if a gap occurs in the received stream of characters
	// That can be useful if multiple characters are sent in burst
	//  so that multiple characters can be treated as a "packet"
	output RxD_idle,  // asserted when no data has been received for a while
	output reg RxD_endofpacket = 0  // asserted for one clock cycle when a packet has been detected (i.e. RxD_idle is going high)
);

parameter ClkFrequency = 50000000; // 25MHz
parameter Baud = 115200;

parameter Oversampling = 8;  // needs to be a power of 2
// we oversample the RxD line at a fixed rate to capture each RxD data bit at the "right" time
// 8 times oversampling by default, use 16 for higher quality reception

generate
	if(ClkFrequency<Baud*Oversampling) ASSERTION_ERROR PARAMETER_OUT_OF_RANGE("Frequency too low for current Baud rate and oversampling");
	if(Oversampling<8 || ((Oversampling & (Oversampling-1))!=0)) ASSERTION_ERROR PARAMETER_OUT_OF_RANGE("Invalid oversampling value");
endgenerate

////////////////////////////////
reg [3:0] RxD_state = 0;

`ifdef SIMULATION
wire RxD_bit = RxD;
wire sampleNow = 1'b1;  // receive one bit per clock cycle

`else
wire OversamplingTick;
BaudTickGen #(ClkFrequency, Baud, Oversampling) tickgen(.clk(clk), .enable(1'b1), .tick(OversamplingTick));

// synchronize RxD to our clk domain
reg [1:0] RxD_sync = 2'b11;
always @(posedge clk) if(OversamplingTick) RxD_sync <= {RxD_sync[0], RxD};

// and filter it
reg [1:0] Filter_cnt = 2'b11;
reg RxD_bit = 1'b1;

always @(posedge clk)
if(OversamplingTick)
begin
	if(RxD_sync[1]==1'b1 && Filter_cnt!=2'b11) Filter_cnt <= Filter_cnt + 1'd1;
	else 
	if(RxD_sync[1]==1'b0 && Filter_cnt!=2'b00) Filter_cnt <= Filter_cnt - 1'd1;

	if(Filter_cnt==2'b11) RxD_bit <= 1'b1;
	else
	if(Filter_cnt==2'b00) RxD_bit <= 1'b0;
end

// and decide when is the good time to sample the RxD line
function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
localparam l2o = log2(Oversampling);
reg [l2o-2:0] OversamplingCnt = 0;
always @(posedge clk) if(OversamplingTick) OversamplingCnt <= (RxD_state==0) ? 1'd0 : OversamplingCnt + 1'd1;
wire sampleNow = OversamplingTick && (OversamplingCnt==Oversampling/2-1);
`endif

// now we can accumulate the RxD bits in a shift-register
always @(posedge clk)
case(RxD_state)
	4'b0000: if(~RxD_bit) RxD_state <= `ifdef SIMULATION 4'b1000 `else 4'b0001 `endif;  // start bit found?
	4'b0001: if(sampleNow) RxD_state <= 4'b1000;  // sync start bit to sampleNow
	4'b1000: if(sampleNow) RxD_state <= 4'b1001;  // bit 0
	4'b1001: if(sampleNow) RxD_state <= 4'b1010;  // bit 1
	4'b1010: if(sampleNow) RxD_state <= 4'b1011;  // bit 2
	4'b1011: if(sampleNow) RxD_state <= 4'b1100;  // bit 3
	4'b1100: if(sampleNow) RxD_state <= 4'b1101;  // bit 4
	4'b1101: if(sampleNow) RxD_state <= 4'b1110;  // bit 5
	4'b1110: if(sampleNow) RxD_state <= 4'b1111;  // bit 6
	4'b1111: if(sampleNow) RxD_state <= 4'b0010;  // bit 7
	4'b0010: if(sampleNow) RxD_state <= 4'b0000;  // stop bit
	default: RxD_state <= 4'b0000;
endcase

always @(posedge clk)
if(sampleNow && RxD_state[3]) RxD_data <= {RxD_bit, RxD_data[7:1]};

//reg RxD_data_error = 0;
always @(posedge clk)
begin
	RxD_data_ready <= (sampleNow && RxD_state==4'b0010 && RxD_bit);  // make sure a stop bit is received
	//RxD_data_error <= (sampleNow && RxD_state==4'b0010 && ~RxD_bit);  // error if a stop bit is not received
end

`ifdef SIMULATION
assign RxD_idle = 0;
`else
reg [l2o+1:0] GapCnt = 0;
always @(posedge clk) if (RxD_state!=0) GapCnt<=0; else if(OversamplingTick & ~GapCnt[log2(Oversampling)+1]) GapCnt <= GapCnt + 1'h1;
assign RxD_idle = GapCnt[l2o+1];
always @(posedge clk) RxD_endofpacket <= OversamplingTick & ~GapCnt[l2o+1] & &GapCnt[l2o:0];
`endif

endmodule


////////////////////////////////////////////////////////
// dummy module used to be able to raise an assertion in Verilog
module ASSERTION_ERROR();
endmodule


////////////////////////////////////////////////////////
module BaudTickGen(
	input clk, enable,
	output tick  // generate a tick at the specified baud rate * oversampling
);
parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 1;

function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
localparam AccWidth = log2(ClkFrequency/Baud)+8;  // +/- 2% max timing error over a byte
reg [AccWidth:0] Acc = 0;
localparam ShiftLimiter = log2(Baud*Oversampling >> (31-AccWidth));  // this makes sure Inc calculation doesn't overflow
localparam Inc = ((Baud*Oversampling << (AccWidth-ShiftLimiter))+(ClkFrequency>>(ShiftLimiter+1)))/(ClkFrequency>>ShiftLimiter);
always @(posedge clk) if(enable) Acc <= Acc[AccWidth-1:0] + Inc[AccWidth:0]; else Acc <= Inc[AccWidth:0];
assign tick = Acc[AccWidth];
endmodule


////////////////////////////////////////////////////////

