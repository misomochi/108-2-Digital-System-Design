module comparator (
	input [31:0] read_data1_i, //$rs
	input [31:0] read_data2_i, //$rt
	input Brncheq_i,
	input Brnchne_i,
	output Branch_o //decide PC + 4 (0) or branch address (1), IF/ID clear
);

wire equal;

assign equal = (read_data1_i == read_data2_i);
assign Branch_o = (Brncheq_i & equal) | (Brnchne_i & ~equal);

endmodule