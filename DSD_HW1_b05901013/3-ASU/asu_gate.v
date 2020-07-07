module asu_gate (x, y, mode, carry, out);
input [7:0] x, y;
input mode;
output carry;
output [7:0] out;

/*Write your code here*/
	wire c;
	wire [7:0] w0, w1;

	adder_gate ADDER(.x(x), .y(y), .carry(c), .out(w0));
	barrel_shifter_gate SHIFTER(.in(x), .shift(y[2:0]), .out(w1));
	mode_mux MUX(.a(w1), .b(w0), .cin(c), .mode(mode), .out(out), .cout(carry));

/*End of code*/


endmodule

module mode_mux (
	input [7:0] a,
	input [7:0] b,
	input cin,
	input mode,
	output [7:0] out,
	output cout
);
	wire mode_i, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18;

	not n1(mode_i, mode);
	//out
	and a0_1(w1, a[0], mode_i); //0: shifter
	and a0_2(w2, b[0], mode); //1: adder
	or #2.5 o1(out[0], w1, w2);
	and a1_1(w3, a[1], mode_i); //0
	and a1_2(w4, b[1], mode); //1
	or #2.5 o2(out[1], w3, w4);
	and a2_1(w5, a[2], mode_i); //0
	and a2_2(w6, b[2], mode); //1
	or #2.5 o3(out[2], w5, w6);
	and a3_1(w7, a[3], mode_i); //0
	and a3_2(w8, b[3], mode); //1
	or #2.5 o4(out[3], w7, w8);
	and a4_1(w9, a[4], mode_i); //0
	and a4_2(w10, b[4], mode); //1
	or #2.5 o5(out[4], w9, w10);
	and a5_1(w11, a[5], mode_i); //0
	and a5_2(w12, b[5], mode); //1
	or #2.5 o6(out[5], w11, w12);
	and a6_1(w13, a[6], mode_i); //0
	and a6_2(w14, b[6], mode); //1
	or #2.5 o7(out[6], w13, w14);
	and a7_1(w15, a[7], mode_i); //0
	and a7_2(w16, b[7], mode); //1
	or #2.5 o8(out[7], w15, w16);
	//carry
	and ac_1(w17, 0, mode_i); //0
	and ac_2(w18, cin, mode); //1
	or #2.5 o9(cout, w17, w18);

endmodule