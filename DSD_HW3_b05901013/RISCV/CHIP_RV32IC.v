// Your SingleCycle RISC-V code which also supports compressed-instruction. 
`include "./PC.v"
`include "./decompressor.v"
`include "./control.v"
`include "./registers.v"
`include "./ImmGen.v"
`include "./ALU.v"
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

    wire [31:0] PC_i, PC_o, instruction, immediate, incremented_PC, increment, JalorBeqAddr, JalrAddr, rs1, rs2, data2, ALU_result, write_data_r;
    wire [3:0] ALUCtrl;
    wire compr, Jalr, Jal, Branch, MemRead, MemtoReg, ALUSrc, RegWrite, Zero;

    assign PC_i = ((Branch & Zero) | Jal) ? JalorBeqAddr : (Jalr ? JalrAddr : incremented_PC);
    assign mem_addr_I = PC_o;
    assign increment = compr ? 32'd2 : 32'd4;
    assign data2 = ALUSrc ? immediate : rs2;
    assign mem_addr_D = ALU_result;
    assign mem_wdata_D = {rs2[7:0], rs2[15:8], rs2[23:16], rs2[31:24]}; //little endian conversion
    assign write_data_r = (Jal | Jalr) ? incremented_PC : (MemtoReg ? {mem_rdata_D[7:0], mem_rdata_D[15:8], mem_rdata_D[23:16], mem_rdata_D[31:24]} : ALU_result);

    PC PC(.clk(clk),
          .rst_n(rst_n),
          .PC_i(PC_i),
          .PC_o(PC_o));

    decompressor decompressor(.PC(PC_o[1:0]),
                              .inst_raw({mem_rdata_I[7:0], mem_rdata_I[15:8], mem_rdata_I[23:16], mem_rdata_I[31:24]}), //little endian conversion
                              .inst(instruction),
                              .compr(compr));

    add add1(.data1_i(PC_o),
             .data2_i(increment),
             .sum_o(incremented_PC));

    add add2(.data1_i(PC_o),
             .data2_i(immediate),
             .sum_o(JalorBeqAddr));

    add add3(.data1_i(rs1),
             .data2_i(immediate),
             .sum_o(JalrAddr));

    control control(.opcode_i(instruction[6:0]),
                    .funct3_i(instruction[14:12]),
                    .funct7_i(instruction[30]), //funct7[5]
                    .Jalr_o(Jalr),
                    .Jal_o(Jal),
                    .Branch_o(Branch),
                    .MemRead_o(MemRead),
                    .MemtoReg_o(MemtoReg),
                    .ALUCtrl_o(ALUCtrl),
                    .MemWrite_o(mem_wen_D),
                    .ALUSrc_o(ALUSrc),
                    .RegWrite_o(RegWrite));

    registers registers(.clk(clk),
                        .rst_n(rst_n),
                        .read_reg1(instruction[19:15]),
                        .read_reg2(instruction[24:20]),
                        .write_reg(instruction[11:7]),
                        .write_data(write_data_r),
                        .RegWrite(RegWrite),
                        .read_data1(rs1),
                        .read_data2(rs2));

    ALU ALU(.ctrl_i(ALUCtrl),
            .data1_i(rs1),
            .data2_i(data2),
            .ALU_result_o(ALU_result),
            .zero_o(Zero));

    ImmGen ImmGen(.instruction_i(instruction),
                  .offset_o(immediate));
    
endmodule