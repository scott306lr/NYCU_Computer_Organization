/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps

module Shift_Left_1(
    input  [32-1:0] data_i,
    output [32-1:0] data_o
    );

/* Write your code HERE */
assign data_o=data_i<<1;
endmodule