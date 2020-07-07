module ALU ( out , mode , in_a , in_b  );

input mode;
input  [7:0] in_a , in_b;
output [8:0] out;

reg [8:0] out;

always @(*) begin
	case (mode)
		1'b0: out = in_a + in_b;
		1'b1: out = $signed(in_a) + $signed(in_b);
		default : out = in_a + in_b;
	endcase
end

endmodule
