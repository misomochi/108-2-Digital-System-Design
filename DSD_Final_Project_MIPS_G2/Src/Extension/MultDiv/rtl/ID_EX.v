module ID_EX (
	input   	  clk,     // Clock
	input   	  rst_n,   // Asynchronous reset active low
	input		  nop,	   // flush when load-use data hazard
	input 		  IEWrite, // cache stall
	/*control inputs*/
	input   [1:0] RegDst_i,
	input   [1:0] CachetoReg_i,
	input   [3:0] ALU_control_i,
	input   	  CacheRead_i,
	input   	  CacheWrite_i,
	input   	  ALUSrc_i,
	input   	  RegWrite_i,
	input 		  HLRead_i,
	input 		  HLWrite_i,
	input 		  HLSrc_i,
	/*data inputs*/
	input  [31:0] read_data1_i, //$rs
	input  [31:0] read_data2_i, //$rt
	input  [31:0] SignExtImm_i,
	input  [31:0] incremented_PC_i, //PC+4
	input	[4:0] rs_i, //instruction[25:21]
	input   [4:0] rt_i, //instruction[20:16]
	input   [4:0] rd_i, //instruction[15:11]
	input   [4:0] shamt_i, //instruction[10:6]
	/*control outputs*/
	output reg  [1:0] RegDst_o,
	output reg  [1:0] CachetoReg_o,
	output reg  [3:0] ALU_control_o,
	output reg 	  CacheRead_o,
	output reg 	  CacheWrite_o,
	output reg 	  ALUSrc_o,
	output reg 	  RegWrite_o,
	output reg 	  HLRead_o,
	output reg 	  HLWrite_o,
	output reg 	  HLSrc_o,
	/*data outputs*/
	output reg [31:0] read_data1_o,
	output reg [31:0] read_data2_o,
	output reg [31:0] SignExtImm_o,
	output reg [31:0] incremented_PC_o,
	output reg  [4:0] rs_o,
	output reg  [4:0] rt_o,
	output reg  [4:0] rd_o,
	output reg  [4:0] shamt_o
);

always @(posedge clk) begin
	if(~rst_n) begin
		RegDst_o 		 <= 2'b0;
		CachetoReg_o 	 <= 2'b0;
		ALU_control_o 	 <= 4'b0;
		CacheRead_o		 <= 1'b0;
		CacheWrite_o 	 <= 1'b0;
		ALUSrc_o 		 <= 1'b0;
		RegWrite_o 		 <= 1'b0;
		HLRead_o 		 <= 1'b0;
		HLWrite_o		 <= 1'b0;
		HLSrc_o 		 <= 1'b0;

		rs_o 			 <= 5'b0;
		rt_o 			 <= 5'b0;
		rd_o 			 <= 5'b0;
		shamt_o          <= 5'd0;
		read_data1_o 	 <= 32'b0;
		read_data2_o 	 <= 32'b0;
		SignExtImm_o 	 <= 32'b0;
		incremented_PC_o <= 32'd0;
	end else if (IEWrite) begin
		RegDst_o 	  	 <= RegDst_o;
		CachetoReg_o  	 <= CachetoReg_o;
		ALU_control_o 	 <= ALU_control_o;
		CacheRead_o	  	 <= CacheRead_o;
		CacheWrite_o  	 <= CacheWrite_o;
		ALUSrc_o 	  	 <= ALUSrc_o;
		RegWrite_o 	  	 <= RegWrite_o;
		HLRead_o 		 <= HLRead_o;
		HLWrite_o		 <= HLWrite_o;
		HLSrc_o 		 <= HLSrc_o;

		rs_o 			 <= rs_o;
		rt_o 			 <= rt_o;
		rd_o 			 <= rd_o;
		shamt_o          <= shamt_o;
		incremented_PC_o <= incremented_PC_o;
		read_data1_o 	 <= read_data1_o;
		read_data2_o 	 <= read_data2_o;
		SignExtImm_o 	 <= SignExtImm_o;
	end else begin
		rs_o 			 <= rs_i;
		rt_o 			 <= rt_i;
		rd_o 			 <= rd_i;
		shamt_o          <= shamt_i;
		incremented_PC_o <= incremented_PC_i;
		read_data1_o 	 <= read_data1_i;
		read_data2_o 	 <= read_data2_i;
		SignExtImm_o 	 <= SignExtImm_i;

		if (nop) begin //NOP: change control fields of ID/EX to 0
			RegDst_o 	  <= 2'b00;
			CachetoReg_o  <= 2'b00;
			ALU_control_o <= 4'b1111;
			CacheRead_o	  <= 1'b0;
			CacheWrite_o  <= 1'b0;
			ALUSrc_o 	  <= 1'b0;
			RegWrite_o 	  <= 1'b0;
			HLRead_o	  <= 1'b0;
			HLWrite_o 	  <= 1'b0;
			HLSrc_o 	  <= 1'b0;
		end else begin
			RegDst_o 	  <= RegDst_i;
			CachetoReg_o  <= CachetoReg_i;
			ALU_control_o <= ALU_control_i;
			CacheRead_o	  <= CacheRead_i;
			CacheWrite_o  <= CacheWrite_i;
			ALUSrc_o 	  <= ALUSrc_i;
			RegWrite_o 	  <= RegWrite_i;
			HLRead_o 	  <= HLRead_i;
			HLWrite_o 	  <= HLWrite_i;
			HLSrc_o 	  <= HLSrc_i;
		end
	end
end

endmodule