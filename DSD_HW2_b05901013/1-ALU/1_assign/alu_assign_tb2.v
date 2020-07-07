//continuous assignment tb
`timescale 1ns/10ps
`define CYCLE   10
`define HCYCLE  5

module alu_assign_tb;
    reg  [3:0] ctrl;
    reg  [7:0] x;
    reg  [7:0] y;
    wire       carry;
    wire [7:0] out;
    
    alu_assign alu_assign(
        ctrl     ,
        x        ,
        y        ,
        carry    ,
        out  
    );

   initial begin
       $fsdbDumpfile("alu_assign2.fsdb");
       $fsdbDumpvars;
   end

    initial begin
        ctrl = 4'b1101;
        x    = 8'b1111_1111; //-1
        y    = 8'b1; //1

        #(`CYCLE);
        // 0100 boolean not
        ctrl = 4'b0100;

        #(`HCYCLE);
        if( out == 8'b0 ) 
            $display( "PASS --- 0100 boolean not" );
        else 
            $display( "FAIL --- 0100 boolean not, out = %b", out );
        
        #(`CYCLE);
        // 0000 signed add
        ctrl = 4'b0000;

        #(`HCYCLE);
        // -1 + 1 = 0
        if( {carry, out} == 9'b1_0000_0000 ) 
            $display( "PASS --- 0000 add (signed)" );
        else 
            $display( "FAIL --- 0000 add (signed), carry = %b, out = %b", carry, out );

        #(`CYCLE);
        // 0001 signed subtract
        ctrl = 4'b0001;

        #(`HCYCLE);
        // -1 - 1 = -2
        if( {carry, out} == 9'b1_1111_1110 ) 
            $display( "PASS --- 0001 sub (signed)" );
        else 
            $display( "FAIL --- 0001 sub (signed), carry = %b, out = %b", carry, out );
        
        #(`CYCLE);
        // 0010 boolean and
        ctrl = 4'b0010;

        #(`HCYCLE);
        // 1111_1111 & 0000_0001 = 0000_0001
        if( out == 8'b1 ) 
            $display( "PASS --- 0010 boolean and" );
        else 
            $display( "FAIL --- 0010 boolean and, out = %b", out );
        
        #(`CYCLE);
        // 0011 boolean or
        ctrl = 4'b0011;
        
        #(`HCYCLE);
        // 1111_1111 | 0000_0001 = 1111_1111
        if( out == 8'b1111_1111 ) 
            $display( "PASS --- 0011 boolean or" );
        else 
            $display( "FAIL --- 0011 boolean or, out = %b", out );
        
        #(`CYCLE);
        // 0101 boolean xor
        ctrl = 4'b0101;
        
        #(`HCYCLE);
        // 1111_1111 ^ 0000_0001 = 1111_1110
        if( out == 8'b1111_1110 ) 
            $display( "PASS --- 0101 boolean xor" );
        else 
            $display( "FAIL --- 0101 boolean xor, out = %b", out );
        
        #(`CYCLE);
        // 0110 bitwise nor
        ctrl = 4'b0110;

        #(`HCYCLE);
        // ~(1111_1111 | 0000_0001) = 0000_0000
        if( out == 8'b0 ) 
            $display( "PASS --- 0110 boolean nor" );
        else 
            $display( "FAIL --- 0110 boolean nor, out = %b", out );
        
        #(`CYCLE);
        // 0111 shift left logical variable
        ctrl = 4'b0111;

        #(`HCYCLE);
        // 0000_0001 << 111 = 1000_0000
        if( out == 8'b1000_0000 ) 
            $display( "PASS --- 0111 shift left logical variable" );
        else 
            $display( "FAIL --- 0111 shift left logical variable, out = %b", out );
        
        #(`CYCLE);
        // 1000 shift right logical variable
        ctrl = 4'b1000;

        #(`HCYCLE);
        // 0000_0001 >> 111 = 0000_0000
        if( out == 8'b0 ) 
            $display( "PASS --- 1000 shift right logical variable" );
        else 
            $display( "FAIL --- 1000 shift right logical variable, out = %b", out );
        
        #(`CYCLE);
        // 1001 shift right arithmetic
        ctrl = 4'b1001;

        #(`HCYCLE);
        // 1111_1111 -> 1111_1111
        if( out == 8'b1111_1111 ) 
            $display( "PASS --- 1001 shift right arithmetic" );
        else 
            $display( "FAIL --- 1001 shift right arithmetic, out = %b", out );
        
        #(`CYCLE);
        // 1010 rotate left
        ctrl = 4'b1010;

        #(`HCYCLE);
        // 1111_1111 -> 1111_1111
        if( out == 8'b1111_1111 ) 
            $display( "PASS --- 1010 rotate left" );
        else 
            $display( "FAIL --- 1010 rotate left, out = %b", out );
        
        #(`CYCLE);
        // 1011 rotate right
        ctrl = 4'b1011;

        #(`HCYCLE);
        // 1111_1111 -> 1111_1111
        if( out == 8'b1111_1111 ) 
            $display( "PASS --- 1011 rotate right" );
        else 
            $display( "FAIL --- 1011 rotate right, out = %b", out );
        
        #(`CYCLE);
        // 1100 equal
        ctrl = 4'b1100;

        #(`HCYCLE);
        // 1111_1111 != 0000_0001
        if( out == 8'b0 ) 
            $display( "PASS --- 1100 equal" );
        else 
            $display( "FAIL --- 1100 equal, out = %b", out );
        
        #(`CYCLE);
        // 1101 nop
        ctrl = 4'b1101;

        #(`HCYCLE);
        if( out == 8'b0 ) 
            $display( "PASS --- 1101 NOP" );
        else 
            $display( "FAIL --- 1101 NOP, out = %b", out );
        
        #(`CYCLE);
        // 1110 nop
        ctrl = 4'b1110;

        #(`HCYCLE);
        if( out == 8'b0 ) 
            $display( "PASS --- 1110 NOP" );
        else 
            $display( "FAIL --- 1110 NOP, out = %b", out );
        
        #(`CYCLE);
        // 1111 nop
        ctrl = 4'b1111;

        #(`HCYCLE);
        if( out == 8'b0 ) 
            $display( "PASS --- 1111 NOP" );
        else 
            $display( "FAIL --- 1111 NOP, out = %b", out );
        
        // finish tb
        #(`CYCLE) $finish;
    end

endmodule
