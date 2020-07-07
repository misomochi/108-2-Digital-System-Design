module IF_ID (
	input   		  clk,    // Clock
	input    		  rst_n,  // Asynchronous reset active low
	input		      FDWrite,// load-use data hazard stall 
	input             nop,    // branch hazard flush (clear)
	input  	   [31:0] instruction_i,
	input      [31:0] incremented_PC_i, //PC + 4
	output reg [31:0] instruction_o,
	output reg [31:0] incremented_PC_o
);

always @(posedge clk) begin
	if(~rst_n) begin
		instruction_o    <= 32'b0;
		incremented_PC_o <= 32'b0;
	end else if (FDWrite) begin //stall (re-fetch)
		instruction_o 	 <= instruction_o;
		incremented_PC_o <= incremented_PC_o;
	end else begin
		incremented_PC_o <= incremented_PC_i;
		//only instruction field needs to be ZEROed
		if (nop) instruction_o <= 32'b0;
		else 	 instruction_o <= instruction_i;
	end
end

endmodule