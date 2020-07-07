module PC (
	input  	   		  clk,     // Clock
	input  	   		  rst_n,   // Synchronous reset active low
	input			  PCWrite, //load-use data hazard stall
	input  	   [31:0] PC_i,
	output reg [31:0] PC_o
);

always @(posedge clk) begin
	if (~rst_n) 	  PC_o <= 32'b0;
	else if (PCWrite) PC_o <= PC_o; //stall (re-fetch)
	else 			  PC_o <= PC_i;
end

endmodule