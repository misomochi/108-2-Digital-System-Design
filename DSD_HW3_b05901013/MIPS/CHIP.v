// Your SingleCycle MIPS code
`include "./ALU.v"
`include "./control.v"
`include "./registers.v"
`include "./PC.v"
`include "./sign_extend.v"
`include "./add.v"

module CHIP(clk,
            rst_n,
            // for mem_D
            mem_wen_D,
            mem_addr_D,
            mem_wdata_D,
            mem_rdata_D,
            // for mem_I
            mem_addr_I,
            mem_rdata_I
    );

    input         clk, rst_n ;
    // for mem_D
    output        mem_wen_D  ;  // mem_wen_D is high, CHIP writes data to D-mem; else, CHIP reads data from D-mem
    output [31:0] mem_addr_D ;  // the specific address to fetch/store data 
    output [31:0] mem_wdata_D;  // data writing to D-mem 
    input  [31:0] mem_rdata_D;  // data reading from D-mem
    // for mem_I
    output [31:0] mem_addr_I ;  // the fetching address of next instruction
    input  [31:0] mem_rdata_I;  // instruction reading from I-mem

    wire [31:0] PC_i, PC_o, writeData, ALU_data2, ALU_result, incremented_PC, Jump_address, SignExtImm, newAddress, RorI, rs, rt;
    wire [4:0] writeReg;
    wire [3:0] ALU_control;
    wire [1:0] RegDst, Jump, MemtoReg;
    wire Branch, ALUSrc, RegWrite, Zero; 

    assign mem_addr_I = PC_o;
    assign mem_addr_D = ALU_result;
    assign mem_wdata_D = rt;
    assign Jump_address = {incremented_PC[31:28], mem_rdata_I[25:0], 2'b0};
    assign RorI = (Branch & Zero) ? newAddress : incremented_PC;
    assign PC_i = (Jump == 2'b10) ? rs : ((Jump == 2'b01) ? Jump_address : RorI);
    assign writeReg = (RegDst == 2'b10) ? 5'd31 : ((RegDst == 2'b01) ? mem_rdata_I[15:11] : mem_rdata_I[20:16]);
    assign ALU_data2 = ALUSrc ? SignExtImm : rt;
    assign writeData = (MemtoReg == 2'b10) ? (incremented_PC + 4) : ((MemtoReg == 2'b01) ? mem_rdata_D : ALU_result);
    
    PC PC(.clk(clk), 
    	  .rst_n(rst_n), 
    	  .PC_i(PC_i), 
    	  .PC_o(PC_o));

    add add1(.data1_i(PC_o), 
    		 .data2_i(32'd4), 
    		 .sum_o(incremented_PC));

    add add2(.data1_i(incremented_PC), 
    		 .data2_i(SignExtImm << 2'd2), 
    		 .sum_o(newAddress));

    control control(.opcode_i(mem_rdata_I[31:26]), 
    				.funct_i(mem_rdata_I[5:0]), 
    				.RegDst_o(RegDst), 
    				.Jump_o(Jump), 
    				.Branch_o(Branch), 
    				.MemtoReg_o(MemtoReg), 
    				.ALU_control_o(ALU_control), 
    				.MemWrite_o(mem_wen_D), 
    				.ALUSrc_o(ALUSrc), 
    				.RegWrite_o(RegWrite));

    registers registers(.clk(clk), 
    					.rst_n(rst_n), 
    					.read_reg1(mem_rdata_I[25:21]), 
    					.read_reg2(mem_rdata_I[20:16]), 
    					.write_reg(writeReg), 
    					.write_data(writeData), 
    					.RegWrite(RegWrite), 
    					.read_data1(rs), 
    					.read_data2(rt));

    ALU ALU(.data1_i(rs),
    		.data2_i(ALU_data2),
    		.ALU_control_i(ALU_control),
    		.result_o(ALU_result),
    		.zero_o(Zero));

    sign_extend sign_extend(.data_i(mem_rdata_I[15:0]), 
    						.data_o(SignExtImm));
    
endmodule