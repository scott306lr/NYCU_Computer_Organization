/***************************************************
Student Name: ¬I®a»ô
Student ID: 0716241
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 			Cin,        //1 bit carry in  (input)
	input				set,			//1 bit for slt   (input)	
	input 			Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)

	input  [2-1:0] operation,  //2 bit operation (input)
	output reg     result,     //1 bit result    (output)
	output reg     cout,       //1 bit carry out (output)
	output reg		less			//1 bit for slt	(output)
	);

/* Write your code HERE */

endmodule
