module adder_gate(x, y, carry, out);
input [7:0] x, y;
output carry;
output [7:0] out;

/*Write your code here*/
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28;
	wire p0, p1, p2, p3, p4, p5, p6, p7;
	wire g0, g1, g2, g3, g4, g5, g6, g7;
	wire c2, c3, c4, c5, c6, c7;

	//carry look-ahead adder: http://www.eecs.umich.edu/courses/eecs370/eecs370.w20/resources/materials/17-FastAdders-ch06aplus.pdf
	half_adder HA0(.a(x[0]), .b(y[0]), .cin(0), .p(p0), .g(g0), .sum(out[0])); //c0 = 0
	//and #1 AND0(w0, p0, 0); //w0 == 0
	//or #1 OR0(c1, g0, w0); //c1 == g0
	half_adder HA1(.a(x[1]), .b(y[1]), .cin(g0), .p(p1), .g(g1), .sum(out[1])); //c1 = g0 + p0*c0 = g0
	and #1 AND1(w1, p1, g0);
	or #1 OR1(c2, g1, w1);
	half_adder HA2(.a(x[2]), .b(y[2]), .cin(c2), .p(p2), .g(g2), .sum(out[2])); //c2 = g1 + p1*c1 = g1 + p1*g0
	and #1 AND2(w2, p2, g1);
	and #1 AND3(w3, p2, p1, g0);
	or #1 OR2(c3, g2, w2, w3);
	half_adder HA3(.a(x[3]), .b(y[3]), .cin(c3), .p(p3), .g(g3), .sum(out[3])); //c3 = g2 + p2*c2 = g2 + p2*g1 + p2*p1*g0
	and #1 AND4(w4, p3, g2);
	and #1 AND5(w5, p3, p2, g1);
	and #1 AND6(w6, p3, p2, p1, g0);
	or #1 OR3(c4, g3, w4, w5, w6);
	half_adder HA4(.a(x[4]), .b(y[4]), .cin(c4), .p(p4), .g(g4), .sum(out[4])); //c4 = g3 + p3*c3 = g3 + p3*g2 + p3*p2*g1 + p3*p2*p1*g0
	and #1 AND7(w7, p4, g3);
	and #1 AND8(w8, p4, p3, g2);
	and #1 AND9(w9, p4, p3, p2, g1);
	and #1 AND10(w10, p4, p3, p2, p1, g0);
	or #1 OR4(c5, g4, w7, w8, w9, w10);
	half_adder HA5(.a(x[5]), .b(y[5]), .cin(c5), .p(p5), .g(g5), .sum(out[5])); //c5 = g4 + p4*c4 = g4 + p4*g3 + p4*p3*g2 + p4*p3*p2*g1 + p4*p3*p2*p1*g0
	and #1 AND11(w11, p5, g4);
	and #1 AND12(w12, p5, p4, g3);
	and #1 AND13(w13, p5, p4, p3, g2);
	and #1 AND14(w14, p5, p4, p3, p2, g1);
	and #1 AND15(w15, p5, p4, p3, p2, p1, g0);
	or #1 OR5(c6, g5, w11, w12, w13, w14, w15);
	half_adder HA6(.a(x[6]), .b(y[6]), .cin(c6), .p(p6), .g(g6), .sum(out[6])); //c6 = g5 + p5*c5 = g5 + p5*g4 + p5*p4*g3 + p5*p4*p3*g2 + p5*p4*p3*p2*g1 + p5*p4*p3*p2*p1*g0
	and #1 AND16(w16, p6, g5);
	and #1 AND17(w17, p6, p5, g4);
	and #1 AND18(w18, p6, p5, p4, g3);
	and #1 AND19(w19, p6, p5, p4, p3, g2);
	and #1 AND20(w20, p6, p5, p4, p3, p2, g1);
	and #1 AND21(w21, p6, p5, p4, p3, p2, p1, g0);
	or #1 OR6(c7, g6, w16, w17, w18, w19, w20, w21);
	half_adder HA7(.a(x[7]), .b(y[7]), .cin(c7), .p(p7), .g(g7), .sum(out[7])); //c7 = g6 + p6*c6 = g6 + p6*g5 + p6*p5*g4 + p6*p5*p4*g3 + p6*p5*p4*p3*g2 + p6*p5*p4*p3*p2*g1 + p6*p5*p4*p3*p2*p1*g0
	//carry = g7 + p7*c7 = g7 + p7*g6 + p7*p6*g5 + p7*p6*p5*g4 + p7*p6*p5*p4*g3 + p7*p6*p5*p4*p3*g2 + p7*p6*p5*p4*p3*p2*g1 + p7*p6*p5*p4*p3*p2*p1*g0
	and #1 AND22(w22, p7, g6);
	and #1 AND23(w23, p7, p6, g5);
	and #1 AND24(w24, p7, p6, p5, g4);
	and #1 AND25(w25, p7, p6, p5, p4, g3);
	and #1 AND26(w26, p7, p6, p5, p4, p3, g2);
	and #1 AND27(w27, p7, p6, p5, p4, p3, p2, g1);
	and #1 AND28(w28, p7, p6, p5, p4, p3, p2, p1, g0);
	or #1 OR7(carry, g7, w22, w23, w24, w25, w26, w27, w28);

/*End of code*/

endmodule

module half_adder (
	input a,
	input b,
	input cin,
	output p, //propagate
	output g, //generate
	output sum
);

	xor #1 U0(p, a, b);
	and #1 U1(g, a, b);
	xor #1 U2(sum, cin, p);

endmodule