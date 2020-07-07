module PC (
	input  	   		  clk,    // Clock
	input  	   		  rst_n,  // Synchronous reset active low
	input  	   [31:0] PC_i,
	output reg [31:0] PC_o
);

always @(posedge clk) begin
	if(~rst_n) begin
		PC_o <= 32'b0;
	end else begin
		PC_o <= PC_i;
	end
end

endmodule