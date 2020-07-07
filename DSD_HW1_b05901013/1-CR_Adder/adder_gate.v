module adder_gate(x, y, carry, out);
input [7:0] x, y;
output carry;
output [7:0] out;

/*Write your code here*/
	wire w0, w1, w2, w3, w4, w5, w6;

	FA FA0(.a(x[0]), .b(y[0]), .ci(0), .sum(out[0]), .co(w0));
	FA FA1(.a(x[1]), .b(y[1]), .ci(w0), .sum(out[1]), .co(w1));
	FA FA2(.a(x[2]), .b(y[2]), .ci(w1), .sum(out[2]), .co(w2));
	FA FA3(.a(x[3]), .b(y[3]), .ci(w2), .sum(out[3]), .co(w3));
	FA FA4(.a(x[4]), .b(y[4]), .ci(w3), .sum(out[4]), .co(w4));
	FA FA5(.a(x[5]), .b(y[5]), .ci(w4), .sum(out[5]), .co(w5));
	FA FA6(.a(x[6]), .b(y[6]), .ci(w5), .sum(out[6]), .co(w6));
	FA FA7(.a(x[7]), .b(y[7]), .ci(w6), .sum(out[7]), .co(carry));
/*End of code*/

endmodule

module FA (
	input a,    // Clock
	input b, // Clock Enable
	input ci,  // Asynchronous reset active low
	output sum,
	output co	
);
	wire w0, w1, w2;

	//sum = a ^ b ^ carry-in
	xor #1 U0(sum, a, b, ci);
	//carry-out = (a && b) || (b && carry-in) || (carry-in && a)
	and	#1 U1(w0, a, b);
	and	#1 U2(w1, b, ci);
	and	#1 U3(w2, ci, a);
	or #1 U4(co, w0, w1, w2);

endmodule