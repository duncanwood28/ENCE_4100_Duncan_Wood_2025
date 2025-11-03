
```verilog
////////////////////////////////////////--------------MAIN---------------////////////////////////////////////////////
`default_nettype none

module main(
	input		MAX10_CLK1_50,
	input		[1:0]		KEY,
	input		[9:0]		SW,
	inout		[35:0] 	GPIO,
	output	[9:0]		LEDR,
	output	[7:0]		HEX0,
	output	[7:0]		HEX1,
	output	[7:0]		HEX2,
	output	[7:0]		HEX4,
	output	[7:0]		HEX5
);
	
	localparam N = 4;

	// User Wires
	// ------------------------------
	wire w_clock = SW[9];
	wire w_reset = SW[8];
	
	wire [N-1:0] w_user_input = SW[3:0];
	
	wire w_carry;
	assign LEDR[9] = w_carry;
	
	wire [N-1:0] w_rOut;
	assign LEDR[3:0] = w_rOut;
	
	// DEBUG
	//assign LEDR[7:4] = w_AluA;
	
	// ------------------------------
	
	// Internal Wires
	// ------------------------------
	wire [N-1:0] w_IB_BUS;
	wire [N-1:0] w_AluA;
	wire [N-1:0] w_AluB;
	
	wire [N-1:0] w_counter;
	wire [N-1:0] w_data;
	wire [N-1:0] w_instruction;
	
	// ------------------------------
	
	// FSM CONTROL Wires
	// ------------------------------
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
	wire w_ProgCount;
	wire w_EnableCount;
	// ------------------------------
	
	
	// Accumulator A (default 4bits)
	Accumulator_A AccA(
		.MainClock(w_clock),
		.ClearA(w_reset),
		.LatchA(w_LatchA),  		// FSM CONTROL
		.EnableA(w_EnableA),  	// FSM CONTROL
		.A(w_IB_BUS),
		.IB_BUS(w_IB_BUS),
		.AluA(w_AluA)
	);
	
	seg7Decoder SEG1(
		.i_bin(w_AluA),
		.o_HEX(HEX1)
	);
	
	// Accumulator B (default 4bits)
	Accumulator_B AccB (
		.MainClock(w_clock),
		.ClearB(w_reset),
		.LatchB(w_LatchB),  // FSM CONTROL
		.B(w_IB_BUS),
		.AluB(w_AluB)
	);
	
	seg7Decoder SEG2(
		.i_bin(w_AluB),
		.o_HEX(HEX2)
	);
	
	
	// ALU (default 4bits)
	Arithmetic_Unit ALU (
		.EnableALU(w_EnableALU),  	// FSM CONTROL
		.AddSub(w_AddSub),  			// FSM CONTROL
		.A(w_AluA),
		.B(w_AluB),
		.Carry(w_carry),
		.IB_ALU(w_IB_BUS)
	);
	
	seg7Decoder SEG0(
		.i_bin(w_IB_BUS),
		.o_HEX(HEX0)
	);
	
	// Input Register (default 4bits)
	InRegister InReg(
		.EnableIN(w_EnableIN),  // FSM CONTROL
		.DataIn(w_user_input),
		.IB_BUS(w_IB_BUS)
	);
	
	seg7Decoder SEG4(
		.i_bin(w_user_input),
		.o_HEX(HEX4)
	);
	
	// Output Register (default 4bits)
	OutRegister OutReg(
		.MainClock(w_clock),
		.MainReset(w_reset),
		.EnableOut(w_EnableOut),  // FSM CONTROL
		.IB_BUS(w_IB_BUS),
		.rOut(w_rOut)
	);
	
	seg7Decoder SEG5(
		.i_bin(w_rOut),
		.o_HEX(HEX5)
	);
	
	
	// Instruction Register (default 4bits)
	InstructionReg InstrReg(
		.MainClock(w_clock),
		.ClearInstr(w_reset),
		.LatchInstr(w_LoadInstr),  	// FSM CONTROL
		.EnableInstr(w_EnableInstr), 	// FSM CONTROL 
		.Data(w_data),
		.Instr(w_instruction),
		.ToInstr(w_ToInstr),
		.IB_BUS(w_IB_BUS)
	);
	
	
	// Program Counter (default 4bits)
	ProgramCounter ProgCounter (
		.MainClock(w_clock),
		.EnableCount(w_EnableCount),  // FSM CONTROL
		.ClearCounter(w_reset),
		.Counter(w_counter)
	);
	
	// Memory ROM 8x8
	
	wire [7:0] w_rom_data;
	
	ROM_Nx8 ROM (
		.address(w_counter[2:0]),
		.data(w_rom_data)
	);
	
	assign {w_instruction, w_data} = w_rom_data;
	
	// Microinstructions (FSM)
	FSM_MicroInstr Controller (
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
endmodule

`default_nettype wire

//////////////////////////////-------------ACCUMULATOR A----------------///////////////////////////////////////////
`default_nettype none

module Accumulator_A #
(
	parameter N = 4
)
(
	input MainClock,
	input ClearA,
	input LatchA,
	input EnableA,
	input [N-1:0] A,
	output [N-1:0] IB_BUS,
	output reg [N-1:0] AluA
);

	// Sequential Logic
	always @(posedge MainClock) begin
		if(ClearA)
			AluA <= {N{1'b0}};
		else begin
			if(LatchA)
				AluA <= A;
		end
	end
	
	// Combinational Logic
	assign IB_BUS = (EnableA==1'b1) ? AluA: {N{1'bz}};

endmodule

`default_nettype wire
//////////////////////////////-------------ACCUMULATOR B----------------///////////////////////////////////////////
`default_nettype none

module Accumulator_B #
(
	parameter N = 4
)
(
	input MainClock,
	input ClearB,
	input LatchB,
	input [N-1:0] B,
	output reg [N-1:0] AluB
);

	always @(posedge MainClock) begin
		if(ClearB)
			AluB <= {N{1'b0}};
		else begin
			if(LatchB)
				AluB <= B;
		end
	end

endmodule

`default_nettype wire
//////////////////////////////-------------ARITHMETIC LOGIC UNIT----------------///////////////////////////////////////////
`default_nettype none

module Arithmetic_Unit #
(
	parameter N = 4
)
(
	input EnableALU,
	input AddSub,
	input [N-1:0] A,
	input [N-1:0] B,
	output reg Carry,
	output reg [N-1:0] IB_ALU
);

	always @(*) begin
		if (!EnableALU) begin
			IB_ALU = {N{1'bz}};
			Carry  = 0;
		end else begin
			if (AddSub == 1'b0) begin
				{Carry, IB_ALU} = A + B;     // Addition
			end else begin
				{Carry, IB_ALU} = A - B;     // Subtraction
			end
		end
	end

endmodule

`default_nettype wire
//////////////////////////////-------------IN REGISTER----------------///////////////////////////////////////////
`default_nettype none

module InRegister #
(
	parameter N = 4
)
(
	input EnableIN,
	input [N-1:0] DataIn,
	output [N-1:0] IB_BUS
);
	assign IB_BUS = (EnableIN) ? DataIn : {N{1'bz}};

endmodule

`default_nettype wire
//////////////////////////////-------------OUT REGISTER----------------///////////////////////////////////////////
`default_nettype none

module OutRegister #
(
	parameter N = 4
)
(
	input MainClock,
	input MainReset,
	input EnableOut,
	input [N-1:0] IB_BUS,
	output reg [N-1:0] rOut
);
	
	always @(posedge MainClock) begin
		if(MainReset)
			rOut <= {N{1'b0}};
		else begin
			if(EnableOut)
				rOut <= IB_BUS;
		end
	end	

endmodule

`default_nettype wire
//////////////////////////////-------------INSTRUCTION REGISTER----------------///////////////////////////////////////////
`default_nettype none

module InstructionReg #
(
	parameter N = 4
)
(
	input MainClock,
	input ClearInstr,
	input LatchInstr,
	input EnableInstr,
	input [N-1:0] Data,
	input [N-1:0] Instr,
	output reg [N-1:0] ToInstr,
	output [N-1:0] IB_BUS
);


	always @(posedge MainClock) begin
        if (ClearInstr)
            ToInstr <= {N{1'b0}};
        else if (LatchInstr)
            ToInstr <= Instr;
    end

   
    assign IB_BUS = (EnableInstr) ? Data : {N{1'bz}};

	
endmodule

`default_nettype wire
//////////////////////////////----------------PROGRAM COUNTER----------------///////////////////////////////////////////
`default_nettype none

module ProgramCounter #
(
	parameter N = 4
)
(
	input wire MainClock,
	input wire EnableCount,
	input wire ClearCounter,
	output reg [N-1:0] Counter
);

	always @(posedge MainClock) begin
		if (ClearCounter) begin
			Counter <= {N{1'b0}};               // Reset to 0
		end else if (EnableCount) begin
			Counter <= Counter + 1'b1;          // Increment by 1
		end
	end

endmodule

`default_nettype wire
//////////////////////////////-------------ROM MEMORY----------------///////////////////////////////////////////
`default_nettype none

module ROM_Nx8 #
(
	parameter N = 8
)
(
	input [$clog2(N)-1:0] address,
	output reg [7:0] data
);
	
	(* ramstyle = "logic" *) reg [7:0] rom [0:N-1];
	// Initialize memory
	initial begin
		rom[0] = 8'h55;
		rom[1] = 8'h12;
		rom[2] = 8'h30;
		rom[3] = 8'h28;
		rom[4] = 8'h30;
		rom[5] = 8'h40;
		rom[6] = 8'h13;
		rom[7] = 8'h30;
	end
	
	// Commbinational logic async
	always @(*) begin
		data = rom[address];
	end
	
endmodule

`default_nettype wire
//////////////////////////////-------------VSM FSM----------------///////////////////////////////////////////
`default_nettype none

module FSM_MicroInstr #
(
	parameter N = 4
)
(
	input clk,
	input reset,
	input [N-1:0] IB_BUS,
	
	output reg LatchA,
	output reg EnableA,
	output reg LatchB,
	output reg EnableALU,
	output reg AddSub,
	output reg EnableIN,
	output reg EnableOut,
	output reg LoadInstr,
	output reg EnableInstr,
	input [N-1:0]	ToInstr,
	output reg EnableCount
);

	reg [2:0] state, next_state;

	// States
	localparam [2:0] IDLE = 3'd0, PHASE_1 = 3'd1, PHASE_2 = 3'd2, PHASE_3 = 3'd3, PHASE_4 = 3'd4;

	// 1. State Register (sequential)
	always @(posedge clk) begin
		if(reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// 2. Next-State Logic (combinational)
	always @(*) begin
		
		next_state = state; // default: hold state
	
		case(state)
		
			IDLE: 
				begin		
					// Move to FETCH
					next_state = PHASE_1;
				end
			
			// FETCH Instruction
			PHASE_1:
				begin
					// Move to DECODE
					next_state = PHASE_2;
				end
			
			// DECODE Instruction	
			PHASE_2:
				begin
					// Move to EXECUTE A
					next_state = PHASE_3;
				end
				
			// EXECUTE A Instruction
			PHASE_3:
				begin
					// Move to EXECUTE B
					next_state = PHASE_4;
				end
			
			// EXECUTE B Instruction	
			PHASE_4:
				begin
					// Move to FETCH
					next_state = PHASE_1;
				end
				
			default: ;// None
		
		endcase
	end
	
	// 3. Output Logic (combinational)
	
	always @(*) begin
	
		// default all signals are zero
		LoadInstr 	= 1'b0;
		EnableInstr = 1'b0;
		LatchB 		= 1'b0;
		LatchA 		= 1'b0;
		EnableALU 	= 1'b0;
		EnableCount = 1'b0;
		AddSub		= 1'b0;
		EnableIN		= 1'b0;
		EnableA		= 1'b0;
		EnableOut	= 1'b0;
	
		case(state)
		
			IDLE: 
				begin
					// Initialize things if needed
				end
			
			// FETCH Instruction
			PHASE_1:
				begin
					LoadInstr = 1'b1;
				end
			
			// DECODE Instruction	
			PHASE_2:
				begin
				EnableCount = 1'b1;
				EnableInstr  = 1'b1;
				end
				
			// EXECUTE Instruction
			PHASE_3:
				begin	
					
					case(ToInstr)
						4'b0000: //NOP
							begin
								//NA
							end
						4'b0001: //ADD
							begin
								LatchB =1'b1;
								EnableInstr = 1'b1;
							end
						4'b0010: //SUB
							begin
								LatchB =1'b1;
								EnableInstr = 1'b1;
							end
						4'b0011: //OUT
							begin
								EnableOut = 1'b1;
								EnableA = 1'b1;
							end
						4'b0100: //IN
							begin
								LatchA = 1'b1;
								EnableIN = 1'b1;
							end
						4'b0101: //LDA
							begin
								LatchA = 1'b1;
								EnableInstr = 1'b1;
							end	
					
						
					endcase
					
				end
			
			// EXECUTE Instruction	
			PHASE_4:
				begin
					case(ToInstr)
						4'b0000: //NOP
							begin
								//NA
							end
						4'b0001: //ADD
							begin
								LatchA =1'b1;
								EnableALU = 1'b1;
							end
						4'b0010: //SUB
							begin
								LatchB =1'b1;
								EnableALU = 1'b1;
								AddSub = 1'b1;
							end
						4'b0011: //OUT
							begin
								//NA
							end
						4'b0100: //IN
							begin
								//NA
							end
						4'b0101: //LDA
							begin
								//NA
							end	
					
						
					endcase
				end
		
		endcase
	end

endmodule

`default_nettype wire

