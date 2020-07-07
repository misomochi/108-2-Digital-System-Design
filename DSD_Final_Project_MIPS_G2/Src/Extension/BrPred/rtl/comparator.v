module comparator (
	input  [31:0] read_data1_i, //$rs
	input  [31:0] read_data2_i, //$rt
	input  Brncheq_i,
	input  Brnchne_i,
	input  BrPre_i,    //prediction from predict unit
	output Branch_o, //decide PC + 4 (0) or branch address (1), IF/ID clear
	output missPre_o   //1 == miss prediction, 0 == correct prediction
);

wire equal;

assign equal = (read_data1_i == read_data2_i);
assign Branch_o = (Brncheq_i & equal) | (Brnchne_i & ~equal);
assign missPre_o = (Brncheq_i | Brnchne_i) ? (Branch_o ^ BrPre_i) : 0;

endmodule