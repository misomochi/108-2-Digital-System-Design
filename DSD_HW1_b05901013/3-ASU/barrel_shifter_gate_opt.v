module barrel_shifter_gate(in, shift, out);
input  [7:0] in;
input  [2:0] shift;
output [7:0] out;

/*Write your code here*/
	wire [7:0] w0, w1;

	level L0(.a(in), .b({in[6:0], 1'b0}), .shl(shift[0]), .y(w0));
	level L1(.a(w0), .b({w0[5:0], {2{1'b0}}}), .shl(shift[1]), .y(w1));
	level L2(.a(w1), .b({w1[3:0], {4{1'b0}}}), .shl(shift[2]), .y(out));

/*End of code*/
endmodule

module level (
	input [7:0] a,
	input [7:0] b,
	input shl,
	output [7:0] y
);
	mux MUX0(.x(y[0]), .a(a[0]), .b(b[0]), .sel(shl));
	mux MUX1(.x(y[1]), .a(a[1]), .b(b[1]), .sel(shl));
	mux MUX2(.x(y[2]), .a(a[2]), .b(b[2]), .sel(shl));
	mux MUX3(.x(y[3]), .a(a[3]), .b(b[3]), .sel(shl));
	mux MUX4(.x(y[4]), .a(a[4]), .b(b[4]), .sel(shl));
	mux MUX5(.x(y[5]), .a(a[5]), .b(b[5]), .sel(shl));
	mux MUX6(.x(y[6]), .a(a[6]), .b(b[6]), .sel(shl));
	mux MUX7(.x(y[7]), .a(a[7]), .b(b[7]), .sel(shl));

endmodule

module mux (x,a,b,sel);
input 	a,b,sel;
output 	x;
wire sel_i,w1,w2;

not #1 n0(sel_i,sel);
and #1 a1(w1,a,sel_i); //0
and #1 a2(w2,b,sel); //1
or #1 o1(x,w1,w2);

	
endmodule
