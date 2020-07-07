module hazard (
	input  [1:0] Jump,
	input  		 CacheRead_IE,  //ID/EX.CacheRead
	input		 CacheStall,	//stall from cache
	input  [4:0] RegisterRs_FD, //instruction[25:21] (RsD)
	input  [4:0] RegisterRt_FD, //instruction[20:16] (RtD)
	input  [4:0] RegisterRt_IE, //(RtE)
	output 		 PCWrite, //stall PC
	output 		 FDWrite, //IF/DWrite (StallD)
	output		 IEWrite, //stall ID/EX
	output		 EMWrite, //stall EX/MEM
	output		 MWWrite, //stall MEM/WB
	output 		 nop_IE, //flush ID/EX when load-use hazard
	output		 nop_FD //flush IF/ID when j, jr, jal, jalr
);

assign {PCWrite, FDWrite} = (CacheRead_IE & ((RegisterRt_IE == RegisterRs_FD) | (RegisterRt_IE == RegisterRt_FD)) | CacheStall) ? 2'b11 : 2'b00;
assign {IEWrite, EMWrite, MWWrite} = CacheStall ? 3'b111 : 3'b000;
assign nop_IE  = (CacheRead_IE & ((RegisterRt_IE == RegisterRs_FD) | (RegisterRt_IE == RegisterRt_FD))) ? 1'b1 : 1'b0;
assign nop_FD  = (Jump[1] ^ Jump[0]) ? 1'b1 : 1'b0;

endmodule