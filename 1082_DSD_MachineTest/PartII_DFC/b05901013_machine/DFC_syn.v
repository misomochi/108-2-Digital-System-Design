/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : N-2017.09-SP2
// Date      : Thu Jun  4 16:48:12 2020
/////////////////////////////////////////////////////////////


module ALU_0_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  XOR3X1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .Y(SUM[8]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_0_DW01_add_1 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_0 ( out, mode, in_a, in_b );
  output [8:0] out;
  input [7:0] in_a;
  input [7:0] in_b;
  input mode;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, N20, n1;

  ALU_0_DW01_add_0 add_12 ( .A({in_a[7], in_a}), .B({in_b[7], in_b}), .CI(1'b0), .SUM({N20, N19, N18, N17, N16, N15, N14, N13, N12}) );
  ALU_0_DW01_add_1 add_11 ( .A({1'b0, in_a}), .B({1'b0, in_b}), .CI(1'b0), 
        .SUM({N11, N10, N9, N8, N7, N6, N5, N4, N3}) );
  AO22X1 U3 ( .A0(N6), .A1(n1), .B0(N15), .B1(mode), .Y(out[3]) );
  AO22X1 U4 ( .A0(N7), .A1(n1), .B0(N16), .B1(mode), .Y(out[4]) );
  AO22X1 U5 ( .A0(N8), .A1(n1), .B0(N17), .B1(mode), .Y(out[5]) );
  AO22X1 U6 ( .A0(N9), .A1(n1), .B0(N18), .B1(mode), .Y(out[6]) );
  AO22X1 U7 ( .A0(mode), .A1(N20), .B0(N11), .B1(n1), .Y(out[8]) );
  AO22X1 U8 ( .A0(N19), .A1(mode), .B0(N10), .B1(n1), .Y(out[7]) );
  AO22X1 U9 ( .A0(N3), .A1(n1), .B0(N12), .B1(mode), .Y(out[0]) );
  AO22X1 U10 ( .A0(N4), .A1(n1), .B0(N13), .B1(mode), .Y(out[1]) );
  AO22X1 U11 ( .A0(N5), .A1(n1), .B0(N14), .B1(mode), .Y(out[2]) );
  INVX3 U12 ( .A(mode), .Y(n1) );
endmodule


module ALU_3_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  XOR3X1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .Y(SUM[8]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_3_DW01_add_1 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_3 ( out, mode, in_a, in_b );
  output [8:0] out;
  input [7:0] in_a;
  input [7:0] in_b;
  input mode;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, N20, n1;

  ALU_3_DW01_add_0 add_12 ( .A({in_a[7], in_a}), .B({in_b[7], in_b}), .CI(1'b0), .SUM({N20, N19, N18, N17, N16, N15, N14, N13, N12}) );
  ALU_3_DW01_add_1 add_11 ( .A({1'b0, in_a}), .B({1'b0, in_b}), .CI(1'b0), 
        .SUM({N11, N10, N9, N8, N7, N6, N5, N4, N3}) );
  AO22X1 U3 ( .A0(N6), .A1(n1), .B0(N15), .B1(mode), .Y(out[3]) );
  AO22X1 U4 ( .A0(N7), .A1(n1), .B0(N16), .B1(mode), .Y(out[4]) );
  AO22X1 U5 ( .A0(N8), .A1(n1), .B0(N17), .B1(mode), .Y(out[5]) );
  AO22X1 U6 ( .A0(N9), .A1(n1), .B0(N18), .B1(mode), .Y(out[6]) );
  AO22X1 U7 ( .A0(mode), .A1(N20), .B0(N11), .B1(n1), .Y(out[8]) );
  AO22X1 U8 ( .A0(N19), .A1(mode), .B0(N10), .B1(n1), .Y(out[7]) );
  AO22X1 U9 ( .A0(N3), .A1(n1), .B0(N12), .B1(mode), .Y(out[0]) );
  AO22X1 U10 ( .A0(N4), .A1(n1), .B0(N13), .B1(mode), .Y(out[1]) );
  AO22X1 U11 ( .A0(N5), .A1(n1), .B0(N14), .B1(mode), .Y(out[2]) );
  INVX3 U12 ( .A(mode), .Y(n1) );
endmodule


module ALU_2_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  XOR3X1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .Y(SUM[8]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_2_DW01_add_1 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_2 ( out, mode, in_a, in_b );
  output [8:0] out;
  input [7:0] in_a;
  input [7:0] in_b;
  input mode;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, N20, n1;

  ALU_2_DW01_add_0 add_12 ( .A({in_a[7], in_a}), .B({in_b[7], in_b}), .CI(1'b0), .SUM({N20, N19, N18, N17, N16, N15, N14, N13, N12}) );
  ALU_2_DW01_add_1 add_11 ( .A({1'b0, in_a}), .B({1'b0, in_b}), .CI(1'b0), 
        .SUM({N11, N10, N9, N8, N7, N6, N5, N4, N3}) );
  AO22X1 U3 ( .A0(N6), .A1(n1), .B0(N15), .B1(mode), .Y(out[3]) );
  AO22X1 U4 ( .A0(N7), .A1(n1), .B0(N16), .B1(mode), .Y(out[4]) );
  AO22X1 U5 ( .A0(N8), .A1(n1), .B0(N17), .B1(mode), .Y(out[5]) );
  AO22X1 U6 ( .A0(N9), .A1(n1), .B0(N18), .B1(mode), .Y(out[6]) );
  AO22X1 U7 ( .A0(mode), .A1(N20), .B0(N11), .B1(n1), .Y(out[8]) );
  AO22X1 U8 ( .A0(N19), .A1(mode), .B0(N10), .B1(n1), .Y(out[7]) );
  AO22X1 U9 ( .A0(N3), .A1(n1), .B0(N12), .B1(mode), .Y(out[0]) );
  AO22X1 U10 ( .A0(N4), .A1(n1), .B0(N13), .B1(mode), .Y(out[1]) );
  AO22X1 U11 ( .A0(N5), .A1(n1), .B0(N14), .B1(mode), .Y(out[2]) );
  INVX3 U12 ( .A(mode), .Y(n1) );
endmodule


module ALU_1_DW01_add_0 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7])
         );
  XOR3X1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .Y(SUM[8]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_1_DW01_add_1 ( A, B, CI, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [8:1] carry;

  ADDFXL U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFXL U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFXL U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFXL U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFXL U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFXL U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFXL U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module ALU_1 ( out, mode, in_a, in_b );
  output [8:0] out;
  input [7:0] in_a;
  input [7:0] in_b;
  input mode;
  wire   N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
         N18, N19, N20, n1;

  ALU_1_DW01_add_0 add_12 ( .A({in_a[7], in_a}), .B({in_b[7], in_b}), .CI(1'b0), .SUM({N20, N19, N18, N17, N16, N15, N14, N13, N12}) );
  ALU_1_DW01_add_1 add_11 ( .A({1'b0, in_a}), .B({1'b0, in_b}), .CI(1'b0), 
        .SUM({N11, N10, N9, N8, N7, N6, N5, N4, N3}) );
  AO22X1 U3 ( .A0(N5), .A1(n1), .B0(N14), .B1(mode), .Y(out[2]) );
  AO22X1 U4 ( .A0(N6), .A1(n1), .B0(N15), .B1(mode), .Y(out[3]) );
  AO22X1 U5 ( .A0(N7), .A1(n1), .B0(N16), .B1(mode), .Y(out[4]) );
  AO22X1 U6 ( .A0(N8), .A1(n1), .B0(N17), .B1(mode), .Y(out[5]) );
  AO22X1 U7 ( .A0(N9), .A1(n1), .B0(N18), .B1(mode), .Y(out[6]) );
  AO22X1 U8 ( .A0(mode), .A1(N20), .B0(N11), .B1(n1), .Y(out[8]) );
  AO22X1 U9 ( .A0(N19), .A1(mode), .B0(N10), .B1(n1), .Y(out[7]) );
  AO22X1 U10 ( .A0(N3), .A1(n1), .B0(N12), .B1(mode), .Y(out[0]) );
  AO22X1 U11 ( .A0(N4), .A1(n1), .B0(N13), .B1(mode), .Y(out[1]) );
  INVX3 U12 ( .A(mode), .Y(n1) );
endmodule


module DFC_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  ADDHXL U1_1_30 ( .A(A[30]), .B(carry[30]), .CO(carry[31]), .S(SUM[30]) );
  ADDHXL U1_1_29 ( .A(A[29]), .B(carry[29]), .CO(carry[30]), .S(SUM[29]) );
  ADDHXL U1_1_28 ( .A(A[28]), .B(carry[28]), .CO(carry[29]), .S(SUM[28]) );
  ADDHXL U1_1_27 ( .A(A[27]), .B(carry[27]), .CO(carry[28]), .S(SUM[27]) );
  ADDHXL U1_1_26 ( .A(A[26]), .B(carry[26]), .CO(carry[27]), .S(SUM[26]) );
  ADDHXL U1_1_25 ( .A(A[25]), .B(carry[25]), .CO(carry[26]), .S(SUM[25]) );
  ADDHXL U1_1_24 ( .A(A[24]), .B(carry[24]), .CO(carry[25]), .S(SUM[24]) );
  ADDHXL U1_1_23 ( .A(A[23]), .B(carry[23]), .CO(carry[24]), .S(SUM[23]) );
  ADDHXL U1_1_22 ( .A(A[22]), .B(carry[22]), .CO(carry[23]), .S(SUM[22]) );
  ADDHXL U1_1_21 ( .A(A[21]), .B(carry[21]), .CO(carry[22]), .S(SUM[21]) );
  ADDHXL U1_1_20 ( .A(A[20]), .B(carry[20]), .CO(carry[21]), .S(SUM[20]) );
  ADDHXL U1_1_19 ( .A(A[19]), .B(carry[19]), .CO(carry[20]), .S(SUM[19]) );
  ADDHXL U1_1_18 ( .A(A[18]), .B(carry[18]), .CO(carry[19]), .S(SUM[18]) );
  ADDHXL U1_1_17 ( .A(A[17]), .B(carry[17]), .CO(carry[18]), .S(SUM[17]) );
  ADDHXL U1_1_16 ( .A(A[16]), .B(carry[16]), .CO(carry[17]), .S(SUM[16]) );
  ADDHXL U1_1_15 ( .A(A[15]), .B(carry[15]), .CO(carry[16]), .S(SUM[15]) );
  ADDHXL U1_1_14 ( .A(A[14]), .B(carry[14]), .CO(carry[15]), .S(SUM[14]) );
  ADDHXL U1_1_13 ( .A(A[13]), .B(carry[13]), .CO(carry[14]), .S(SUM[13]) );
  ADDHXL U1_1_12 ( .A(A[12]), .B(carry[12]), .CO(carry[13]), .S(SUM[12]) );
  ADDHXL U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHXL U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  ADDHXL U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  ADDHXL U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  ADDHXL U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHXL U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHXL U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHXL U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  XOR2X1 U1 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module DFC ( clk, reset, datain, cmd, cmd_valid, dataout, output_valid, busy
 );
  input [7:0] datain;
  input [1:0] cmd;
  output [8:0] dataout;
  input clk, reset, cmd_valid;
  output output_valid, busy;
  wire   N135, N136, n527, \calculated_buf[0][8] , \calculated_buf[0][7] ,
         \calculated_buf[0][6] , \calculated_buf[0][5] ,
         \calculated_buf[0][4] , \calculated_buf[0][3] ,
         \calculated_buf[0][2] , \calculated_buf[0][1] ,
         \calculated_buf[0][0] , \calculated_buf[1][8] ,
         \calculated_buf[1][7] , \calculated_buf[1][6] ,
         \calculated_buf[1][5] , \calculated_buf[1][4] ,
         \calculated_buf[1][3] , \calculated_buf[1][2] ,
         \calculated_buf[1][1] , \calculated_buf[1][0] ,
         \calculated_buf[2][8] , \calculated_buf[2][7] ,
         \calculated_buf[2][6] , \calculated_buf[2][5] ,
         \calculated_buf[2][4] , \calculated_buf[2][3] ,
         \calculated_buf[2][2] , \calculated_buf[2][1] ,
         \calculated_buf[2][0] , \calculated_buf[3][8] ,
         \calculated_buf[3][7] , \calculated_buf[3][6] ,
         \calculated_buf[3][5] , \calculated_buf[3][4] ,
         \calculated_buf[3][3] , \calculated_buf[3][2] ,
         \calculated_buf[3][1] , \calculated_buf[3][0] , \data_buf[0][7] ,
         \data_buf[0][6] , \data_buf[0][5] , \data_buf[0][4] ,
         \data_buf[0][3] , \data_buf[0][2] , \data_buf[0][1] ,
         \data_buf[0][0] , \data_buf[1][7] , \data_buf[1][6] ,
         \data_buf[1][5] , \data_buf[1][4] , \data_buf[1][3] ,
         \data_buf[1][2] , \data_buf[1][1] , \data_buf[1][0] ,
         \data_buf[2][7] , \data_buf[2][6] , \data_buf[2][5] ,
         \data_buf[2][4] , \data_buf[2][3] , \data_buf[2][2] ,
         \data_buf[2][1] , \data_buf[2][0] , \data_buf[3][7] ,
         \data_buf[3][6] , \data_buf[3][5] , \data_buf[3][4] ,
         \data_buf[3][3] , \data_buf[3][2] , \data_buf[3][1] ,
         \data_buf[3][0] , \data_buf[4][7] , \data_buf[4][6] ,
         \data_buf[4][5] , \data_buf[4][4] , \data_buf[4][3] ,
         \data_buf[4][2] , \data_buf[4][1] , \data_buf[4][0] ,
         \data_buf[5][7] , \data_buf[5][6] , \data_buf[5][5] ,
         \data_buf[5][4] , \data_buf[5][3] , \data_buf[5][2] ,
         \data_buf[5][1] , \data_buf[5][0] , \data_buf[6][7] ,
         \data_buf[6][6] , \data_buf[6][5] , \data_buf[6][4] ,
         \data_buf[6][3] , \data_buf[6][2] , \data_buf[6][1] ,
         \data_buf[6][0] , \data_buf[7][7] , \data_buf[7][6] ,
         \data_buf[7][5] , \data_buf[7][4] , \data_buf[7][3] ,
         \data_buf[7][2] , \data_buf[7][1] , \data_buf[7][0] , \y[0][8] ,
         \y[0][7] , \y[0][6] , \y[0][5] , \y[0][4] , \y[0][3] , \y[0][2] ,
         \y[0][1] , \y[0][0] , \y[1][8] , \y[1][7] , \y[1][6] , \y[1][5] ,
         \y[1][4] , \y[1][3] , \y[1][2] , \y[1][1] , \y[1][0] , \y[2][8] ,
         \y[2][7] , \y[2][6] , \y[2][5] , \y[2][4] , \y[2][3] , \y[2][2] ,
         \y[2][1] , \y[2][0] , \y[3][8] , \y[3][7] , \y[3][6] , \y[3][5] ,
         \y[3][4] , \y[3][3] , \y[3][2] , \y[3][1] , \y[3][0] , N255, N256,
         N257, N258, N259, N260, N261, N262, N263, N264, N265, N266, N267,
         N268, N269, N270, N271, N272, N273, N274, N275, N276, N277, N278,
         N279, N280, N281, N282, N283, N284, N285, N286, N386, N387, N388,
         N389, N390, N391, N392, N393, N394, N545, N546, N547, N548, N549,
         N550, N551, N552, N553, N702, N703, N704, N705, N706, N707, N708,
         N709, N710, N743, N744, N745, N746, N747, N748, N749, N750, N751,
         N784, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n216,
         n218, n220, n222, n224, n226, n228, n230, n232, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n244, n245, n246,
         n247, n248, n249, n250, n251, n252, n253, n254, n255, n256, n257,
         n258, n259, n260, n261, n262, n263, n264, n265, n266, n267, n268,
         n269, n270, n271, n272, n273, n274, n275, n276, n277, n278, n279,
         n280, n281, n282, n283, n284, n285, n286, n287, n288, n289, n290,
         n291, n292, n293, n294, n295, n296, n297, n298, n299, n300, n301,
         n302, n303, n304, n305, n306, n307, n308, n309, n310, n311, n312,
         n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323,
         n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434,
         n435, n436, n437, n438, n439, n440, n441, n442, n443, n444, n445,
         n446, n447, n448, n449, n450, n451, n452, n453, n454, n455, n456,
         n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, n467,
         n468, n469, n470, n471, n472, n473, n474, n475, n476, n477, n478,
         n479, n480, n481, n482, n483, n484, n485, n486, n487, n488, n489,
         n490, n491, n492, n493, n494, n495, n496, n497, n498, n499, n500,
         n501, n502, n503, n504, n505, n506, n507, n508, n509, n510, n511,
         n512, n513, n514, n515, n516, n517, n518, n519, n520, n521, n522,
         n523, n524, n525, n526;
  wire   [2:0] state;
  wire   [2:0] nxt_state;
  wire   [31:0] count;

  ALU_0 A1 ( .out({\calculated_buf[0][8] , \calculated_buf[0][7] , 
        \calculated_buf[0][6] , \calculated_buf[0][5] , \calculated_buf[0][4] , 
        \calculated_buf[0][3] , \calculated_buf[0][2] , \calculated_buf[0][1] , 
        \calculated_buf[0][0] }), .mode(1'b1), .in_a({\data_buf[0][7] , 
        \data_buf[0][6] , \data_buf[0][5] , \data_buf[0][4] , \data_buf[0][3] , 
        \data_buf[0][2] , \data_buf[0][1] , \data_buf[0][0] }), .in_b({
        \data_buf[4][7] , \data_buf[4][6] , \data_buf[4][5] , \data_buf[4][4] , 
        \data_buf[4][3] , \data_buf[4][2] , \data_buf[4][1] , \data_buf[4][0] }) );
  ALU_3 A2 ( .out({\calculated_buf[1][8] , \calculated_buf[1][7] , 
        \calculated_buf[1][6] , \calculated_buf[1][5] , \calculated_buf[1][4] , 
        \calculated_buf[1][3] , \calculated_buf[1][2] , \calculated_buf[1][1] , 
        \calculated_buf[1][0] }), .mode(1'b1), .in_a({\data_buf[1][7] , 
        \data_buf[1][6] , \data_buf[1][5] , \data_buf[1][4] , \data_buf[1][3] , 
        \data_buf[1][2] , \data_buf[1][1] , \data_buf[1][0] }), .in_b({
        \data_buf[5][7] , \data_buf[5][6] , \data_buf[5][5] , \data_buf[5][4] , 
        \data_buf[5][3] , \data_buf[5][2] , \data_buf[5][1] , \data_buf[5][0] }) );
  ALU_2 A3 ( .out({\calculated_buf[2][8] , \calculated_buf[2][7] , 
        \calculated_buf[2][6] , \calculated_buf[2][5] , \calculated_buf[2][4] , 
        \calculated_buf[2][3] , \calculated_buf[2][2] , \calculated_buf[2][1] , 
        \calculated_buf[2][0] }), .mode(1'b1), .in_a({\data_buf[2][7] , 
        \data_buf[2][6] , \data_buf[2][5] , \data_buf[2][4] , \data_buf[2][3] , 
        \data_buf[2][2] , \data_buf[2][1] , \data_buf[2][0] }), .in_b({
        \data_buf[6][7] , \data_buf[6][6] , \data_buf[6][5] , \data_buf[6][4] , 
        \data_buf[6][3] , \data_buf[6][2] , \data_buf[6][1] , \data_buf[6][0] }) );
  ALU_1 A4 ( .out({\calculated_buf[3][8] , \calculated_buf[3][7] , 
        \calculated_buf[3][6] , \calculated_buf[3][5] , \calculated_buf[3][4] , 
        \calculated_buf[3][3] , \calculated_buf[3][2] , \calculated_buf[3][1] , 
        \calculated_buf[3][0] }), .mode(1'b1), .in_a({\data_buf[3][7] , 
        \data_buf[3][6] , \data_buf[3][5] , \data_buf[3][4] , \data_buf[3][3] , 
        \data_buf[3][2] , \data_buf[3][1] , \data_buf[3][0] }), .in_b({
        \data_buf[7][7] , \data_buf[7][6] , \data_buf[7][5] , \data_buf[7][4] , 
        \data_buf[7][3] , \data_buf[7][2] , \data_buf[7][1] , \data_buf[7][0] }) );
  DFC_DW01_inc_0 r338 ( .A({count[31:2], N136, N135}), .SUM({N286, N285, N284, 
        N283, N282, N281, N280, N279, N278, N277, N276, N275, N274, N273, N272, 
        N271, N270, N269, N268, N267, N266, N265, N264, N263, N262, N261, N260, 
        N259, N258, N257, N256, N255}) );
  DFFRX1 \y_reg[1][8]  ( .D(n154), .CK(clk), .RN(n325), .Q(\y[1][8] ), .QN(
        n516) );
  DFFRX1 \y_reg[1][7]  ( .D(n155), .CK(clk), .RN(n325), .Q(\y[1][7] ), .QN(
        n515) );
  DFFRX1 \y_reg[1][6]  ( .D(n156), .CK(clk), .RN(n325), .Q(\y[1][6] ), .QN(
        n514) );
  DFFRX1 \y_reg[1][5]  ( .D(n157), .CK(clk), .RN(n325), .Q(\y[1][5] ), .QN(
        n513) );
  DFFRX1 \y_reg[1][4]  ( .D(n158), .CK(clk), .RN(n325), .Q(\y[1][4] ), .QN(
        n512) );
  DFFRX1 \y_reg[1][3]  ( .D(n159), .CK(clk), .RN(n325), .Q(\y[1][3] ), .QN(
        n511) );
  DFFRX1 \y_reg[1][2]  ( .D(n160), .CK(clk), .RN(n325), .Q(\y[1][2] ), .QN(
        n510) );
  DFFRX1 \y_reg[1][1]  ( .D(n161), .CK(clk), .RN(n324), .Q(\y[1][1] ), .QN(
        n509) );
  DFFRX1 \y_reg[1][0]  ( .D(n162), .CK(clk), .RN(n324), .Q(\y[1][0] ), .QN(
        n508) );
  DFFRX1 \y_reg[2][8]  ( .D(n163), .CK(clk), .RN(n324), .Q(\y[2][8] ), .QN(
        n507) );
  DFFRX1 \y_reg[2][7]  ( .D(n164), .CK(clk), .RN(n324), .Q(\y[2][7] ), .QN(
        n506) );
  DFFRX1 \y_reg[2][6]  ( .D(n165), .CK(clk), .RN(n324), .Q(\y[2][6] ), .QN(
        n505) );
  DFFRX1 \y_reg[2][5]  ( .D(n166), .CK(clk), .RN(n324), .Q(\y[2][5] ), .QN(
        n504) );
  DFFRX1 \y_reg[2][4]  ( .D(n167), .CK(clk), .RN(n324), .Q(\y[2][4] ), .QN(
        n503) );
  DFFRX1 \y_reg[2][3]  ( .D(n168), .CK(clk), .RN(n324), .Q(\y[2][3] ), .QN(
        n502) );
  DFFRX1 \y_reg[2][2]  ( .D(n169), .CK(clk), .RN(n324), .Q(\y[2][2] ), .QN(
        n501) );
  DFFRX1 \y_reg[2][1]  ( .D(n170), .CK(clk), .RN(n324), .Q(\y[2][1] ), .QN(
        n500) );
  DFFRX1 \y_reg[2][0]  ( .D(n171), .CK(clk), .RN(n324), .Q(\y[2][0] ), .QN(
        n499) );
  DFFRX1 \y_reg[3][8]  ( .D(n172), .CK(clk), .RN(n324), .Q(\y[3][8] ), .QN(
        n498) );
  DFFRX1 \y_reg[3][7]  ( .D(n173), .CK(clk), .RN(n323), .Q(\y[3][7] ), .QN(
        n497) );
  DFFRX1 \y_reg[3][6]  ( .D(n174), .CK(clk), .RN(n323), .Q(\y[3][6] ), .QN(
        n496) );
  DFFRX1 \y_reg[3][5]  ( .D(n175), .CK(clk), .RN(n323), .Q(\y[3][5] ), .QN(
        n495) );
  DFFRX1 \y_reg[3][4]  ( .D(n176), .CK(clk), .RN(n323), .Q(\y[3][4] ), .QN(
        n494) );
  DFFRX1 \y_reg[3][3]  ( .D(n177), .CK(clk), .RN(n323), .Q(\y[3][3] ), .QN(
        n493) );
  DFFRX1 \y_reg[3][2]  ( .D(n178), .CK(clk), .RN(n323), .Q(\y[3][2] ), .QN(
        n492) );
  DFFRX1 \y_reg[3][1]  ( .D(n179), .CK(clk), .RN(n323), .Q(\y[3][1] ), .QN(
        n491) );
  DFFRX1 \y_reg[3][0]  ( .D(n180), .CK(clk), .RN(n323), .Q(\y[3][0] ), .QN(
        n490) );
  DFFRX1 \y_reg[0][8]  ( .D(n145), .CK(clk), .RN(n326), .Q(\y[0][8] ), .QN(
        n525) );
  DFFRX1 \y_reg[0][7]  ( .D(n146), .CK(clk), .RN(n326), .Q(\y[0][7] ), .QN(
        n524) );
  DFFRX1 \y_reg[0][6]  ( .D(n147), .CK(clk), .RN(n326), .Q(\y[0][6] ), .QN(
        n523) );
  DFFRX1 \y_reg[0][5]  ( .D(n148), .CK(clk), .RN(n326), .Q(\y[0][5] ), .QN(
        n522) );
  DFFRX1 \y_reg[0][4]  ( .D(n149), .CK(clk), .RN(n325), .Q(\y[0][4] ), .QN(
        n521) );
  DFFRX1 \y_reg[0][3]  ( .D(n150), .CK(clk), .RN(n325), .Q(\y[0][3] ), .QN(
        n520) );
  DFFRX1 \y_reg[0][2]  ( .D(n151), .CK(clk), .RN(n325), .Q(\y[0][2] ), .QN(
        n519) );
  DFFRX1 \y_reg[0][1]  ( .D(n152), .CK(clk), .RN(n325), .Q(\y[0][1] ), .QN(
        n518) );
  DFFRX1 \y_reg[0][0]  ( .D(n153), .CK(clk), .RN(n325), .Q(\y[0][0] ), .QN(
        n517) );
  DFFRX1 \data_buf_reg[0][7]  ( .D(n81), .CK(clk), .RN(n323), .Q(
        \data_buf[0][7] ), .QN(n396) );
  DFFRX1 \data_buf_reg[1][7]  ( .D(n89), .CK(clk), .RN(n322), .Q(
        \data_buf[1][7] ), .QN(n404) );
  DFFRX1 \data_buf_reg[2][7]  ( .D(n97), .CK(clk), .RN(n321), .Q(
        \data_buf[2][7] ), .QN(n412) );
  DFFRX1 \data_buf_reg[3][7]  ( .D(n105), .CK(clk), .RN(n321), .Q(
        \data_buf[3][7] ), .QN(n420) );
  DFFRX1 \data_buf_reg[0][6]  ( .D(n82), .CK(clk), .RN(n323), .Q(
        \data_buf[0][6] ), .QN(n397) );
  DFFRX1 \data_buf_reg[0][5]  ( .D(n83), .CK(clk), .RN(n323), .Q(
        \data_buf[0][5] ), .QN(n398) );
  DFFRX1 \data_buf_reg[0][4]  ( .D(n84), .CK(clk), .RN(n323), .Q(
        \data_buf[0][4] ), .QN(n399) );
  DFFRX1 \data_buf_reg[0][3]  ( .D(n85), .CK(clk), .RN(n322), .Q(
        \data_buf[0][3] ), .QN(n400) );
  DFFRX1 \data_buf_reg[0][2]  ( .D(n86), .CK(clk), .RN(n322), .Q(
        \data_buf[0][2] ), .QN(n401) );
  DFFRX1 \data_buf_reg[0][1]  ( .D(n87), .CK(clk), .RN(n322), .Q(
        \data_buf[0][1] ), .QN(n402) );
  DFFRX1 \data_buf_reg[1][6]  ( .D(n90), .CK(clk), .RN(n322), .Q(
        \data_buf[1][6] ), .QN(n405) );
  DFFRX1 \data_buf_reg[1][5]  ( .D(n91), .CK(clk), .RN(n322), .Q(
        \data_buf[1][5] ), .QN(n406) );
  DFFRX1 \data_buf_reg[1][4]  ( .D(n92), .CK(clk), .RN(n322), .Q(
        \data_buf[1][4] ), .QN(n407) );
  DFFRX1 \data_buf_reg[1][3]  ( .D(n93), .CK(clk), .RN(n322), .Q(
        \data_buf[1][3] ), .QN(n408) );
  DFFRX1 \data_buf_reg[1][2]  ( .D(n94), .CK(clk), .RN(n322), .Q(
        \data_buf[1][2] ), .QN(n409) );
  DFFRX1 \data_buf_reg[1][1]  ( .D(n95), .CK(clk), .RN(n322), .Q(
        \data_buf[1][1] ), .QN(n410) );
  DFFRX1 \data_buf_reg[2][6]  ( .D(n98), .CK(clk), .RN(n321), .Q(
        \data_buf[2][6] ), .QN(n413) );
  DFFRX1 \data_buf_reg[2][5]  ( .D(n99), .CK(clk), .RN(n321), .Q(
        \data_buf[2][5] ), .QN(n414) );
  DFFRX1 \data_buf_reg[2][4]  ( .D(n100), .CK(clk), .RN(n321), .Q(
        \data_buf[2][4] ), .QN(n415) );
  DFFRX1 \data_buf_reg[2][3]  ( .D(n101), .CK(clk), .RN(n321), .Q(
        \data_buf[2][3] ), .QN(n416) );
  DFFRX1 \data_buf_reg[2][2]  ( .D(n102), .CK(clk), .RN(n321), .Q(
        \data_buf[2][2] ), .QN(n417) );
  DFFRX1 \data_buf_reg[2][1]  ( .D(n103), .CK(clk), .RN(n321), .Q(
        \data_buf[2][1] ), .QN(n418) );
  DFFRX1 \data_buf_reg[3][6]  ( .D(n106), .CK(clk), .RN(n321), .Q(
        \data_buf[3][6] ), .QN(n421) );
  DFFRX1 \data_buf_reg[3][5]  ( .D(n107), .CK(clk), .RN(n321), .Q(
        \data_buf[3][5] ), .QN(n422) );
  DFFRX1 \data_buf_reg[3][4]  ( .D(n108), .CK(clk), .RN(n321), .Q(
        \data_buf[3][4] ), .QN(n423) );
  DFFRX1 \data_buf_reg[3][3]  ( .D(n109), .CK(clk), .RN(n320), .Q(
        \data_buf[3][3] ), .QN(n424) );
  DFFRX1 \data_buf_reg[3][2]  ( .D(n110), .CK(clk), .RN(n320), .Q(
        \data_buf[3][2] ), .QN(n425) );
  DFFRX1 \data_buf_reg[3][1]  ( .D(n111), .CK(clk), .RN(n320), .Q(
        \data_buf[3][1] ), .QN(n426) );
  DFFRX1 \data_buf_reg[4][0]  ( .D(n120), .CK(clk), .RN(n320), .Q(
        \data_buf[4][0] ), .QN(n435) );
  DFFRX1 \data_buf_reg[5][0]  ( .D(n128), .CK(clk), .RN(n319), .Q(
        \data_buf[5][0] ), .QN(n443) );
  DFFRX1 \data_buf_reg[6][0]  ( .D(n136), .CK(clk), .RN(n318), .Q(
        \data_buf[6][0] ), .QN(n451) );
  DFFRX1 \data_buf_reg[7][0]  ( .D(n144), .CK(clk), .RN(n318), .Q(
        \data_buf[7][0] ), .QN(n459) );
  DFFRX1 \data_buf_reg[4][6]  ( .D(n114), .CK(clk), .RN(n320), .Q(
        \data_buf[4][6] ), .QN(n429) );
  DFFRX1 \data_buf_reg[4][5]  ( .D(n115), .CK(clk), .RN(n320), .Q(
        \data_buf[4][5] ), .QN(n430) );
  DFFRX1 \data_buf_reg[4][4]  ( .D(n116), .CK(clk), .RN(n320), .Q(
        \data_buf[4][4] ), .QN(n431) );
  DFFRX1 \data_buf_reg[4][3]  ( .D(n117), .CK(clk), .RN(n320), .Q(
        \data_buf[4][3] ), .QN(n432) );
  DFFRX1 \data_buf_reg[4][2]  ( .D(n118), .CK(clk), .RN(n320), .Q(
        \data_buf[4][2] ), .QN(n433) );
  DFFRX1 \data_buf_reg[4][1]  ( .D(n119), .CK(clk), .RN(n320), .Q(
        \data_buf[4][1] ), .QN(n434) );
  DFFRX1 \data_buf_reg[5][6]  ( .D(n122), .CK(clk), .RN(n319), .Q(
        \data_buf[5][6] ), .QN(n437) );
  DFFRX1 \data_buf_reg[5][5]  ( .D(n123), .CK(clk), .RN(n319), .Q(
        \data_buf[5][5] ), .QN(n438) );
  DFFRX1 \data_buf_reg[5][4]  ( .D(n124), .CK(clk), .RN(n319), .Q(
        \data_buf[5][4] ), .QN(n439) );
  DFFRX1 \data_buf_reg[5][3]  ( .D(n125), .CK(clk), .RN(n319), .Q(
        \data_buf[5][3] ), .QN(n440) );
  DFFRX1 \data_buf_reg[5][2]  ( .D(n126), .CK(clk), .RN(n319), .Q(
        \data_buf[5][2] ), .QN(n441) );
  DFFRX1 \data_buf_reg[5][1]  ( .D(n127), .CK(clk), .RN(n319), .Q(
        \data_buf[5][1] ), .QN(n442) );
  DFFRX1 \data_buf_reg[6][6]  ( .D(n130), .CK(clk), .RN(n319), .Q(
        \data_buf[6][6] ), .QN(n445) );
  DFFRX1 \data_buf_reg[6][5]  ( .D(n131), .CK(clk), .RN(n319), .Q(
        \data_buf[6][5] ), .QN(n446) );
  DFFRX1 \data_buf_reg[6][4]  ( .D(n132), .CK(clk), .RN(n319), .Q(
        \data_buf[6][4] ), .QN(n447) );
  DFFRX1 \data_buf_reg[6][3]  ( .D(n133), .CK(clk), .RN(n318), .Q(
        \data_buf[6][3] ), .QN(n448) );
  DFFRX1 \data_buf_reg[6][2]  ( .D(n134), .CK(clk), .RN(n318), .Q(
        \data_buf[6][2] ), .QN(n449) );
  DFFRX1 \data_buf_reg[6][1]  ( .D(n135), .CK(clk), .RN(n318), .Q(
        \data_buf[6][1] ), .QN(n450) );
  DFFRX1 \data_buf_reg[7][6]  ( .D(n138), .CK(clk), .RN(n318), .Q(
        \data_buf[7][6] ), .QN(n453) );
  DFFRX1 \data_buf_reg[7][5]  ( .D(n139), .CK(clk), .RN(n318), .Q(
        \data_buf[7][5] ), .QN(n454) );
  DFFRX1 \data_buf_reg[7][4]  ( .D(n140), .CK(clk), .RN(n318), .Q(
        \data_buf[7][4] ), .QN(n455) );
  DFFRX1 \data_buf_reg[7][3]  ( .D(n141), .CK(clk), .RN(n318), .Q(
        \data_buf[7][3] ), .QN(n456) );
  DFFRX1 \data_buf_reg[7][2]  ( .D(n142), .CK(clk), .RN(n318), .Q(
        \data_buf[7][2] ), .QN(n457) );
  DFFRX1 \data_buf_reg[7][1]  ( .D(n143), .CK(clk), .RN(n318), .Q(
        \data_buf[7][1] ), .QN(n458) );
  DFFRX1 \data_buf_reg[0][0]  ( .D(n88), .CK(clk), .RN(n322), .Q(
        \data_buf[0][0] ), .QN(n403) );
  DFFRX1 \data_buf_reg[1][0]  ( .D(n96), .CK(clk), .RN(n322), .Q(
        \data_buf[1][0] ), .QN(n411) );
  DFFRX1 \data_buf_reg[2][0]  ( .D(n104), .CK(clk), .RN(n321), .Q(
        \data_buf[2][0] ), .QN(n419) );
  DFFRX1 \data_buf_reg[3][0]  ( .D(n112), .CK(clk), .RN(n320), .Q(
        \data_buf[3][0] ), .QN(n427) );
  DFFRX1 \count_reg[20]  ( .D(n191), .CK(clk), .RN(n328), .Q(count[20]), .QN(
        n461) );
  DFFRX1 \count_reg[22]  ( .D(n189), .CK(clk), .RN(n328), .Q(count[22]), .QN(
        n463) );
  DFFRX1 \count_reg[19]  ( .D(n192), .CK(clk), .RN(n328), .Q(count[19]), .QN(
        n466) );
  DFFRX1 \count_reg[17]  ( .D(n194), .CK(clk), .RN(n327), .Q(count[17]), .QN(
        n467) );
  DFFRX1 \count_reg[21]  ( .D(n190), .CK(clk), .RN(n328), .Q(count[21]), .QN(
        n462) );
  DFFRX1 \count_reg[18]  ( .D(n193), .CK(clk), .RN(n327), .Q(count[18]), .QN(
        n465) );
  DFFRX1 \count_reg[23]  ( .D(n188), .CK(clk), .RN(n328), .Q(count[23]), .QN(
        n464) );
  DFFRX1 \count_reg[2]  ( .D(n209), .CK(clk), .RN(n326), .Q(count[2]), .QN(
        n486) );
  DFFRX1 \count_reg[15]  ( .D(n196), .CK(clk), .RN(n327), .Q(count[15]), .QN(
        n470) );
  DFFRX1 \count_reg[14]  ( .D(n197), .CK(clk), .RN(n327), .Q(count[14]), .QN(
        n469) );
  DFFRX1 \count_reg[13]  ( .D(n198), .CK(clk), .RN(n327), .Q(count[13]), .QN(
        n468) );
  DFFRX1 \count_reg[31]  ( .D(n211), .CK(clk), .RN(n329), .Q(count[31]), .QN(
        n460) );
  DFFRX1 \data_buf_reg[4][7]  ( .D(n113), .CK(clk), .RN(n320), .Q(
        \data_buf[4][7] ), .QN(n428) );
  DFFRX1 \data_buf_reg[5][7]  ( .D(n121), .CK(clk), .RN(n319), .Q(
        \data_buf[5][7] ), .QN(n436) );
  DFFRX1 \data_buf_reg[6][7]  ( .D(n129), .CK(clk), .RN(n319), .Q(
        \data_buf[6][7] ), .QN(n444) );
  DFFRX1 \data_buf_reg[7][7]  ( .D(n137), .CK(clk), .RN(n318), .Q(
        \data_buf[7][7] ), .QN(n452) );
  DFFRX1 \count_reg[30]  ( .D(n181), .CK(clk), .RN(n329), .Q(count[30]), .QN(
        n479) );
  DFFRX1 \count_reg[16]  ( .D(n195), .CK(clk), .RN(n327), .Q(count[16]), .QN(
        n471) );
  DFFRX1 \count_reg[10]  ( .D(n201), .CK(clk), .RN(n327), .Q(count[10]), .QN(
        n474) );
  DFFRX1 \count_reg[12]  ( .D(n199), .CK(clk), .RN(n327), .Q(count[12]), .QN(
        n473) );
  DFFRX1 \count_reg[11]  ( .D(n200), .CK(clk), .RN(n327), .Q(count[11]), .QN(
        n472) );
  DFFRX1 \count_reg[6]  ( .D(n205), .CK(clk), .RN(n326), .Q(count[6]), .QN(
        n475) );
  DFFRX1 \count_reg[5]  ( .D(n206), .CK(clk), .RN(n326), .Q(count[5]), .QN(
        n482) );
  DFFRX1 \count_reg[28]  ( .D(n183), .CK(clk), .RN(n328), .Q(count[28]), .QN(
        n484) );
  DFFRX1 \count_reg[8]  ( .D(n203), .CK(clk), .RN(n327), .Q(count[8]), .QN(
        n477) );
  DFFRX1 \count_reg[24]  ( .D(n187), .CK(clk), .RN(n328), .Q(count[24]), .QN(
        n489) );
  DFFRX1 \count_reg[4]  ( .D(n207), .CK(clk), .RN(n326), .Q(count[4]), .QN(
        n481) );
  DFFRX1 \count_reg[7]  ( .D(n204), .CK(clk), .RN(n327), .Q(count[7]), .QN(
        n476) );
  DFFRX1 \count_reg[26]  ( .D(n185), .CK(clk), .RN(n328), .Q(count[26]), .QN(
        n488) );
  DFFRX1 \count_reg[3]  ( .D(n208), .CK(clk), .RN(n326), .Q(count[3]), .QN(
        n480) );
  DFFRX1 \count_reg[9]  ( .D(n202), .CK(clk), .RN(n327), .Q(count[9]), .QN(
        n478) );
  DFFRX1 \count_reg[27]  ( .D(n184), .CK(clk), .RN(n328), .Q(count[27]), .QN(
        n483) );
  DFFRX1 \count_reg[25]  ( .D(n186), .CK(clk), .RN(n328), .Q(count[25]), .QN(
        n487) );
  DFFRX1 \count_reg[29]  ( .D(n182), .CK(clk), .RN(n328), .Q(count[29]), .QN(
        n485) );
  TLATX1 \dataout_reg[0]  ( .G(n314), .D(N743), .QN(n230) );
  TLATX1 \dataout_reg[1]  ( .G(n314), .D(N744), .QN(n228) );
  TLATX1 \dataout_reg[2]  ( .G(n314), .D(N745), .QN(n226) );
  TLATX1 \dataout_reg[3]  ( .G(n314), .D(N746), .QN(n224) );
  TLATX1 \dataout_reg[4]  ( .G(n314), .D(N747), .QN(n222) );
  TLATX1 \dataout_reg[5]  ( .G(n314), .D(N748), .QN(n220) );
  TLATX1 \dataout_reg[6]  ( .G(n314), .D(N749), .QN(n218) );
  TLATX1 \dataout_reg[7]  ( .G(n314), .D(N750), .QN(n216) );
  TLATX1 \dataout_reg[8]  ( .G(n314), .D(N751), .QN(n214) );
  DFFRX1 \state_reg[2]  ( .D(nxt_state[2]), .CK(clk), .RN(n328), .Q(state[2]), 
        .QN(n382) );
  DFFRX1 \state_reg[0]  ( .D(nxt_state[0]), .CK(clk), .RN(n326), .Q(state[0])
         );
  DFFRX1 \state_reg[1]  ( .D(nxt_state[1]), .CK(clk), .RN(n326), .Q(state[1]), 
        .QN(n381) );
  DFFRX2 \count_reg[0]  ( .D(n212), .CK(clk), .RN(n329), .Q(N135), .QN(n278)
         );
  DFFRX2 \count_reg[1]  ( .D(n210), .CK(clk), .RN(n326), .Q(N136), .QN(n277)
         );
  OAI21X4 U219 ( .A0(n389), .A1(count[2]), .B0(n460), .Y(n213) );
  NOR2XL U220 ( .A(n277), .B(n278), .Y(n271) );
  NOR2XL U221 ( .A(n278), .B(N136), .Y(n273) );
  OA21X2 U222 ( .A0(n381), .A1(n380), .B0(n379), .Y(n336) );
  INVX3 U223 ( .A(datain[7]), .Y(n348) );
  INVX3 U224 ( .A(datain[6]), .Y(n347) );
  INVX3 U225 ( .A(datain[5]), .Y(n345) );
  INVX3 U226 ( .A(datain[4]), .Y(n354) );
  INVX3 U227 ( .A(datain[3]), .Y(n353) );
  INVX3 U228 ( .A(datain[2]), .Y(n352) );
  INVX3 U229 ( .A(datain[1]), .Y(n351) );
  INVX3 U230 ( .A(datain[0]), .Y(n349) );
  NOR2BX2 U231 ( .AN(n355), .B(n311), .Y(n357) );
  NOR2BX2 U232 ( .AN(n355), .B(n308), .Y(n350) );
  NOR2BX2 U233 ( .AN(n355), .B(n313), .Y(n346) );
  INVX12 U234 ( .A(n214), .Y(dataout[8]) );
  INVX12 U235 ( .A(n216), .Y(dataout[7]) );
  INVX12 U236 ( .A(n218), .Y(dataout[6]) );
  INVX12 U237 ( .A(n220), .Y(dataout[5]) );
  INVX12 U238 ( .A(n222), .Y(dataout[4]) );
  INVX12 U239 ( .A(n224), .Y(dataout[3]) );
  INVX12 U240 ( .A(n226), .Y(dataout[2]) );
  INVX12 U241 ( .A(n228), .Y(dataout[1]) );
  INVX12 U242 ( .A(n230), .Y(dataout[0]) );
  NOR2BX2 U243 ( .AN(n355), .B(n312), .Y(n388) );
  AND3X2 U244 ( .A(n384), .B(N135), .C(N136), .Y(n383) );
  OR4X1 U245 ( .A(n392), .B(n393), .C(n394), .D(n395), .Y(n235) );
  OR3X2 U246 ( .A(n391), .B(n234), .C(n233), .Y(n232) );
  OR2X1 U247 ( .A(n235), .B(n232), .Y(n389) );
  MXI2XL U248 ( .A(n427), .B(n349), .S0(n388), .Y(n112) );
  MXI2XL U249 ( .A(n426), .B(n351), .S0(n388), .Y(n111) );
  MXI2XL U250 ( .A(n425), .B(n352), .S0(n388), .Y(n110) );
  MXI2XL U251 ( .A(n424), .B(n353), .S0(n388), .Y(n109) );
  MXI2XL U252 ( .A(n423), .B(n354), .S0(n388), .Y(n108) );
  MXI2XL U253 ( .A(n422), .B(n345), .S0(n388), .Y(n107) );
  MXI2XL U254 ( .A(n421), .B(n347), .S0(n388), .Y(n106) );
  MXI2XL U255 ( .A(n420), .B(n348), .S0(n388), .Y(n105) );
  MXI2XL U256 ( .A(n419), .B(n349), .S0(n346), .Y(n104) );
  MXI2XL U257 ( .A(n418), .B(n351), .S0(n346), .Y(n103) );
  MXI2XL U258 ( .A(n417), .B(n352), .S0(n346), .Y(n102) );
  MXI2XL U259 ( .A(n416), .B(n353), .S0(n346), .Y(n101) );
  MXI2XL U260 ( .A(n415), .B(n354), .S0(n346), .Y(n100) );
  MXI2XL U261 ( .A(n414), .B(n345), .S0(n346), .Y(n99) );
  MXI2XL U262 ( .A(n413), .B(n347), .S0(n346), .Y(n98) );
  MXI2XL U263 ( .A(n412), .B(n348), .S0(n346), .Y(n97) );
  MXI2XL U264 ( .A(n411), .B(n349), .S0(n350), .Y(n96) );
  MXI2XL U265 ( .A(n410), .B(n351), .S0(n350), .Y(n95) );
  MXI2XL U266 ( .A(n409), .B(n352), .S0(n350), .Y(n94) );
  MXI2XL U267 ( .A(n408), .B(n353), .S0(n350), .Y(n93) );
  MXI2XL U268 ( .A(n407), .B(n354), .S0(n350), .Y(n92) );
  MXI2XL U269 ( .A(n406), .B(n345), .S0(n350), .Y(n91) );
  MXI2XL U270 ( .A(n405), .B(n347), .S0(n350), .Y(n90) );
  MXI2XL U271 ( .A(n404), .B(n348), .S0(n350), .Y(n89) );
  MXI2XL U272 ( .A(n403), .B(n349), .S0(n357), .Y(n88) );
  MXI2XL U273 ( .A(n402), .B(n351), .S0(n357), .Y(n87) );
  MXI2XL U274 ( .A(n401), .B(n352), .S0(n357), .Y(n86) );
  MXI2XL U275 ( .A(n400), .B(n353), .S0(n357), .Y(n85) );
  MXI2XL U276 ( .A(n399), .B(n354), .S0(n357), .Y(n84) );
  MXI2XL U277 ( .A(n398), .B(n345), .S0(n357), .Y(n83) );
  MXI2XL U278 ( .A(n397), .B(n347), .S0(n357), .Y(n82) );
  MXI2XL U279 ( .A(n396), .B(n348), .S0(n357), .Y(n81) );
  MXI2XL U280 ( .A(n459), .B(n349), .S0(n383), .Y(n144) );
  MXI2XL U281 ( .A(n458), .B(n351), .S0(n383), .Y(n143) );
  MXI2XL U282 ( .A(n457), .B(n352), .S0(n383), .Y(n142) );
  MXI2XL U283 ( .A(n456), .B(n353), .S0(n383), .Y(n141) );
  MXI2XL U284 ( .A(n455), .B(n354), .S0(n383), .Y(n140) );
  MXI2XL U285 ( .A(n454), .B(n345), .S0(n383), .Y(n139) );
  MXI2XL U286 ( .A(n453), .B(n347), .S0(n383), .Y(n138) );
  MXI2XL U287 ( .A(n452), .B(n348), .S0(n383), .Y(n137) );
  MXI2XL U288 ( .A(n451), .B(n349), .S0(n385), .Y(n136) );
  MXI2XL U289 ( .A(n450), .B(n351), .S0(n385), .Y(n135) );
  MXI2XL U290 ( .A(n449), .B(n352), .S0(n385), .Y(n134) );
  MXI2XL U291 ( .A(n448), .B(n353), .S0(n385), .Y(n133) );
  MXI2XL U292 ( .A(n447), .B(n354), .S0(n385), .Y(n132) );
  MXI2XL U293 ( .A(n446), .B(n345), .S0(n385), .Y(n131) );
  MXI2XL U294 ( .A(n445), .B(n347), .S0(n385), .Y(n130) );
  MXI2XL U295 ( .A(n444), .B(n348), .S0(n385), .Y(n129) );
  MXI2XL U296 ( .A(n443), .B(n349), .S0(n386), .Y(n128) );
  MXI2XL U297 ( .A(n442), .B(n351), .S0(n386), .Y(n127) );
  MXI2XL U298 ( .A(n441), .B(n352), .S0(n386), .Y(n126) );
  MXI2XL U299 ( .A(n440), .B(n353), .S0(n386), .Y(n125) );
  MXI2XL U300 ( .A(n439), .B(n354), .S0(n386), .Y(n124) );
  MXI2XL U301 ( .A(n438), .B(n345), .S0(n386), .Y(n123) );
  MXI2XL U302 ( .A(n437), .B(n347), .S0(n386), .Y(n122) );
  MXI2XL U303 ( .A(n436), .B(n348), .S0(n386), .Y(n121) );
  MXI2XL U304 ( .A(n435), .B(n349), .S0(n387), .Y(n120) );
  MXI2XL U305 ( .A(n434), .B(n351), .S0(n387), .Y(n119) );
  MXI2XL U306 ( .A(n433), .B(n352), .S0(n387), .Y(n118) );
  MXI2XL U307 ( .A(n432), .B(n353), .S0(n387), .Y(n117) );
  MXI2XL U308 ( .A(n431), .B(n354), .S0(n387), .Y(n116) );
  MXI2XL U309 ( .A(n430), .B(n345), .S0(n387), .Y(n115) );
  MXI2XL U310 ( .A(n429), .B(n347), .S0(n387), .Y(n114) );
  MXI2XL U311 ( .A(n428), .B(n348), .S0(n387), .Y(n113) );
  OAI32XL U312 ( .A0(n337), .A1(busy), .A2(n338), .B0(n336), .B1(n339), .Y(
        nxt_state[1]) );
  AND3X2 U313 ( .A(n384), .B(n278), .C(N136), .Y(n385) );
  AND3X2 U314 ( .A(n384), .B(n277), .C(N135), .Y(n386) );
  AND3X2 U315 ( .A(n384), .B(n277), .C(n278), .Y(n387) );
  AND4X1 U316 ( .A(n471), .B(n472), .C(n473), .D(n474), .Y(n236) );
  NAND4X1 U317 ( .A(n236), .B(n468), .C(n470), .D(n469), .Y(n391) );
  NOR2XL U318 ( .A(state[2]), .B(state[0]), .Y(n390) );
  NAND3XL U319 ( .A(state[0]), .B(n382), .C(state[1]), .Y(n379) );
  NAND3XL U320 ( .A(n381), .B(n382), .C(state[0]), .Y(n341) );
  NOR3BX1 U321 ( .AN(n460), .B(count[2]), .C(n389), .Y(n376) );
  NAND2XL U322 ( .A(n460), .B(n389), .Y(n360) );
  INVX12 U323 ( .A(n335), .Y(output_valid) );
  CLKBUFX3 U324 ( .A(n359), .Y(n315) );
  CLKBUFX3 U325 ( .A(n359), .Y(n316) );
  CLKBUFX3 U326 ( .A(n331), .Y(n318) );
  CLKBUFX3 U327 ( .A(n526), .Y(n319) );
  CLKBUFX3 U328 ( .A(n331), .Y(n320) );
  CLKBUFX3 U329 ( .A(n331), .Y(n321) );
  CLKBUFX3 U330 ( .A(n332), .Y(n322) );
  CLKBUFX3 U331 ( .A(n332), .Y(n323) );
  CLKBUFX3 U332 ( .A(n332), .Y(n324) );
  CLKBUFX3 U333 ( .A(n526), .Y(n325) );
  CLKBUFX3 U334 ( .A(n333), .Y(n326) );
  CLKBUFX3 U335 ( .A(n333), .Y(n327) );
  CLKBUFX3 U336 ( .A(n330), .Y(n328) );
  CLKBUFX3 U337 ( .A(n330), .Y(n329) );
  CLKBUFX3 U338 ( .A(n363), .Y(n305) );
  NOR2BX1 U339 ( .AN(n372), .B(n312), .Y(n363) );
  CLKBUFX3 U340 ( .A(n333), .Y(n330) );
  BUFX20 U341 ( .A(n527), .Y(busy) );
  CLKBUFX3 U342 ( .A(n362), .Y(n312) );
  NAND3XL U343 ( .A(N135), .B(N136), .C(n376), .Y(n362) );
  CLKBUFX3 U344 ( .A(n374), .Y(n306) );
  NOR2BX1 U345 ( .AN(n372), .B(n313), .Y(n374) );
  CLKBUFX3 U346 ( .A(n375), .Y(n307) );
  NOR2BX1 U347 ( .AN(n372), .B(n308), .Y(n375) );
  CLKBUFX3 U348 ( .A(n377), .Y(n310) );
  NOR2BX1 U349 ( .AN(n372), .B(n311), .Y(n377) );
  CLKBUFX3 U350 ( .A(n344), .Y(n309) );
  NOR2X1 U351 ( .A(n379), .B(n339), .Y(n344) );
  NOR2X2 U352 ( .A(n380), .B(n381), .Y(n378) );
  NOR2X2 U353 ( .A(N136), .B(N135), .Y(n299) );
  CLKBUFX3 U354 ( .A(n271), .Y(n280) );
  CLKBUFX3 U355 ( .A(n317), .Y(n331) );
  CLKBUFX3 U356 ( .A(n317), .Y(n332) );
  CLKBUFX3 U357 ( .A(n317), .Y(n333) );
  NAND3X1 U358 ( .A(n461), .B(n463), .C(n462), .Y(n233) );
  NAND4X1 U359 ( .A(n467), .B(n466), .C(n465), .D(n464), .Y(n234) );
  CLKBUFX3 U360 ( .A(N784), .Y(n314) );
  NOR3X1 U361 ( .A(state[0]), .B(state[1]), .C(n382), .Y(N784) );
  CLKBUFX3 U362 ( .A(n373), .Y(n313) );
  NAND3XL U363 ( .A(n376), .B(N136), .C(n278), .Y(n373) );
  CLKBUFX3 U364 ( .A(n356), .Y(n308) );
  NAND3XL U365 ( .A(n376), .B(N135), .C(n277), .Y(n356) );
  CLKBUFX3 U366 ( .A(n358), .Y(n311) );
  NAND3XL U367 ( .A(n278), .B(n376), .C(n277), .Y(n358) );
  NOR2X2 U368 ( .A(n278), .B(n277), .Y(n302) );
  NOR2X2 U369 ( .A(N136), .B(n278), .Y(n300) );
  NOR2X2 U370 ( .A(N135), .B(n277), .Y(n301) );
  CLKBUFX3 U371 ( .A(n272), .Y(n279) );
  NOR2X1 U372 ( .A(n277), .B(N135), .Y(n272) );
  CLKBUFX3 U373 ( .A(n274), .Y(n281) );
  NOR2X1 U374 ( .A(N135), .B(N136), .Y(n274) );
  CLKBUFX3 U375 ( .A(n273), .Y(n282) );
  CLKBUFX3 U376 ( .A(n526), .Y(n317) );
  AOI22X1 U377 ( .A0(\y[2][0] ), .A1(n279), .B0(\y[3][0] ), .B1(n280), .Y(n238) );
  AOI22X1 U378 ( .A0(\y[0][0] ), .A1(n281), .B0(\y[1][0] ), .B1(n282), .Y(n237) );
  NAND2X1 U379 ( .A(n238), .B(n237), .Y(N710) );
  AOI22X1 U380 ( .A0(\y[2][1] ), .A1(n279), .B0(\y[3][1] ), .B1(n280), .Y(n240) );
  AOI22X1 U381 ( .A0(\y[0][1] ), .A1(n281), .B0(\y[1][1] ), .B1(n282), .Y(n239) );
  NAND2X1 U382 ( .A(n240), .B(n239), .Y(N709) );
  AOI22X1 U383 ( .A0(\y[2][2] ), .A1(n279), .B0(\y[3][2] ), .B1(n280), .Y(n242) );
  AOI22X1 U384 ( .A0(\y[0][2] ), .A1(n281), .B0(\y[1][2] ), .B1(n282), .Y(n241) );
  NAND2X1 U385 ( .A(n242), .B(n241), .Y(N708) );
  AOI22X1 U386 ( .A0(\y[2][3] ), .A1(n279), .B0(\y[3][3] ), .B1(n280), .Y(n244) );
  AOI22X1 U387 ( .A0(\y[0][3] ), .A1(n281), .B0(\y[1][3] ), .B1(n282), .Y(n243) );
  NAND2X1 U388 ( .A(n244), .B(n243), .Y(N707) );
  AOI22X1 U389 ( .A0(\y[2][4] ), .A1(n279), .B0(\y[3][4] ), .B1(n280), .Y(n246) );
  AOI22X1 U390 ( .A0(\y[0][4] ), .A1(n281), .B0(\y[1][4] ), .B1(n282), .Y(n245) );
  NAND2X1 U391 ( .A(n246), .B(n245), .Y(N706) );
  AOI22X1 U392 ( .A0(\y[2][5] ), .A1(n279), .B0(\y[3][5] ), .B1(n280), .Y(n248) );
  AOI22X1 U393 ( .A0(\y[0][5] ), .A1(n281), .B0(\y[1][5] ), .B1(n282), .Y(n247) );
  NAND2X1 U394 ( .A(n248), .B(n247), .Y(N705) );
  AOI22X1 U395 ( .A0(\y[2][6] ), .A1(n279), .B0(\y[3][6] ), .B1(n280), .Y(n250) );
  AOI22X1 U396 ( .A0(\y[0][6] ), .A1(n281), .B0(\y[1][6] ), .B1(n282), .Y(n249) );
  NAND2X1 U397 ( .A(n250), .B(n249), .Y(N704) );
  AOI22X1 U398 ( .A0(\y[2][7] ), .A1(n279), .B0(\y[3][7] ), .B1(n280), .Y(n252) );
  AOI22X1 U399 ( .A0(\y[0][7] ), .A1(n281), .B0(\y[1][7] ), .B1(n282), .Y(n251) );
  NAND2X1 U400 ( .A(n252), .B(n251), .Y(N703) );
  AOI22X1 U401 ( .A0(\y[2][8] ), .A1(n279), .B0(\y[3][8] ), .B1(n280), .Y(n254) );
  AOI22X1 U402 ( .A0(\y[0][8] ), .A1(n281), .B0(\y[1][8] ), .B1(n282), .Y(n253) );
  NAND2X1 U403 ( .A(n254), .B(n253), .Y(N702) );
  AOI22X1 U404 ( .A0(\calculated_buf[2][0] ), .A1(n279), .B0(
        \calculated_buf[3][0] ), .B1(n280), .Y(n256) );
  AOI22X1 U405 ( .A0(\calculated_buf[0][0] ), .A1(n281), .B0(
        \calculated_buf[1][0] ), .B1(n282), .Y(n255) );
  NAND2X1 U406 ( .A(n256), .B(n255), .Y(N394) );
  AOI22X1 U407 ( .A0(\calculated_buf[2][1] ), .A1(n279), .B0(
        \calculated_buf[3][1] ), .B1(n280), .Y(n258) );
  AOI22X1 U408 ( .A0(\calculated_buf[0][1] ), .A1(n281), .B0(
        \calculated_buf[1][1] ), .B1(n282), .Y(n257) );
  NAND2X1 U409 ( .A(n258), .B(n257), .Y(N393) );
  AOI22X1 U410 ( .A0(\calculated_buf[2][2] ), .A1(n279), .B0(
        \calculated_buf[3][2] ), .B1(n280), .Y(n260) );
  AOI22X1 U411 ( .A0(\calculated_buf[0][2] ), .A1(n281), .B0(
        \calculated_buf[1][2] ), .B1(n282), .Y(n259) );
  NAND2X1 U412 ( .A(n260), .B(n259), .Y(N392) );
  AOI22X1 U413 ( .A0(\calculated_buf[2][3] ), .A1(n279), .B0(
        \calculated_buf[3][3] ), .B1(n280), .Y(n262) );
  AOI22X1 U414 ( .A0(\calculated_buf[0][3] ), .A1(n281), .B0(
        \calculated_buf[1][3] ), .B1(n282), .Y(n261) );
  NAND2X1 U415 ( .A(n262), .B(n261), .Y(N391) );
  AOI22X1 U416 ( .A0(\calculated_buf[2][4] ), .A1(n279), .B0(
        \calculated_buf[3][4] ), .B1(n280), .Y(n264) );
  AOI22X1 U417 ( .A0(\calculated_buf[0][4] ), .A1(n281), .B0(
        \calculated_buf[1][4] ), .B1(n282), .Y(n263) );
  NAND2X1 U418 ( .A(n264), .B(n263), .Y(N390) );
  AOI22X1 U419 ( .A0(\calculated_buf[2][5] ), .A1(n279), .B0(
        \calculated_buf[3][5] ), .B1(n280), .Y(n266) );
  AOI22X1 U420 ( .A0(\calculated_buf[0][5] ), .A1(n281), .B0(
        \calculated_buf[1][5] ), .B1(n282), .Y(n265) );
  NAND2X1 U421 ( .A(n266), .B(n265), .Y(N389) );
  AOI22X1 U422 ( .A0(\calculated_buf[2][6] ), .A1(n279), .B0(
        \calculated_buf[3][6] ), .B1(n280), .Y(n268) );
  AOI22X1 U423 ( .A0(\calculated_buf[0][6] ), .A1(n281), .B0(
        \calculated_buf[1][6] ), .B1(n282), .Y(n267) );
  NAND2X1 U424 ( .A(n268), .B(n267), .Y(N388) );
  AOI22X1 U425 ( .A0(\calculated_buf[2][7] ), .A1(n279), .B0(
        \calculated_buf[3][7] ), .B1(n280), .Y(n270) );
  AOI22X1 U426 ( .A0(\calculated_buf[0][7] ), .A1(n281), .B0(
        \calculated_buf[1][7] ), .B1(n282), .Y(n269) );
  NAND2X1 U427 ( .A(n270), .B(n269), .Y(N387) );
  AOI22X1 U428 ( .A0(\calculated_buf[2][8] ), .A1(n279), .B0(
        \calculated_buf[3][8] ), .B1(n280), .Y(n276) );
  AOI22X1 U429 ( .A0(\calculated_buf[0][8] ), .A1(n281), .B0(
        \calculated_buf[1][8] ), .B1(n282), .Y(n275) );
  NAND2X1 U430 ( .A(n276), .B(n275), .Y(N386) );
  AOI22X1 U431 ( .A0(\calculated_buf[2][0] ), .A1(n300), .B0(
        \calculated_buf[3][0] ), .B1(n299), .Y(n284) );
  AOI22X1 U432 ( .A0(\calculated_buf[0][0] ), .A1(n302), .B0(
        \calculated_buf[1][0] ), .B1(n301), .Y(n283) );
  NAND2X1 U433 ( .A(n284), .B(n283), .Y(N553) );
  AOI22X1 U434 ( .A0(\calculated_buf[2][1] ), .A1(n300), .B0(
        \calculated_buf[3][1] ), .B1(n299), .Y(n286) );
  AOI22X1 U435 ( .A0(\calculated_buf[0][1] ), .A1(n302), .B0(
        \calculated_buf[1][1] ), .B1(n301), .Y(n285) );
  NAND2X1 U436 ( .A(n286), .B(n285), .Y(N552) );
  AOI22X1 U437 ( .A0(\calculated_buf[2][2] ), .A1(n300), .B0(
        \calculated_buf[3][2] ), .B1(n299), .Y(n288) );
  AOI22X1 U438 ( .A0(\calculated_buf[0][2] ), .A1(n302), .B0(
        \calculated_buf[1][2] ), .B1(n301), .Y(n287) );
  NAND2X1 U439 ( .A(n288), .B(n287), .Y(N551) );
  AOI22X1 U440 ( .A0(\calculated_buf[2][3] ), .A1(n300), .B0(
        \calculated_buf[3][3] ), .B1(n299), .Y(n290) );
  AOI22X1 U441 ( .A0(\calculated_buf[0][3] ), .A1(n302), .B0(
        \calculated_buf[1][3] ), .B1(n301), .Y(n289) );
  NAND2X1 U442 ( .A(n290), .B(n289), .Y(N550) );
  AOI22X1 U443 ( .A0(\calculated_buf[2][4] ), .A1(n300), .B0(
        \calculated_buf[3][4] ), .B1(n299), .Y(n292) );
  AOI22X1 U444 ( .A0(\calculated_buf[0][4] ), .A1(n302), .B0(
        \calculated_buf[1][4] ), .B1(n301), .Y(n291) );
  NAND2X1 U445 ( .A(n292), .B(n291), .Y(N549) );
  AOI22X1 U446 ( .A0(\calculated_buf[2][5] ), .A1(n300), .B0(
        \calculated_buf[3][5] ), .B1(n299), .Y(n294) );
  AOI22X1 U447 ( .A0(\calculated_buf[0][5] ), .A1(n302), .B0(
        \calculated_buf[1][5] ), .B1(n301), .Y(n293) );
  NAND2X1 U448 ( .A(n294), .B(n293), .Y(N548) );
  AOI22X1 U449 ( .A0(\calculated_buf[2][6] ), .A1(n300), .B0(
        \calculated_buf[3][6] ), .B1(n299), .Y(n296) );
  AOI22X1 U450 ( .A0(\calculated_buf[0][6] ), .A1(n302), .B0(
        \calculated_buf[1][6] ), .B1(n301), .Y(n295) );
  NAND2X1 U451 ( .A(n296), .B(n295), .Y(N547) );
  AOI22X1 U452 ( .A0(\calculated_buf[2][7] ), .A1(n300), .B0(
        \calculated_buf[3][7] ), .B1(n299), .Y(n298) );
  AOI22X1 U453 ( .A0(\calculated_buf[0][7] ), .A1(n302), .B0(
        \calculated_buf[1][7] ), .B1(n301), .Y(n297) );
  NAND2X1 U454 ( .A(n298), .B(n297), .Y(N546) );
  AOI22X1 U455 ( .A0(\calculated_buf[2][8] ), .A1(n300), .B0(
        \calculated_buf[3][8] ), .B1(n299), .Y(n304) );
  AOI22X1 U456 ( .A0(\calculated_buf[0][8] ), .A1(n302), .B0(
        \calculated_buf[1][8] ), .B1(n301), .Y(n303) );
  NAND2X1 U457 ( .A(n304), .B(n303), .Y(N545) );
  OAI21XL U458 ( .A0(n336), .A1(n213), .B0(n335), .Y(nxt_state[2]) );
  XNOR2X1 U459 ( .A(cmd[0]), .B(cmd[1]), .Y(n338) );
  OAI211X1 U460 ( .A0(n340), .A1(n341), .B0(n342), .C0(n343), .Y(nxt_state[0])
         );
  CLKINVX1 U461 ( .A(n309), .Y(n343) );
  OR3X1 U462 ( .A(busy), .B(cmd[0]), .C(n337), .Y(n342) );
  CLKINVX1 U463 ( .A(cmd_valid), .Y(n337) );
  CLKINVX1 U464 ( .A(reset), .Y(n526) );
  OAI2BB2XL U465 ( .B0(n278), .B1(busy), .A0N(N255), .A1N(n316), .Y(n212) );
  OAI2BB2XL U466 ( .B0(n460), .B1(busy), .A0N(N286), .A1N(n316), .Y(n211) );
  OAI2BB2XL U467 ( .B0(n277), .B1(busy), .A0N(N256), .A1N(n316), .Y(n210) );
  OAI2BB2XL U468 ( .B0(n486), .B1(busy), .A0N(N257), .A1N(n316), .Y(n209) );
  OAI2BB2XL U469 ( .B0(n480), .B1(busy), .A0N(N258), .A1N(n316), .Y(n208) );
  OAI2BB2XL U470 ( .B0(n481), .B1(busy), .A0N(N259), .A1N(n316), .Y(n207) );
  OAI2BB2XL U471 ( .B0(n482), .B1(busy), .A0N(N260), .A1N(n316), .Y(n206) );
  OAI2BB2XL U472 ( .B0(n475), .B1(busy), .A0N(N261), .A1N(n316), .Y(n205) );
  OAI2BB2XL U473 ( .B0(n476), .B1(busy), .A0N(N262), .A1N(n315), .Y(n204) );
  OAI2BB2XL U474 ( .B0(n477), .B1(busy), .A0N(N263), .A1N(n315), .Y(n203) );
  OAI2BB2XL U475 ( .B0(n478), .B1(busy), .A0N(N264), .A1N(n315), .Y(n202) );
  OAI2BB2XL U476 ( .B0(n474), .B1(busy), .A0N(N265), .A1N(n315), .Y(n201) );
  OAI2BB2XL U477 ( .B0(n472), .B1(busy), .A0N(N266), .A1N(n315), .Y(n200) );
  OAI2BB2XL U478 ( .B0(n473), .B1(busy), .A0N(N267), .A1N(n315), .Y(n199) );
  OAI2BB2XL U479 ( .B0(n468), .B1(busy), .A0N(N268), .A1N(n315), .Y(n198) );
  OAI2BB2XL U480 ( .B0(n469), .B1(busy), .A0N(N269), .A1N(n315), .Y(n197) );
  OAI2BB2XL U481 ( .B0(n470), .B1(busy), .A0N(N270), .A1N(n315), .Y(n196) );
  OAI2BB2XL U482 ( .B0(n471), .B1(busy), .A0N(N271), .A1N(n315), .Y(n195) );
  OAI2BB2XL U483 ( .B0(n467), .B1(busy), .A0N(N272), .A1N(n315), .Y(n194) );
  OAI2BB2XL U484 ( .B0(n465), .B1(busy), .A0N(N273), .A1N(n315), .Y(n193) );
  OAI2BB2XL U485 ( .B0(n466), .B1(busy), .A0N(N274), .A1N(n316), .Y(n192) );
  OAI2BB2XL U486 ( .B0(n461), .B1(busy), .A0N(N275), .A1N(n316), .Y(n191) );
  OAI2BB2XL U487 ( .B0(n462), .B1(busy), .A0N(N276), .A1N(n316), .Y(n190) );
  OAI2BB2XL U488 ( .B0(n463), .B1(busy), .A0N(N277), .A1N(n316), .Y(n189) );
  OAI2BB2XL U489 ( .B0(n464), .B1(busy), .A0N(N278), .A1N(n315), .Y(n188) );
  OAI2BB2XL U490 ( .B0(n489), .B1(busy), .A0N(N279), .A1N(n316), .Y(n187) );
  OAI2BB2XL U491 ( .B0(n487), .B1(busy), .A0N(N280), .A1N(n315), .Y(n186) );
  OAI2BB2XL U492 ( .B0(n488), .B1(busy), .A0N(N281), .A1N(n315), .Y(n185) );
  OAI2BB2XL U493 ( .B0(n483), .B1(busy), .A0N(N282), .A1N(n315), .Y(n184) );
  OAI2BB2XL U494 ( .B0(n484), .B1(busy), .A0N(N283), .A1N(n315), .Y(n183) );
  OAI2BB2XL U495 ( .B0(n485), .B1(busy), .A0N(N284), .A1N(n315), .Y(n182) );
  OAI2BB2XL U496 ( .B0(n479), .B1(busy), .A0N(N285), .A1N(n315), .Y(n181) );
  OAI221XL U497 ( .A0(n340), .A1(n341), .B0(n336), .B1(n339), .C0(n335), .Y(
        n359) );
  NAND2X1 U498 ( .A(n314), .B(n213), .Y(n335) );
  CLKINVX1 U499 ( .A(n360), .Y(n340) );
  OAI22XL U500 ( .A0(n361), .A1(n312), .B0(n305), .B1(n490), .Y(n180) );
  OAI22XL U501 ( .A0(n364), .A1(n312), .B0(n305), .B1(n491), .Y(n179) );
  OAI22XL U502 ( .A0(n365), .A1(n312), .B0(n305), .B1(n492), .Y(n178) );
  OAI22XL U503 ( .A0(n366), .A1(n312), .B0(n305), .B1(n493), .Y(n177) );
  OAI22XL U504 ( .A0(n367), .A1(n312), .B0(n305), .B1(n494), .Y(n176) );
  OAI22XL U505 ( .A0(n368), .A1(n312), .B0(n305), .B1(n495), .Y(n175) );
  OAI22XL U506 ( .A0(n369), .A1(n312), .B0(n305), .B1(n496), .Y(n174) );
  OAI22XL U507 ( .A0(n370), .A1(n312), .B0(n305), .B1(n497), .Y(n173) );
  OAI22XL U508 ( .A0(n371), .A1(n312), .B0(n305), .B1(n498), .Y(n172) );
  OAI22XL U509 ( .A0(n361), .A1(n313), .B0(n306), .B1(n499), .Y(n171) );
  OAI22XL U510 ( .A0(n364), .A1(n313), .B0(n306), .B1(n500), .Y(n170) );
  OAI22XL U511 ( .A0(n365), .A1(n313), .B0(n306), .B1(n501), .Y(n169) );
  OAI22XL U512 ( .A0(n366), .A1(n313), .B0(n306), .B1(n502), .Y(n168) );
  OAI22XL U513 ( .A0(n367), .A1(n313), .B0(n306), .B1(n503), .Y(n167) );
  OAI22XL U514 ( .A0(n368), .A1(n313), .B0(n306), .B1(n504), .Y(n166) );
  OAI22XL U515 ( .A0(n369), .A1(n313), .B0(n306), .B1(n505), .Y(n165) );
  OAI22XL U516 ( .A0(n370), .A1(n313), .B0(n306), .B1(n506), .Y(n164) );
  OAI22XL U517 ( .A0(n371), .A1(n313), .B0(n306), .B1(n507), .Y(n163) );
  OAI22XL U518 ( .A0(n361), .A1(n308), .B0(n307), .B1(n508), .Y(n162) );
  OAI22XL U519 ( .A0(n364), .A1(n308), .B0(n307), .B1(n509), .Y(n161) );
  OAI22XL U520 ( .A0(n365), .A1(n308), .B0(n307), .B1(n510), .Y(n160) );
  OAI22XL U521 ( .A0(n366), .A1(n308), .B0(n307), .B1(n511), .Y(n159) );
  OAI22XL U522 ( .A0(n367), .A1(n308), .B0(n307), .B1(n512), .Y(n158) );
  OAI22XL U523 ( .A0(n368), .A1(n308), .B0(n307), .B1(n513), .Y(n157) );
  OAI22XL U524 ( .A0(n369), .A1(n308), .B0(n307), .B1(n514), .Y(n156) );
  OAI22XL U525 ( .A0(n370), .A1(n308), .B0(n307), .B1(n515), .Y(n155) );
  OAI22XL U526 ( .A0(n371), .A1(n308), .B0(n307), .B1(n516), .Y(n154) );
  OAI22XL U527 ( .A0(n310), .A1(n517), .B0(n361), .B1(n311), .Y(n153) );
  AOI22X1 U528 ( .A0(N394), .A1(n378), .B0(N553), .B1(n309), .Y(n361) );
  OAI22XL U529 ( .A0(n310), .A1(n518), .B0(n364), .B1(n311), .Y(n152) );
  AOI22X1 U530 ( .A0(N393), .A1(n378), .B0(N552), .B1(n309), .Y(n364) );
  OAI22XL U531 ( .A0(n310), .A1(n519), .B0(n365), .B1(n311), .Y(n151) );
  AOI22X1 U532 ( .A0(N392), .A1(n378), .B0(N551), .B1(n309), .Y(n365) );
  OAI22XL U533 ( .A0(n310), .A1(n520), .B0(n366), .B1(n311), .Y(n150) );
  AOI22X1 U534 ( .A0(N391), .A1(n378), .B0(N550), .B1(n309), .Y(n366) );
  OAI22XL U535 ( .A0(n310), .A1(n521), .B0(n367), .B1(n311), .Y(n149) );
  AOI22X1 U536 ( .A0(N390), .A1(n378), .B0(N549), .B1(n309), .Y(n367) );
  OAI22XL U537 ( .A0(n310), .A1(n522), .B0(n368), .B1(n311), .Y(n148) );
  AOI22X1 U538 ( .A0(N389), .A1(n378), .B0(N548), .B1(n309), .Y(n368) );
  OAI22XL U539 ( .A0(n310), .A1(n523), .B0(n369), .B1(n311), .Y(n147) );
  AOI22X1 U540 ( .A0(N388), .A1(n378), .B0(N547), .B1(n309), .Y(n369) );
  OAI22XL U541 ( .A0(n310), .A1(n524), .B0(n370), .B1(n311), .Y(n146) );
  AOI22X1 U542 ( .A0(N387), .A1(n378), .B0(N546), .B1(n309), .Y(n370) );
  OAI22XL U543 ( .A0(n310), .A1(n525), .B0(n371), .B1(n311), .Y(n145) );
  AOI22X1 U544 ( .A0(N386), .A1(n378), .B0(N545), .B1(n309), .Y(n371) );
  CLKINVX1 U545 ( .A(n213), .Y(n339) );
  AND3X1 U546 ( .A(busy), .B(n382), .C(n341), .Y(n372) );
  AND3X1 U547 ( .A(n460), .B(count[2]), .C(n355), .Y(n384) );
  AND4X1 U548 ( .A(n336), .B(n360), .C(busy), .D(n382), .Y(n355) );
  CLKINVX1 U549 ( .A(n390), .Y(n380) );
  NAND2X1 U550 ( .A(n390), .B(n381), .Y(n527) );
  AND2X1 U551 ( .A(N702), .B(n213), .Y(N751) );
  AND2X1 U552 ( .A(N703), .B(n213), .Y(N750) );
  AND2X1 U553 ( .A(N704), .B(n213), .Y(N749) );
  AND2X1 U554 ( .A(N705), .B(n213), .Y(N748) );
  AND2X1 U555 ( .A(N706), .B(n213), .Y(N747) );
  AND2X1 U556 ( .A(N707), .B(n213), .Y(N746) );
  AND2X1 U557 ( .A(N708), .B(n213), .Y(N745) );
  AND2X1 U558 ( .A(N709), .B(n213), .Y(N744) );
  AND2X1 U559 ( .A(N710), .B(n213), .Y(N743) );
  NAND3X1 U560 ( .A(n476), .B(n477), .C(n475), .Y(n395) );
  NAND4X1 U561 ( .A(n478), .B(n479), .C(n480), .D(n481), .Y(n394) );
  NAND3X1 U562 ( .A(n483), .B(n484), .C(n482), .Y(n393) );
  NAND4X1 U563 ( .A(n485), .B(n487), .C(n488), .D(n489), .Y(n392) );
endmodule

