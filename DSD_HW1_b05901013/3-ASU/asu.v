module asu (x, y, mode, carry, out);
input [7:0] x, y;
input mode;
output carry;
output [7:0] out;

/*Write your code here*/
	wire c;
	wire [7:0] w0, w1;

	adder ADDER(.x(x), .y(y), .carry(c), .out(w0));
	barrel_shifter SHIFTER(.in(x), .shift(y[2:0]), .out(w1));

	assign carry = (mode) ? c : 0;
	assign out = (mode) ? w0 : w1;

/*End of code*/


endmodule