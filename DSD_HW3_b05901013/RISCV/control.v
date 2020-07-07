module control (
	input 	   [6:0] opcode_i,
	input 	   [2:0] funct3_i,
	input 			 funct7_i, //funct7[5]
	output reg 		 Jalr_o,
	output reg 		 Jal_o,
	output reg 		 Branch_o,
	output reg 		 MemRead_o,
	output reg 		 MemtoReg_o,
	output reg [3:0] ALUCtrl_o,
	output reg 		 MemWrite_o,
	output reg 		 ALUSrc_o,
	output reg 		 RegWrite_o
);

always @(*) begin
	case (opcode_i)
		7'b0110011: begin //r-type
			case (funct3_i)
				3'b000: begin //arithmetic
					case (funct7_i)
						1'b0: begin //add
							Jalr_o 	   = 1'b0;
							Jal_o 	   = 1'b0;
							Branch_o   = 1'b0;
							MemRead_o  = 1'b0;
							MemtoReg_o = 1'b0;
							ALUCtrl_o  = 4'b0010;
							MemWrite_o = 1'b0;
							ALUSrc_o   = 1'b0;
							RegWrite_o = 1'b1;
						end
						1'b1: begin //sub
							Jalr_o 	   = 1'b0;
							Jal_o 	   = 1'b0;
							Branch_o   = 1'b0;
							MemRead_o  = 1'b0;
							MemtoReg_o = 1'b0;
							ALUCtrl_o  = 4'b0110;
							MemWrite_o = 1'b0;
							ALUSrc_o   = 1'b0;
							RegWrite_o = 1'b1;
						end
						default: begin
							Jalr_o 	   = 1'b0;
							Jal_o 	   = 1'b0;
							Branch_o   = 1'b0;
							MemRead_o  = 1'b0;
							MemtoReg_o = 1'b0;
							ALUCtrl_o  = 4'b1111;
							MemWrite_o = 1'b0;
							ALUSrc_o   = 1'b0;
							RegWrite_o = 1'b0;
						end
					endcase
				end
				3'b111: begin //and
					Jalr_o 	   = 1'b0;
					Jal_o 	   = 1'b0;
					Branch_o   = 1'b0;
					MemRead_o  = 1'b0;
					MemtoReg_o = 1'b0;
					ALUCtrl_o  = 4'b0000;
					MemWrite_o = 1'b0;
					ALUSrc_o   = 1'b0;
					RegWrite_o = 1'b1;
				end
				3'b110: begin //or
					Jalr_o 	   = 1'b0;
					Jal_o 	   = 1'b0;
					Branch_o   = 1'b0;
					MemRead_o  = 1'b0;
					MemtoReg_o = 1'b0;
					ALUCtrl_o  = 4'b0001;
					MemWrite_o = 1'b0;
					ALUSrc_o   = 1'b0;
					RegWrite_o = 1'b1;
				end
				3'b010: begin //slt
					Jalr_o 	   = 1'b0;
					Jal_o 	   = 1'b0;
					Branch_o   = 1'b0;
					MemRead_o  = 1'b0;
					MemtoReg_o = 1'b0;
					ALUCtrl_o  = 4'b1000;
					MemWrite_o = 1'b0;
					ALUSrc_o   = 1'b0;
					RegWrite_o = 1'b1;
				end
				default: begin
					Jalr_o 	   = 1'b0;
					Jal_o 	   = 1'b0;
					Branch_o   = 1'b0;
					MemRead_o  = 1'b0;
					MemtoReg_o = 1'b0;
					ALUCtrl_o  = 4'b1111;
					MemWrite_o = 1'b0;
					ALUSrc_o   = 1'b0;
					RegWrite_o = 1'b0;
				end
			endcase
		end
		7'b0000011: begin //lw
			Jalr_o 	   = 1'b0;
			Jal_o 	   = 1'b0;
			Branch_o   = 1'b0;
			MemRead_o  = 1'b1;
			MemtoReg_o = 1'b1;
			ALUCtrl_o  = 4'b0010;
			MemWrite_o = 1'b0;
			ALUSrc_o   = 1'b1; //rs1+imm
			RegWrite_o = 1'b1;
		end
		7'b0100011: begin //sw
			Jalr_o 	   = 1'b0;
			Jal_o 	   = 1'b0;
			Branch_o   = 1'b0;
			MemRead_o  = 1'b0;
			MemtoReg_o = 1'b0;
			ALUCtrl_o  = 4'b0010;
			MemWrite_o = 1'b1;
			ALUSrc_o   = 1'b1; //rs1+imm
			RegWrite_o = 1'b0;
		end
		7'b1100011: begin //beq
			Jalr_o 	   = 1'b0;
			Jal_o 	   = 1'b0;
			Branch_o   = 1'b1; //PC+=imm
			MemRead_o  = 1'b0;
			MemtoReg_o = 1'b0;
			ALUCtrl_o  = 4'b0110;
			MemWrite_o = 1'b0;
			ALUSrc_o   = 1'b0;
			RegWrite_o = 1'b0;
		end
		7'b1101111: begin //jal
			Jalr_o 	   = 1'b0;
			Jal_o 	   = 1'b1; //PC+=imm
			Branch_o   = 1'b0;
			MemRead_o  = 1'b0;
			MemtoReg_o = 1'b0;
			ALUCtrl_o  = 4'b1111;
			MemWrite_o = 1'b0;
			ALUSrc_o   = 1'b0;
			RegWrite_o = 1'b1; //$rd = PC + 4
		end
		7'b1100111: begin //jalr
			Jalr_o 	   = 1'b1; //PC=rs1+imm
			Jal_o 	   = 1'b0;
			Branch_o   = 1'b0;
			MemRead_o  = 1'b0;
			MemtoReg_o = 1'b0;
			ALUCtrl_o  = 4'b1111;
			MemWrite_o = 1'b0;
			ALUSrc_o   = 1'b0;
			RegWrite_o = 1'b1; //$rd = PC + 4
		end
		default: begin
			Jalr_o 	   = 1'b0;
			Jal_o 	   = 1'b0;
			Branch_o   = 1'b0;
			MemRead_o  = 1'b0;
			MemtoReg_o = 1'b0;
			ALUCtrl_o  = 4'b1111;
			MemWrite_o = 1'b0;
			ALUSrc_o   = 1'b0;
			RegWrite_o = 1'b0;
		end
	endcase
end

endmodule