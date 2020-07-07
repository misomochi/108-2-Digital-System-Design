module simple_calculator(
    Clk,
    WEN,
    RW,
    RX,
    RY,
    DataIn,
    Sel,
    Ctrl,
    busY,
    Carry
);

    input        Clk;
    input        WEN;
    input  [2:0] RW, RX, RY;
    input  [7:0] DataIn;
    input        Sel;
    input  [3:0] Ctrl;
    output [7:0] busY;
    output       Carry;

// declaration of wire/reg
    wire [7:0] x, y, busW, busX;

    assign x = (Sel) ? busX : DataIn; //MUX
    assign busY = y;
    
// submodule instantiation
    alu_always ALU(.ctrl(Ctrl), .x(x), .y(y), .carry(Carry), .out(busW));
    register_file REG(.Clk(Clk), .WEN(WEN), .RW(RW), .busW(busW), .RX(RX), .RY(RY), .busX(busX), .busY(y));


endmodule

//RT ¡Vlevel (event-driven) 
module alu_always(
    ctrl,
    x,
    y,
    carry,
    out 
);
    
    input      [3:0] ctrl;
    input      [7:0] x;
    input      [7:0] y;
    output reg carry;
    output reg [7:0] out;
    
    always @(ctrl or x or y) begin
        case (ctrl)
            4'b0000: {carry, out} = x + y;
            4'b0001: {carry, out} = {x[7], x} - {y[7], y};
            4'b0010: {carry, out} = x & y;
            4'b0011: {carry, out} = x | y;
            4'b0100: {carry, out} = ~x;
            4'b0101: {carry, out} = x ^ y;
            4'b0110: {carry, out} = ~(x | y);
            4'b0111: {carry, out} = y << x[2:0];
            4'b1000: {carry, out} = y >> x[2:0];
            4'b1001: {carry, out} = {x[7], x[7:1]};
            4'b1010: {carry, out} = {x[6:0], x[7]};
            4'b1011: {carry, out} = {x[0], x[7:1]};
            4'b1100: {carry, out} = (x == y);
            default : {carry, out} = 9'b0;
        endcase
    end

endmodule

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
input        Clk, WEN;
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
