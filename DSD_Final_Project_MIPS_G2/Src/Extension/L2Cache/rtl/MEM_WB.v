module MEM_WB
(
	input   	  clk,     // Clock
	input   	  rst_n,   // Asynchronous reset active low
	input         MWWrite, // cache stall
	/*control inputs*/
	input         RegWrite_i,
	input   [1:0] CachetoReg_i,
	/*data inputs*/
	input  [31:0] Read_data_i,
	input  [31:0] ALU_result_i,
	input  [31:0] incremented_PC_i,
	input   [4:0] WriteReg_i,
	/*control outputs*/
	output reg        RegWrite_o,
	output reg  [1:0] CachetoReg_o,
	/*data outputs*/
	output reg [31:0] Read_data_o,
	output reg [31:0] ALU_result_o,
	output reg [31:0] incremented_PC_o,
	output reg  [4:0] WriteReg_o
);

always@(posedge clk)begin
	if(~rst_n)begin
		RegWrite_o 	     <= 1'b0;
		CachetoReg_o     <= 2'd0;

		Read_data_o      <= 32'd0;
		ALU_result_o     <= 32'd0;
		incremented_PC_o <= 32'd0;
		WriteReg_o 	     <= 5'd0;
	end else if (MWWrite) begin
		RegWrite_o 	     <= RegWrite_o;
		CachetoReg_o     <= CachetoReg_o;

		Read_data_o      <= Read_data_o;
		ALU_result_o     <= ALU_result_o;
		incremented_PC_o <= incremented_PC_o;
		WriteReg_o 	     <= WriteReg_o;
	end else begin
		RegWrite_o 	     <= RegWrite_i;
		CachetoReg_o     <= CachetoReg_i;
		
		Read_data_o      <= Read_data_i;
		ALU_result_o     <= ALU_result_i;
		incremented_PC_o <= incremented_PC_i;
		WriteReg_o 	     <= WriteReg_i;
	end
end


endmodule