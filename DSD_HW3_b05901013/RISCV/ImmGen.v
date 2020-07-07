module ImmGen (
	input 	   [31:0] instruction_i,
	output reg [31:0] offset_o
);

always @(*) begin
	case (instruction_i[6:0]) //opcode
		7'b0000011, 7'b1100111: offset_o = {{21{instruction_i[31]}}, instruction_i[30:25], instruction_i[24:21], instruction_i[20]}; //lw: i-type
		7'b0100011: offset_o = {{21{instruction_i[31]}}, instruction_i[30:25], instruction_i[11:8], instruction_i[7]}; //sw: s-type
		7'b1100011: offset_o = {{20{instruction_i[31]}}, instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0}; //beq: b-type
		7'b1101111: offset_o = {{12{instruction_i[31]}}, instruction_i[19:12], instruction_i[20], instruction_i[30:25], instruction_i[24:21], 1'b0}; //jal: j-type
		default: 	offset_o = 32'b0;
	endcase
end

endmodule