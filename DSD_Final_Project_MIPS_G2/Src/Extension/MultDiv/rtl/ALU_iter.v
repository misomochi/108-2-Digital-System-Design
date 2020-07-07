//`include "multiplier.v"
`include "booth.v"
`include "divider.v"

module ALU (
	input			  clk,
	input			  rst_n,
	input			  read_reg,
	input      [31:0] data1_i,
	input      [31:0] data2_i,
	input       [4:0] shamt_i,
	input       [3:0] ALU_control_i,
	output		  	  stall_o,
	output	   [31:0] read_data_o,
	output reg [31:0] result_o
);

localparam AND = 4'd0, OR = 4'd1, ADD = 4'd2, SUB = 4'd3, SLT = 4'd4, SLL = 4'd5, SRL = 4'd6, SRA = 4'd7, XOR = 4'd8, NOR = 4'd9, MULT = 4'd10, DIV = 4'd11;
localparam STATE_NORM = 2'd0, STATE_MULT = 2'd1, STATE_DIV = 2'd2;

reg  		mult_start, next_mult_start, div_start, next_div_start, stall, next_stall;
reg   [1:0] state, next_state;
reg  [31:0] mult_data1, mult_data2, next_mult_data1, next_mult_data2, div_data1, div_data2, next_div_data1, next_div_data2;
reg  [31:0] HI, LO, next_HI, next_LO; //$HI, $LO are located directly in ALU

wire 		mult_done, div_done;
wire [31:0] quotient, remainder;
wire [63:0] product;

assign stall_o = stall;
assign read_data_o = (read_reg) ? HI : LO;

booth mult(.clk 		(clk),
		   .rst_n 		(rst_n),
		   .start 		(mult_start),
		   .multiplicand(mult_data1),
		   .multiplier  (mult_data2),
		   .done        (mult_done),
		   .product     (product));

/*multiplier mult(.clk 		 (clk),
				.rst_n 		 (rst_n),
				.start 		 (mult_start),
				.multiplicand(mult_data1),
				.multiplier  (mult_data2),
				.done        (mult_done),
				.product     (product));*/

divider div(.clk 	  (clk),
			.rst_n    (rst_n),
			.start 	  (div_start),
			.dividend (div_data1),
			.divisor  (div_data2),
			.done     (div_done),
			.quotient (quotient),
			.remainder(remainder));

always @(*) begin
	case (ALU_control_i)
		AND: result_o = data1_i & data2_i;
		OR:  result_o = data1_i | data2_i;
		ADD: result_o = data1_i + data2_i;
		SUB: result_o = data1_i - data2_i;
		SLT: result_o = ($signed(data1_i) < $signed(data2_i)) ? 1 : 0;
		SLL: result_o = data2_i << shamt_i; //$rt << shamt
		SRL: result_o = data2_i >> shamt_i; //$rt >> shamt
		SRA: result_o = $signed(data2_i) >>> shamt_i; //$rt shift right arithmetic
		XOR: result_o = data1_i ^ data2_i;
		NOR: result_o = ~(data1_i | data2_i);
		default : result_o = 32'b0;
	endcase
end

//next-state logic
always @(*) begin
	case (state)
		STATE_NORM: begin
			case (ALU_control_i)
				MULT: 	  next_state = STATE_MULT;
				DIV:  	  next_state = STATE_DIV;
				default : next_state = STATE_NORM;
			endcase
		end
		STATE_MULT: next_state = mult_done ? STATE_NORM : STATE_MULT;
		STATE_DIV: 	next_state = div_done  ? STATE_NORM : STATE_DIV;
		default : 	next_state = STATE_NORM;
	endcase
end

//output logic
always @(*) begin
	case (state)
		STATE_NORM: begin
			{next_HI, next_LO} = {HI, LO};
			case (ALU_control_i)
				MULT: begin
					next_stall 		= 1'b1;
					next_mult_start = 1'b1;
					next_div_start 	= 1'b0;
					next_mult_data1 = data1_i;
					next_mult_data2 = data2_i;
					next_div_data1  = 32'b0;
					next_div_data2  = 32'b0;
				end
				DIV: begin
					next_stall 		= 1'b1;
					next_mult_start = 1'b0;
					next_div_start 	= 1'b1;
					next_mult_data1 = 32'b0;
					next_mult_data2 = 32'b0;
					next_div_data1 	= data1_i;
					next_div_data2 	= data2_i;
				end
				default : begin
					next_stall 		= 1'b0;
					next_mult_start = 1'b0;
					next_div_start 	= 1'b0;
					next_mult_data1 = 32'b0;
					next_mult_data2 = 32'b0;
					next_div_data1  = 32'b0;
					next_div_data2  = 32'b0;
				end
			endcase
		end
		STATE_MULT: begin
			next_mult_start    = 1'b0;
			next_div_start 	   = 1'b0;
			next_mult_data1    = mult_data1;
			next_mult_data2    = mult_data2;
			next_div_data1     = 32'b0;
			next_div_data2     = 32'b0;
			next_stall		   = mult_done ? 1'b0 : 1'b1;
			{next_HI, next_LO} = mult_done ? product : {HI, LO};
		end
		STATE_DIV: begin
			next_mult_start    = 1'b0;
			next_div_start 	   = 1'b0;
			next_mult_data1    = 32'b0;
			next_mult_data2    = 32'b0;
			next_div_data1     = div_data1;
			next_div_data2     = div_data2;
			next_stall		   = div_done ? 1'b0 : 1'b1;
			{next_HI, next_LO} = div_done ? {remainder, quotient} : {HI, LO};
		end
		default : begin
			next_stall 		= 1'b0;
			next_mult_start = 1'b0;
			next_div_start 	= 1'b0;
			next_mult_data1 = 32'b0;
			next_mult_data2 = 32'b0;
			next_div_data1  = 32'b0;
			next_div_data2  = 32'b0;
			{next_HI, next_LO} = {HI, LO};
		end
	endcase
end

always @(posedge clk) begin
	if (~rst_n) begin
		state 	   <= STATE_NORM;
		mult_start <= 1'b0;
		div_start  <= 1'b0;
		stall 	   <= 1'b0;

		mult_data1 <= 32'b0;
		mult_data2 <= 32'b0;
		div_data1  <= 32'b0;
		div_data2  <= 32'b0;
		{HI, LO}   <= 64'b0;
	end
	else begin
		state 	   <= next_state;
		mult_start <= next_mult_start;
		div_start  <= next_div_start;
		stall 	   <= next_stall;

		mult_data1 <= next_mult_data1;
		mult_data2 <= next_mult_data2;
		div_data1  <= next_div_data1;
		div_data2  <= next_div_data2;
		{HI, LO}   <= {next_HI, next_LO};
	end
end

endmodule