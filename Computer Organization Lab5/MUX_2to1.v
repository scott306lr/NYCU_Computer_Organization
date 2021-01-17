/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input  [32-1:0] data0_i,       
	input  [32-1:0] data1_i,
	input       	select_i,
	output [32-1:0] data_o
               );
			   
/* Write your code HERE */
reg [32-1:0]temp;
assign data_o=temp;
always@(*)
begin
	if(select_i==0)
		temp<=data0_i;
	else
		temp<=data1_i;
end
endmodule      
          