module ALU (
	input      [31:0] data1_i,
	input      [31:0] data2_i,
	input      [4:0]  shamt_i,
	input      [3:0]  ALU_control_i,
	output reg [31:0] result_o
);

localparam AND = 4'd0, OR = 4'd1, ADD = 4'd2, SUB = 4'd3, SLT = 4'd4, SLL = 4'd5, SRL = 4'd6, SRA = 4'd7, XOR = 4'd8, NOR = 4'd9;

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

endmodule