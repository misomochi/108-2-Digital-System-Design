module barrel_shifter(in, shift, out);
input  [7:0] in;
input  [2:0] shift;
output [7:0] out;

/*Write your code here*/
	wire [7:0] w0, w1;

	assign w0 = (shift[0]) ? in << 1 : in;
	assign w1 = (shift[1]) ? w0 << 2 : w0;
	assign out = (shift[2]) ? w1 << 4 : w1;

/*End of code*/
endmodule