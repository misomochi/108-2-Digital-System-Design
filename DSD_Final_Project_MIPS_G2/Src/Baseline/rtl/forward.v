module forward (
	input		 RegWrite_IE, //RegWriteE
	input  		 RegWrite_EM, //RegWriteM
	input  		 RegWrite_MW, //RegWriteW
	input  [4:0] RegisterRd_IE, //WriteRegE
	input  [4:0] RegisterRd_EM, //WriteRegM
	input  [4:0] RegisterRd_MW, //WriteRegW
	input  [4:0] RegisterRs_FD, //RsD
	input  [4:0] RegisterRt_FD, //RtD
	input  [4:0] RegisterRs_IE, //RsE
	input  [4:0] RegisterRt_IE, //RtE
	output [1:0] ForwardAD,
	output [1:0] ForwardBD,
	output [1:0] ForwardAE,
	output [1:0] ForwardBE
);

assign ForwardAD = (RegWrite_IE & (RegisterRd_IE != 5'b0) & (RegisterRd_IE == RegisterRs_FD)) ? 2'b11 : 
				   (RegWrite_EM & (RegisterRd_EM != 5'b0) & (RegisterRd_EM == RegisterRs_FD)) ? 2'b10 : 
				   (RegWrite_MW & (RegisterRd_MW != 5'b0) & (RegisterRd_MW == RegisterRs_FD)) ? 2'b01 : 2'b00;
assign ForwardBD = (RegWrite_IE & (RegisterRd_IE != 5'b0) & (RegisterRd_IE == RegisterRt_FD)) ? 2'b10 : 
				   //(RegWrite_EM & (RegisterRd_EM != 5'b0) & (RegisterRd_EM == RegisterRt_FD)) ? 2'b10 : 
				   (RegWrite_MW & (RegisterRd_MW != 5'b0) & (RegisterRd_MW == RegisterRt_FD)) ? 2'b01 : 2'b00;
assign ForwardAE = (RegWrite_EM & (RegisterRd_EM != 5'b0) & (RegisterRd_EM == RegisterRs_IE)) ? 2'b10 : 
				   (RegWrite_MW & (RegisterRd_MW != 5'b0) & (RegisterRd_MW == RegisterRs_IE)) ? 2'b01 : 2'b00;
assign ForwardBE = (RegWrite_EM & (RegisterRd_EM != 5'b0) & (RegisterRd_EM == RegisterRt_IE)) ? 2'b10 : 
				   (RegWrite_MW & (RegisterRd_MW != 5'b0) & (RegisterRd_MW == RegisterRt_IE)) ? 2'b01 : 2'b00;			   

endmodule