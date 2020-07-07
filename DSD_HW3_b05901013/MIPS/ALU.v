module ALU (
	input  [31:0] data1_i,
	input  [31:0] data2_i,
	input  [3:0]  ALU_control_i,
	output [31:0] result_o,
	output zero_o
);

reg [31:0] output_r;

assign result_o = output_r;
assign zero_o = (output_r == 32'b0) ? 1 : 0;

always @(*) begin
	case (ALU_control_i)
		4'b0000: output_r = data1_i & data2_i;
		4'b0001: output_r = data1_i | data2_i;
		4'b0010: output_r = data1_i + data2_i;
		4'b0110: output_r = data1_i - data2_i;
		4'b0111: output_r = ($signed(data1_i) < $signed(data2_i)) ? 1 : 0;
		default: output_r = 32'b0;
	endcase
end

endmodule