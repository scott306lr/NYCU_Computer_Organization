/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */
reg [31:0] temp;
assign Imm_Gen_o=temp;
//°Ñ¦Òhttps://github.com/physical-computation/Sail-RV32I-common/blob/master/verilog/imm_gen.v
always@(*)
begin
	case ({instr_i[6:5], instr_i[3:2]})//opcode 65_32__
		4'b0000://i-type
			temp={ {21{instr_i[31]}}	,	instr_i[30:20]	};
		4'b1100://sb-type beq bne
			temp={	{20{instr_i[31]}}	,	instr_i[7]	,	instr_i[30:25]	,	instr_i[11:8] };
		default://r-type
			temp={ {21{instr_i[31]}} ,	instr_i[30:20] };//r-type add sub and xor slt
	endcase
end				
endmodule
/*
add	r		0100
addi	i		0000
sub	r		0100
and	r		0100
or		r		0100
xor	r		0100
slt	r		0100
slti	i		0000
beq	sb		1100
sll	r		0100
slli	i(?)	0000
sra	r		0100
srli	i(?)	0000
andi	i		0000
ori	i		0000
bne	sb		1100
*/