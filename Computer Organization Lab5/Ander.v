/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps

module Ander(
    	input branch_i,
	input zero_i,
	output branch_o
	);
    
/* Write your code HERE */
assign branch_o = branch_i&zero_i;

endmodule