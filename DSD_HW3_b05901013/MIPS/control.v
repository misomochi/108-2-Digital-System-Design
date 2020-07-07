module control (
	input  	   [5:0] opcode_i,
	input  	   [5:0] funct_i, //r-type
	output reg [1:0] RegDst_o,
	output reg [1:0] Jump_o,
	output reg 		 Branch_o,
	output reg [1:0] MemtoReg_o,
	output reg [3:0] ALU_control_o,
	output reg 		 MemWrite_o,
	output reg 		 ALUSrc_o,
	output reg 		 RegWrite_o
);

always @(*) begin
	case (opcode_i)
		6'h0: begin //r-type
			case (funct_i)
				6'h20: begin //add
					RegDst_o   	  = 2'b01; //$rd
					Jump_o 	   	  = 2'b00;
					Branch_o   	  = 1'b0;
					MemtoReg_o 	  = 2'b00;
					ALU_control_o = 4'b0010; //add
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'b0;
					RegWrite_o    = 1'b1;
				end
				6'h22: begin //sub
					RegDst_o   	  = 2'b01; //$rd
					Jump_o 	   	  = 2'b00;
					Branch_o   	  = 1'b0;
					MemtoReg_o 	  = 2'b00;
					ALU_control_o = 4'b0110; //sub
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'b0;
					RegWrite_o    = 1'b1;
				end
				6'h24: begin //and
					RegDst_o   	  = 2'b01; //$rd
					Jump_o 	   	  = 2'b00;
					Branch_o   	  = 1'b0;
					MemtoReg_o 	  = 2'b00;
					ALU_control_o = 4'b0000; //and
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'b0;
					RegWrite_o    = 1'b1;
				end
				6'h25: begin //or
					RegDst_o   	  = 2'b01; //$rd
					Jump_o 	   	  = 2'b00;
					Branch_o   	  = 1'b0;
					MemtoReg_o 	  = 2'b00;
					ALU_control_o = 4'b0001; //or
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'b0;
					RegWrite_o    = 1'b1;
				end
				6'h2a: begin //slt
					RegDst_o   	  = 2'b01; //$rd
					Jump_o 	   	  = 2'b00;
					Branch_o   	  = 1'b0;
					MemtoReg_o 	  = 2'b00;
					ALU_control_o = 4'b0111; //slt
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'b0;
					RegWrite_o    = 1'b1;
				end
				6'h08: begin //jr
					RegDst_o   	  = 2'bxx;
					Jump_o 	   	  = 2'b10; //PC = $rs
					Branch_o   	  = 1'bx;
					MemtoReg_o 	  = 2'bxx;
					ALU_control_o = 4'b1111;
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'bx;
					RegWrite_o    = 1'b0;
				end
				default: begin
					RegDst_o   	  = 2'b11;
					Jump_o 	   	  = 2'b11;
					Branch_o   	  = 1'b0;
					MemtoReg_o 	  = 2'b11;
					ALU_control_o = 4'b1111;
					MemWrite_o 	  = 1'b0;
					ALUSrc_o 	  = 1'b0;
					RegWrite_o    = 1'b0;
				end
			endcase
		end
		6'h23: begin //lw
			RegDst_o   	  = 2'b00; //$rt
			Jump_o 	   	  = 2'b00;
			Branch_o   	  = 1'b0;
			MemtoReg_o 	  = 2'b01;
			ALU_control_o = 4'b0010; //add
			MemWrite_o 	  = 1'b0;
			ALUSrc_o 	  = 1'b1; //SignExtImm
			RegWrite_o    = 1'b1;
		end
		6'h2b: begin //sw
			RegDst_o   	  = 2'bxx;
			Jump_o 	   	  = 2'b00;
			Branch_o   	  = 1'b0;
			MemtoReg_o 	  = 2'bxx;
			ALU_control_o = 4'b0010; //add
			MemWrite_o 	  = 1'b1;
			ALUSrc_o 	  = 1'b1; //SignExtImm
			RegWrite_o    = 1'b0;
		end
		6'h4: begin //beq
			RegDst_o   	  = 2'bxx;
			Jump_o 	   	  = 2'b00;
			Branch_o   	  = 1'b1;
			MemtoReg_o 	  = 2'bxx;
			ALU_control_o = 4'b0110; //sub
			MemWrite_o 	  = 1'b0;
			ALUSrc_o 	  = 1'b0;
			RegWrite_o    = 1'b0;
		end
		6'h2: begin //j
			RegDst_o   	  = 2'bxx;
			Jump_o 	   	  = 2'b01; //PC = JumpAddr
			Branch_o   	  = 1'bx;
			MemtoReg_o 	  = 2'bxx;
			ALU_control_o = 4'b1111;
			MemWrite_o 	  = 1'b0;
			ALUSrc_o 	  = 1'bx;
			RegWrite_o    = 1'b0;
		end
		6'h3: begin //jal
			RegDst_o   	  = 2'b10; //$ra
			Jump_o 	   	  = 2'b01; //PC = JumpAddr
			Branch_o   	  = 1'bx;
			MemtoReg_o 	  = 2'b10; //PC + 8
			ALU_control_o = 4'b1111;
			MemWrite_o 	  = 1'b0;
			ALUSrc_o 	  = 1'bx;
			RegWrite_o    = 1'b1; //$ra = PC
		end
		default: begin
			RegDst_o   	  = 2'b11;
			Jump_o 	   	  = 2'b11;
			Branch_o   	  = 1'b0;
			MemtoReg_o 	  = 2'b11;
			ALU_control_o = 4'b1111;
			MemWrite_o 	  = 1'b0;
			ALUSrc_o 	  = 1'b0;
			RegWrite_o    = 1'b0;
		end
	endcase
end

endmodule