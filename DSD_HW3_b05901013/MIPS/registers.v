module registers (
	input  		  clk,    // Clock
	input  		  rst_n,  // Synchronous reset active low
	input  [4:0]  read_reg1,
	input  [4:0]  read_reg2,
	input  [4:0]  write_reg,
	input  [31:0] write_data,
	input  		  RegWrite,
	output [31:0] read_data1,
	output [31:0] read_data2
);

reg [31:0] r [0:31];
integer i;

assign read_data1 = r[read_reg1];
assign read_data2 = r[read_reg2];

always @(posedge clk) begin
	if(~rst_n) begin
		for (i = 0; i < 32; i = i + 1) begin
			r[i] <= 32'b0;
		end
	end else begin
		if (RegWrite) begin
			/*if (write_reg == 5'b0) begin
				r[0] <= 32'b0;
			end else begin
				r[write_reg] <= write_data;
			end*/
			case (write_reg)
				5'b00000: r[0]	<= 32'b0;
				5'b00001: r[1] 	<= write_data;
				5'b00010: r[2] 	<= write_data;
				5'b00011: r[3] 	<= write_data;
				5'b00100: r[4] 	<= write_data;
				5'b00101: r[5] 	<= write_data;
				5'b00110: r[6] 	<= write_data;
				5'b00111: r[7] 	<= write_data;
				5'b01000: r[8] 	<= write_data;
				5'b01001: r[9] 	<= write_data;
				5'b01010: r[10] <= write_data;
				5'b01011: r[11] <= write_data;
				5'b01100: r[12] <= write_data;
				5'b01101: r[13] <= write_data;
				5'b01110: r[14] <= write_data;
				5'b01111: r[15] <= write_data;
				5'b10000: r[16] <= write_data;
				5'b10001: r[17] <= write_data;
				5'b10010: r[18] <= write_data;
				5'b10011: r[19] <= write_data;
				5'b10100: r[20] <= write_data;
				5'b10101: r[21] <= write_data;
				5'b10110: r[22] <= write_data;
				5'b10111: r[23] <= write_data;
				5'b11000: r[24] <= write_data;
				5'b11001: r[25] <= write_data;
				5'b11010: r[26] <= write_data;
				5'b11011: r[27] <= write_data;
				5'b11100: r[28] <= write_data;
				5'b11101: r[29] <= write_data;
				5'b11110: r[30] <= write_data;
				5'b11111: r[31] <= write_data;
				default : r[0]  <= 32'b0;
			endcase
		end else begin
			//r[write_reg] <= r[write_reg];
			r[0]  <= 32'b0;
			r[1]  <= r[1];
			r[2]  <= r[2];
			r[3]  <= r[3];
			r[4]  <= r[4];
			r[5]  <= r[5];
			r[6]  <= r[6];
			r[7]  <= r[7];
			r[8]  <= r[8];
			r[9]  <= r[9];
			r[10] <= r[10];
			r[11] <= r[11];
			r[12] <= r[12];
			r[13] <= r[13];
			r[14] <= r[14];
			r[15] <= r[15];
			r[16] <= r[16];
			r[17] <= r[17];
			r[18] <= r[18];
			r[19] <= r[19];
			r[20] <= r[20];
			r[21] <= r[21];
			r[22] <= r[22];
			r[23] <= r[23];
			r[24] <= r[24];
			r[25] <= r[25];
			r[26] <= r[26];
			r[27] <= r[27];
			r[28] <= r[28];
			r[29] <= r[29];
			r[30] <= r[30];
			r[31] <= r[31];
		end
	end
end

endmodule