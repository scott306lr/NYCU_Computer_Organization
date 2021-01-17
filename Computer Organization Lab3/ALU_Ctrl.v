/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	output	[4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
reg [4-1:0] temp;
assign ALU_Ctrl_o=temp;
always@(*)
begin
	case (ALUOp)//according to chap4-part1.pdf
		2'b10://r-type
			case(instr[2:0])
				3'b000:
				begin 
					if(instr[3]==0)
						temp=4'b0000;//add addi 
					else
						temp=4'b0111;//sub
				end
				3'b111:temp=4'b0001;//and andi
				3'b110:temp=4'b0010;//or  ori
				3'b100:temp=4'b0011;//xor
				3'b010:temp=4'b0100;//slt slti
				3'b001:temp=4'b0101;//sll slli
				3'b101://sra srli
				begin 
					if(instr[3]==0)
						temp=4'b0110;//sra 
					else
						temp=4'b1110;//srli
				end
			endcase
		2'b00://lw s-type
			case(instr[2:0])
				3'b010:temp=4'b0100;//slti
			endcase
		2'b01://sb-type beq bne
			case(instr[2:0])
				3'b000:temp=4'b1110;//beq
				3'b001:temp=4'b1111;//bne
			endcase
	endcase
end			

endmodule
/*							ins		alu_op
ins			6532	30 141312	
add	r		0100	0	000		
addi	i		0000	-	000		
sub	r		0100	1	000		
and	r		0100	0	010		
or		r		0100	0	110		
xor	r		0100	0	100		
slt	r		0100	0	010		
slti	i		0000	-	010		
beq	sb		1100	-	000		
sll	r		0100	0	001		
slli	i		0000	0	001		
sra	r		0100	1	101		
srli	i		0000	0	101		
andi	i		0000	-	111		
ori	i		0000	-	110		
bne	sb		1100	-	001		
*/