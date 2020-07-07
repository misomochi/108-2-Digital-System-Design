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
