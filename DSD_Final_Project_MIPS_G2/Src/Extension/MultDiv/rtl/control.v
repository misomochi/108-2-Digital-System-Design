module control (
	input	  [31:0] instruction_i,
	output reg [1:0] RegDst_o,
	output reg [1:0] Jump_o,
	output reg 		 Brncheq_o,
	output reg 		 Brnchne_o,
	output reg [1:0] CachetoReg_o,
	output reg [3:0] ALU_control_o,
	output reg 		 CacheRead_o,
	output reg 		 CacheWrite_o,
	output reg 		 ALUSrc_o,
	output reg 		 RegWrite_o,
	output reg 		 HLRead_o,
	output reg 		 HLWrite_o,
	output reg 		 HLSrc_o
);

localparam AND = 4'd0, OR = 4'd1, ADD = 4'd2, SUB = 4'd3, SLT = 4'd4, SLL = 4'd5, SRL = 4'd6, SRA = 4'd7, XOR = 4'd8, NOR = 4'd9, MULT = 4'd10, DIV = 4'd11;

wire [5:0] opcode_i, funct_i;

assign opcode_i = instruction_i[31:26];
assign funct_i 	= instruction_i[5:0];

always @(*) begin
	if (instruction_i == 32'b0) begin //nop
		RegDst_o   	  = 2'b00;
		Jump_o 	   	  = 2'b00;
		Brncheq_o     = 1'b0;
		Brnchne_o	  = 1'b0;
		CachetoReg_o  = 2'b00;
		ALU_control_o = 4'b1111;
		CacheRead_o	  = 1'b0;
		CacheWrite_o  = 1'b0;
		ALUSrc_o 	  = 1'b0;
		RegWrite_o    = 1'b0;
		HLRead_o	  = 1'b0;
		HLWrite_o	  = 1'b0;
		HLSrc_o		  = 1'b0;
	end else begin
		case (opcode_i)
			6'h0: begin //r-type
				case (funct_i)
					6'h0: begin //sll
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = SLL; //sll
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h2: begin //srl
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = SRL; //srl
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h3: begin //sra
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = SRA; //sra
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h8: begin //jr
						RegDst_o   	  = 2'b11;
						Jump_o 	   	  = 2'b10; //PC = $rs
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b11;
						ALU_control_o = 4'b1111;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b0;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h9: begin //jalr
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b10; //PC = $rs
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b11;
						ALU_control_o = 4'b1111;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1; //$rd = PC
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h10: begin //mfhi
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = ADD;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1; //$rd = $HI
						HLRead_o	  = 1'b1; //$HI
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b1; //read data from HI_LO
					end
					6'h12: begin //mflo
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = ADD;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1; //$rd = $LO
						HLRead_o	  = 1'b0; //$LO
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b1; //read data from HI_LO
					end
					6'h18: begin //mult
						RegDst_o   	  = 2'b11;
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = MULT;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b0;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b1; //{$HI, $LO} = product
						HLSrc_o		  = 1'b0;
					end
					6'h1a: begin //div
						RegDst_o   	  = 2'b11;
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = DIV;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b0;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b1; //{$HI, $LO} = {remainder, quotient}
						HLSrc_o		  = 1'b0;
					end
					6'h20: begin //add
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = ADD; //add
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h22: begin //sub
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = SUB; //sub
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h24: begin //and
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = AND; //and
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h25: begin //or
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = OR; //or
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h26: begin //xor
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = XOR; //xor
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h27: begin //nor
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = NOR; //nor
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					6'h2a: begin //slt
						RegDst_o   	  = 2'b01; //$rd
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = SLT; //slt
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b1;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
					default : begin //nop
						RegDst_o   	  = 2'b00;
						Jump_o 	   	  = 2'b00;
						Brncheq_o     = 1'b0;
						Brnchne_o	  = 1'b0;
						CachetoReg_o  = 2'b00;
						ALU_control_o = 4'b1111;
						CacheRead_o	  = 1'b0;
						CacheWrite_o  = 1'b0;
						ALUSrc_o 	  = 1'b0;
						RegWrite_o    = 1'b0;
						HLRead_o	  = 1'b0;
						HLWrite_o	  = 1'b0;
						HLSrc_o		  = 1'b0;
					end
				endcase
			end
			6'h2: begin //j
				RegDst_o   	  = 2'b11;
				Jump_o 	   	  = 2'b01; //PC = JumpAddr
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b11;
				ALU_control_o = 4'b1111;
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b0;
				RegWrite_o    = 1'b0;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'h3: begin //jal
				RegDst_o   	  = 2'b10; //$ra
				Jump_o 	   	  = 2'b01; //PC = JumpAddr
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b10; //PC + 8
				ALU_control_o = 4'b1111;
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b0;
				RegWrite_o    = 1'b1; //$ra = PC
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'h4: begin //beq
				RegDst_o   	  = 2'b11;
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b1;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b11;
				ALU_control_o = 4'b1111; //nop
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b0;
				RegWrite_o    = 1'b0;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'h5: begin //bne
				RegDst_o   	  = 2'b11;
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b1;
				CachetoReg_o  = 2'b11;
				ALU_control_o = 4'b1111; //nop
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b0;
				RegWrite_o    = 1'b0;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'h8: begin //addi
				RegDst_o   	  = 2'b00; //$rt
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b00;
				ALU_control_o = ADD; //add
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b1;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'ha: begin //slti
				RegDst_o   	  = 2'b00; //$rt
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b00;
				ALU_control_o = SLT; //slt
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b1;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'hc: begin //andi
				RegDst_o   	  = 2'b00; //$rt
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b00;
				ALU_control_o = AND; //and
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b1;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'hd: begin //ori
				RegDst_o   	  = 2'b00; //$rt
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b00;
				ALU_control_o = OR; //or
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b1;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'he: begin //xori
				RegDst_o   	  = 2'b00; //$rt
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b00;
				ALU_control_o = XOR; //xor
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b1;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'h23: begin //lw
				RegDst_o   	  = 2'b00; //$rt
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b01;
				ALU_control_o = ADD; //add
				CacheRead_o	  = 1'b1;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b1;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			6'h2b: begin //sw
				RegDst_o   	  = 2'b11;
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b11;
				ALU_control_o = ADD; //add
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b1;
				ALUSrc_o 	  = 1'b1; //SignExtImm
				RegWrite_o    = 1'b0;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
			default : begin
				RegDst_o   	  = 2'b00;
				Jump_o 	   	  = 2'b00;
				Brncheq_o     = 1'b0;
				Brnchne_o	  = 1'b0;
				CachetoReg_o  = 2'b00;
				ALU_control_o = 4'b1111;
				CacheRead_o	  = 1'b0;
				CacheWrite_o  = 1'b0;
				ALUSrc_o 	  = 1'b0;
				RegWrite_o    = 1'b0;
				HLRead_o	  = 1'b0;
				HLWrite_o	  = 1'b0;
				HLSrc_o		  = 1'b0;
			end
		endcase
	end
	
end

endmodule