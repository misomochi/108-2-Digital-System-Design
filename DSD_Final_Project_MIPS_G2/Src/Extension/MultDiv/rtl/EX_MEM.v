module EX_MEM (
	input   	  clk,     // Clock
	input   	  rst_n,   // Asynchronous reset active low
	input         EMWrite, // cache stall
	/*control inputs*/
	input         CacheRead_i,
	input         CacheWrite_i,
	input   [1:0] CachetoReg_i,
	input         RegWrite_i,
	/*data inputs*/
	input  [31:0] ALU_result_i,
	input  [31:0] Write_data_i,
	input  [31:0] incremented_PC_i,
	input   [4:0] WriteReg_i,
	/*control outputs*/
	output reg        CacheRead_o,
	output reg        CacheWrite_o,
	output reg  [1:0] CachetoReg_o,
	output reg        RegWrite_o,
	/*data outputs*/
	output reg [31:0] ALU_result_o,
	output reg [31:0] Write_data_o,
	output reg [31:0] incremented_PC_o,
	output reg  [4:0] WriteReg_o
);

always @(posedge clk) begin
	if (~rst_n) begin
		CacheRead_o      <= 1'b0;
		CacheWrite_o     <= 1'b0;
		CachetoReg_o     <= 2'b0;
		RegWrite_o 	     <= 1'b0;

		ALU_result_o     <= 32'b0;
		Write_data_o     <= 32'b0;
		incremented_PC_o <= 32'b0;
		WriteReg_o 	     <= 5'b0;
	end else if (EMWrite) begin
		CacheRead_o      <= CacheRead_o;
		CacheWrite_o     <= CacheWrite_o;
		CachetoReg_o     <= CachetoReg_o;
		RegWrite_o 	     <= RegWrite_o;

		ALU_result_o     <= ALU_result_o;
		Write_data_o     <= Write_data_o;
		incremented_PC_o <= incremented_PC_o;
		WriteReg_o 	     <= WriteReg_o;
	end else begin
		CacheRead_o      <= CacheRead_i;
		CacheWrite_o     <= CacheWrite_i;
		CachetoReg_o     <= CachetoReg_i;
		RegWrite_o 	     <= RegWrite_i;

		ALU_result_o     <= ALU_result_i;
		Write_data_o     <= Write_data_i;
		incremented_PC_o <= incremented_PC_i;
		WriteReg_o 	     <= WriteReg_i;
	end
end

endmodule