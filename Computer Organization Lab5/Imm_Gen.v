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

always@(*)
begin
	case (instr_i[6:0])
		7'b0000011://i-type lw
			temp={ {21{instr_i[31]}}	,	instr_i[30:20]	};
		7'b0100011://S-type sw
			temp={ {21{instr_i[31]}}, instr_i[30:25], instr_i[11:7] };
		7'b1100011://sb-type beq bne blt bge
			temp={ {20{instr_i[31]}}	,	instr_i[7]	,	instr_i[30:25]	,	instr_i[11:8] };
		7'b1101111://jal
			temp={ {13{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21]};
		default://r-type
			temp={ {21{instr_i[31]}} ,	instr_i[30:20] };//r-type add sub and xor slt
	endcase
end		
endmodule