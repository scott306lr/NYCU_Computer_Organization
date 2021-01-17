/***************************************************
Student Name: ¬I®a»ô ¤ý°öºÓ
Student ID: 0716241 0816137
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	input [6:0]		Opcode,
	output	[4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
reg [4-1:0]temp;
assign ALU_Ctrl_o=temp;
always@(*)
begin
	case (ALUOp)//according to chap4-part1.pdf
		2'b10://r-type i-type
			case(instr[2:0])
				3'b000:begin 
					if(Opcode==7'b0010011)
						temp<=4'b0000;//addi 
					else if(instr[3]==1'b0)
						temp<=4'b0000;//add 
					else
						temp<=4'b0111;//sub
				end
				3'b111:temp<=4'b0001;//and andi
				3'b110:temp<=4'b0010;//or  ori
				3'b100:temp<=4'b0011;//xor xori
				3'b010:temp<=4'b0100;//slt slti
				3'b001:temp<=4'b0101;//sll slli
				3'b101:temp<=4'b0110;//sra srli
			endcase
		2'b00://lw sw
			case(instr[2:0])
				3'b010:begin 
					if(instr[3]==0)
						temp<=4'b1000;//lw 
					else
						temp<=4'b1001;//sw
				end
				3'b000:temp<=4'b1010;//jalr
			endcase
		2'b11:
				temp<=4'b1011;//jal
		2'b01://beq bne
			case(instr[2:0])
				3'b000:temp<=4'b1110;//beq
				3'b001:temp<=4'b1111;//bne
				3'b100:temp<=4'b1101;//blt
				3'b101:temp<=4'b1100;//bge
			endcase
		
	endcase
end			

endmodule