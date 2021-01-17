/***************************************************
Student Name:	¬I®a»ô ¤ı°öºÓ
Student ID:	0716241 0816137
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     		[32-1:0]	src1,          // 32 bits source 1          (input)
	input	     		[32-1:0]	src2,          // 32 bits source 2          (input)
	input 	      [ 4-1:0] ALU_control,   // 4 bits ALU control input  (input)
	output reg   	[32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);
/* Write your code HERE */
reg [33-1:0]result_k;
reg zero_k;
reg overflow_k;
reg cout_k;
reg [31:0]result_c31;
reg [32:0]result_c32;
reg res_and,res_or,res_add;
integer intger_n;
always@(*)
begin
	case(ALU_control)
		4'b0000://add addi
		begin
			result_k<=src1+src2;
			result_c31<=src1[30:0]+src2[30:0];
			result_c32<=src1+src2;
			zero_k<=0;
			cout_k<=result_k[32];
			overflow_k<=result_c31[31]^result_c32[32];
		end
		4'b0111://sub
		begin
			result_k<=src1-src2;
			result_c31<=src1[30:0]-src2[30:0];
			result_c32<=src1-src2;
			zero_k<=0;
			cout_k<=result_k[32];
			overflow_k<=result_c31[31]^result_c32[32];
		end
		4'b0001://and andi
		begin
			result_k<=src1&src2;
			zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end
		4'b0010://or ori
		begin
			result_k<=src1|src2;
			zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end
		4'b0011://xor
		begin
			result_k<=(src1)^(src2);
			zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end
		4'b0100://slt slti
		begin
			result_c31<=src1-src2;
			if(result_c31[31]==1)
				result_k<=1;
			else
				result_k<=0;
			zero_k<=0;
			cout_k<=0;
			overflow_k<=result_c31[31]^result_c32[32];
		end
		4'b0101://sll slli
		begin
			intger_n<=src2;
			result_k<=(src1)<<intger_n;
			zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end
		4'b0110://sra
		begin
			intger_n<=src2;
			result_k<=(src1)>>>src2;
			zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end	
		4'b1110://srli
		begin
			intger_n<=src2;
			result_k<=(src1)>>src2;
			zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end	
		4'b1110://beq
		begin
			result_k<=src1-src2;
			if(result_k==0)
				zero_k<=1;
			else
				zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end
		4'b1111://bne
		begin
			result_k<=src1-src2;
			if(result_k!=0)
				zero_k<=1;
			else
				zero_k<=0;
			cout_k<=0;
			overflow_k<=0;
		end
	endcase
	if(rst_n==0)
	begin
		result<= 0;
		zero<= 0;
		cout<= 0;
		overflow<= 0;
	end
	else
	begin
		result<=result_k;
		zero<=zero_k;
		cout<=cout_k;
		overflow<=overflow_k;
	end
end
endmodule
