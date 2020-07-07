module ALU (
	input  [3:0]  ctrl_i,
	input  [31:0] data1_i,
	input  [31:0] data2_i,
	output [31:0] ALU_result_o,
	output 		  zero_o
);

reg [31:0] result_r;

assign ALU_result_o = result_r;
assign zero_o = (result_r == 32'b0) ? 1 : 0;

always @(*) begin
	case (ctrl_i)
		4'b0000: result_r = data1_i & data2_i;
		4'b0001: result_r = data1_i | data2_i;
		4'b0010: result_r = data1_i + data2_i;
		4'b0110: result_r = data1_i - data2_i;
		4'b1000: result_r = ($signed(data1_i) < $signed(data2_i)) ? 1 : 0;
		default: result_r = 32'b0;
	endcase
end

endmodule