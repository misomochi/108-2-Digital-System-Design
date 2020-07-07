`include "PC.v"
`include "add.v"
`include "IF_ID.v"
`include "registers.v"
`include "sign_extend.v"
`include "comparator.v"
`include "control.v"
`include "ID_EX.v"
`include "ALU.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "forward.v"
`include "hazard.v"
`include "PredictionUnit.v"

module MIPS_Pipeline
(
	input         clk,
	input         rst_n,
	/*I_cache interface*/
	output        ICACHE_ren,
	output        ICACHE_wen,
	output [29:0] ICACHE_addr,
	output [31:0] ICACHE_wdata,
	input         ICACHE_stall,
	input  [31:0] ICACHE_rdata,
	/*D_cache interface*/
	output        DCACHE_ren,
	output        DCACHE_wen,
	output [29:0] DCACHE_addr,
	output [31:0] DCACHE_wdata,
	input         DCACHE_stall,
	input  [31:0] DCACHE_rdata
);
//wires/regs================================
/*IF stage*/
wire [31:0] PC_o_F, PCplus4_F, SignImm_shifted_F, PCbranch_F, PCbranchPredicted_F;
wire Branch_F, BrPre_F;
/*ID stage*/
wire [31:0] inst_D, PCplus4_D, read_data1_D, read_data2_D, SignImm_D, SignImm_shifted_D, PCbranch_D, PCbranchConfirmed_D,
			read_data1_forwarded_D, read_data2_forwarded_D, Jumpaddr_D;
wire BrPre_D, missPre_D, Branch_D;
/*EX stage*/
wire [31:0] read_data1_E, read_data2_E, SignImm_E, PCplus4_E, ALU_in1_E, ALU_in2_E, WriteData_E, ALUOut_E;
wire  [4:0] rs_E, rt_E, rd_E, shamt_E, WriteReg_E;
/*MEM stage*/
wire [31:0] ALUOut_M, WriteData_M, PCplus4_M;
wire  [4:0] WriteReg_M;
/*WB stage*/
wire [31:0] PC_i_W, PCbranch_W, Result_W, ReadData_W, ALUOut_W, PCplus4_W; //PCplus8_W;
wire  [4:0] WriteReg_W;
/*ID control unit*/
wire RegWrite_D, Brncheq_D, Brnchne_D, PCSrc_D, CacheRead_D, CacheWrite_D, ALUSrc_D;
wire [1:0] Jump_D, RegDst_D, CachetoReg_D;
wire [3:0] ALU_control_D;
/*EX control unit*/
wire CacheRead_E, CacheWrite_E, ALUSrc_E, RegWrite_E;
wire [1:0] RegDst_E,CachetoReg_E; 
wire [3:0] ALU_control_E;
/*MEM control unit*/
wire CacheRead_M, CacheWrite_M, RegWrite_M;
wire [1:0] CachetoReg_M;
/*WB control unit*/
wire RegWrite_W;
wire [1:0] CachetoReg_W;
/*forward unit*/
wire [1:0] ForwardA_D, ForwardB_D, ForwardA_E, ForwardB_E;
/*hazard unit*/
wire PCWrite, FDWrite, Flush_D, Flush_E, IEWrite, EMWrite, MWWrite, CacheStall;

//contiguous assign=========================
/*IF stage*/
assign ICACHE_addr 	= PC_o_F[31:2];
assign ICACHE_wen  	= 1'b0;
assign ICACHE_ren  	= 1'b1; //read only
assign ICACHE_wdata = 32'd0;
assign SignImm_shifted_F = {{16{ICACHE_rdata[15]}}, ICACHE_rdata[15:0]} << 2;
assign Branch_F = (ICACHE_rdata[31:26]==6'd4 || ICACHE_rdata[31:26]==6'd5) ? 1 : 0;
assign PCbranchPredicted_F = (Branch_F & BrPre_F) ? PCbranch_F : PCplus4_F;
/*ID stage*/
assign read_data1_forwarded_D = (ForwardA_D == 2'b11) ? ALUOut_E : (ForwardA_D == 2'b10) ? ALUOut_M : (ForwardA_D == 2'b01) ? Result_W : read_data1_D;
assign read_data2_forwarded_D = (ForwardB_D == 2'b11) ? ALUOut_E : (ForwardA_D == 2'b10) ? ALUOut_M : (ForwardB_D == 2'b01) ? Result_W : read_data2_D;
assign Jumpaddr_D 			  = {PCplus4_D[31:28], inst_D[25:0], 2'd0};
assign PCbranchConfirmed_D    = (PCSrc_D) ? PCbranch_D : PCplus4_D;
assign Branch_D               = (Brncheq_D | Brnchne_D);
/*EX stage*/
assign WriteReg_E  = (RegDst_E 	 == 2'b00) ? rt_E 		  : ((RegDst_E == 2'b01)   ? rd_E 	  : 5'd31);
assign ALU_in1_E   = (ForwardA_E == 2'b00) ? read_data1_E : ((ForwardA_E == 2'b01) ? Result_W : ALUOut_M);
assign WriteData_E = (ForwardB_E == 2'b00) ? read_data2_E : ((ForwardB_E == 2'b01) ? Result_W : ALUOut_M);
assign ALU_in2_E   = (ALUSrc_E) 		   ? SignImm_E 	  : WriteData_E;
/*MEM stage*/
assign DCACHE_wen 	= CacheWrite_M;
assign DCACHE_ren 	= CacheRead_M;
assign DCACHE_addr 	= ALUOut_M[31:2];
assign DCACHE_wdata = WriteData_M;
/*WB stage*/
assign PCbranch_W = (missPre_D) ? PCbranchConfirmed_D : PCbranchPredicted_F;
assign PC_i_W 	  = (Jump_D == 2'b00) ? PCbranch_W : ((Jump_D == 2'b01) ? Jumpaddr_D : read_data1_forwarded_D);
assign Result_W   = (CachetoReg_W == 2'b00) ? ALUOut_W : ((CachetoReg_W == 2'b01) ? ReadData_W : PCplus4_W);
/*hazard unit*/
assign CacheStall = ICACHE_stall | DCACHE_stall;

//instances=================================
/*IF stage*/
PC pc(.clk(clk),
	  .rst_n(rst_n),
	  .PCWrite(PCWrite),
	  .PC_i(PC_i_W),
	  .PC_o(PC_o_F));

add pc_adder(.data1_i(PC_o_F),
			 .data2_i(32'd4),
			 .sum_o(PCplus4_F));

PredictionUnit predict(.clk(clk),
					   .rst_n(rst_n),
					   .stall(PCWrite),
					   .PreWrong(missPre_D),
					   .B(Branch_D),
					   .BrPre(BrPre_F));

add branch_adder_F(.data1_i(PCplus4_F),
				   .data2_i(SignImm_shifted_F),
				   .sum_o(PCbranch_F));
/*IF/ID pipeline gate*/
IF_ID if_id(.clk(clk),
			.rst_n(rst_n),
			.FDWrite(FDWrite),
			.nop(missPre_D | Flush_D),
			.BrPre_i(BrPre_F),
			.instruction_i(ICACHE_rdata),
			.incremented_PC_i(PCplus4_F),
			.PCbranch_i(PCbranch_F),
			.BrPre_o(BrPre_D),
			.instruction_o(inst_D),
			.incremented_PC_o(PCplus4_D),
			.PCbranch_o(PCbranch_D));
/*ID stage*/
registers register(.clk(clk),
				   .rst_n(rst_n),
				   .read_reg1(inst_D[25:21]),
				   .read_reg2(inst_D[20:16]),
				   .write_reg(WriteReg_W),
				   .write_data(Result_W),
				   .RegWrite(RegWrite_W),
				   .read_data1(read_data1_D),
				   .read_data2(read_data2_D));

sign_extend sign_ext(.data_i(inst_D[15:0]),
					 .data_o(SignImm_D));

comparator compare(.read_data1_i(read_data1_forwarded_D),
				   .read_data2_i(read_data2_forwarded_D),
				   .Brncheq_i(Brncheq_D),
				   .Brnchne_i(Brnchne_D),
				   .BrPre_i(BrPre_D),
				   .Branch_o(PCSrc_D),
				   .missPre_o(missPre_D));

control ctrl(.instruction_i(inst_D),
			 .RegDst_o(RegDst_D),
			 .Jump_o(Jump_D),
			 .Brncheq_o(Brncheq_D),
			 .Brnchne_o(Brnchne_D),
			 .CachetoReg_o(CachetoReg_D),
			 .ALU_control_o(ALU_control_D),
			 .CacheRead_o(CacheRead_D),
			 .CacheWrite_o(CacheWrite_D),
			 .ALUSrc_o(ALUSrc_D),
			 .RegWrite_o(RegWrite_D));
/*ID/EX pipeline gate*/
ID_EX id_ex(.clk(clk),
			.rst_n(rst_n),
			.nop(Flush_E),
			.IEWrite(IEWrite),
			.RegDst_i(RegDst_D),
			.CachetoReg_i(CachetoReg_D),
			.ALU_control_i(ALU_control_D),
			.CacheRead_i(CacheRead_D),
			.CacheWrite_i(CacheWrite_D),
			.ALUSrc_i(ALUSrc_D),
			.RegWrite_i(RegWrite_D),
			.read_data1_i(read_data1_forwarded_D),
			.read_data2_i(read_data2_forwarded_D),
			.SignExtImm_i(SignImm_D),
			.incremented_PC_i(PCplus4_D),
			.rs_i(inst_D[25:21]),
			.rt_i(inst_D[20:16]),
			.rd_i(inst_D[15:11]),
			.shamt_i(inst_D[10:6]),
			.RegDst_o(RegDst_E),
			.CachetoReg_o(CachetoReg_E),
			.ALU_control_o(ALU_control_E),
			.CacheRead_o(CacheRead_E),
			.CacheWrite_o(CacheWrite_E),
			.ALUSrc_o(ALUSrc_E),
			.RegWrite_o(RegWrite_E),
			.read_data1_o(read_data1_E),
			.read_data2_o(read_data2_E),
			.SignExtImm_o(SignImm_E),
			.incremented_PC_o(PCplus4_E),
			.rs_o(rs_E),
			.rt_o(rt_E),
			.rd_o(rd_E),
			.shamt_o(shamt_E));
/*EX stage*/
ALU alu(.data1_i(ALU_in1_E),
		.data2_i(ALU_in2_E),
		.shamt_i(shamt_E),
		.ALU_control_i(ALU_control_E),
		.result_o(ALUOut_E));
/*EX_MEM pipeline stage*/
EX_MEM ex_mem(.clk(clk),
			  .rst_n(rst_n),
			  .EMWrite(EMWrite),
			  .CacheRead_i(CacheRead_E),
			  .CacheWrite_i(CacheWrite_E),
			  .CachetoReg_i(CachetoReg_E),
			  .RegWrite_i(RegWrite_E),
			  .ALU_result_i(ALUOut_E),
			  .Write_data_i(WriteData_E),
			  .incremented_PC_i(PCplus4_E),
			  .WriteReg_i(WriteReg_E),
			  .CacheRead_o(CacheRead_M),
			  .CacheWrite_o(CacheWrite_M),
			  .CachetoReg_o(CachetoReg_M),
			  .RegWrite_o(RegWrite_M),
			  .ALU_result_o(ALUOut_M),
			  .Write_data_o(WriteData_M),
			  .incremented_PC_o(PCplus4_M),
			  .WriteReg_o(WriteReg_M));
/*MEM_WB pipeline stage*/
MEM_WB mem_wb(.clk(clk),
			  .rst_n(rst_n),
			  .MWWrite(MWWrite),
			  .RegWrite_i(RegWrite_M),
			  .CachetoReg_i(CachetoReg_M),
			  .Read_data_i(DCACHE_rdata),
			  .ALU_result_i(ALUOut_M),
			  .incremented_PC_i(PCplus4_M),
			  .WriteReg_i(WriteReg_M),
			  .RegWrite_o(RegWrite_W),
			  .CachetoReg_o(CachetoReg_W),
			  .Read_data_o(ReadData_W),
			  .ALU_result_o(ALUOut_W),
			  .incremented_PC_o(PCplus4_W),
			  .WriteReg_o(WriteReg_W));
/*WB stage*/
/*add jal_adder(.data1_i(PCplus4_W),
			  .data2_i(32'd4),
			  .sum_o(PCplus8_W));*/
/*forward unit*/
forward forward(.RegWrite_IE(RegWrite_E),
				.RegWrite_EM(RegWrite_M),
				.RegWrite_MW(RegWrite_W),
				.RegisterRd_IE(WriteReg_E),
				.RegisterRd_EM(WriteReg_M),
				.RegisterRd_MW(WriteReg_W),
				.RegisterRs_FD(inst_D[25:21]),
				.RegisterRt_FD(inst_D[20:16]),
				.RegisterRs_IE(rs_E),
				.RegisterRt_IE(rt_E),
				.ForwardAD(ForwardA_D),
				.ForwardBD(ForwardB_D),
				.ForwardAE(ForwardA_E),
				.ForwardBE(ForwardB_E));
/*hazard unit*/
hazard hazard(.Jump(Jump_D),
			  .CacheRead_IE(CacheRead_E),
			  .CacheStall(CacheStall),
			  .RegisterRs_FD(inst_D[15:11]),
			  .RegisterRt_FD(inst_D[20:16]),
			  .RegisterRt_IE(rt_E),
			  .PCWrite(PCWrite),
			  .FDWrite(FDWrite),
			  .IEWrite(IEWrite),
			  .EMWrite(EMWrite),
			  .MWWrite(MWWrite),
			  .nop_IE(Flush_E),
			  .nop_FD(Flush_D));

endmodule
