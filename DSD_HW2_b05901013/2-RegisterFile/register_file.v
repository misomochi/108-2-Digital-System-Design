module register_file(
    Clk  ,
    WEN  ,
    RW   ,
    busW ,
    RX   ,
    RY   ,
    busX ,
    busY
);
input   	 Clk, WEN;
input  [2:0] RW, RX, RY;
input  [7:0] busW;
output [7:0] busX, busY;
    
// write your design here, you can delcare your own wires and regs. 
// The code below is just an example template
reg [7:0] r [0:7];

    
assign busX = r[RX];
assign busY = r[RY];

always@(posedge Clk) begin
	if (WEN) begin
		case (RW)
			3'b000: r[0] <= 8'b0;
			3'b001: r[1] <= busW;
			3'b010: r[2] <= busW;
			3'b011: r[3] <= busW;
			3'b100: r[4] <= busW;
			3'b101: r[5] <= busW;
			3'b110: r[6] <= busW;
			3'b111: r[7] <= busW;
			default : r[0] <= 8'b0; //3'b000
		endcase
	end
	else begin
		r[0] <= 8'b0;
		r[1] <= r[1];
		r[2] <= r[2];
		r[3] <= r[3];
		r[4] <= r[4];
		r[5] <= r[5];
		r[6] <= r[6];
		r[7] <= r[7];
	end
end	

endmodule
