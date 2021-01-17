/***************************************************
Student Name:
Student ID:
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

	wire [32-1:0] res;
	wire over;
	wire C;
	wire sign;
	wire lt;
	wire [8-1:0] eq;
	wire adding;
/* Write your code HERE */

	ALU_32bit a0(
	.src1(src1),       
	.src2(src2),      
	.Ainvert(ALU_control[3]),    
	.Binvert(ALU_control[2]),    
	.Cin(ALU_control[2]),        
	.less(lt),
	.operation(ALU_control[2-1:0]),  	   
	.result(res), 
	.cout(C),    	    
	.overflow(over),
	.sign(sign),
	.eq(eq)    
);
	assign adding = ALU_control[1] & ~ALU_control[0];
	assign lt = eq[7] ? sign : 1'b0 ;
	
	always @ (*) begin
		if (rst_n) begin
			result <= res;
			zero <= ~|res;
			overflow <= over & adding;
			cout <= C & adding;
		end
	end 
endmodule
