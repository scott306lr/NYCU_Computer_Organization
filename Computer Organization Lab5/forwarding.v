/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns / 1ps

module forwarding(
    	input [4:0] ID_EX_RS, 
	input [4:0] ID_EX_RT,
	input [4:0] EX_MEM_RD,
	input [4:0] MEM_WB_RD,
	input EX_MEM_regwrite,
	input MEM_WB_regwrite,
	output reg [1:0] EXmuxA,
	output reg [1:0] EXmuxB,
	//
	
	input [4:0] IF_ID_RS,
	input [4:0] IF_ID_RT,
	output reg IDmuxA,
	output reg IDmuxB
	);

always@(*) begin
	if( EX_MEM_regwrite && (EX_MEM_RD!=0) && (EX_MEM_RD==ID_EX_RS) )
		EXmuxA<=2'b10;
	else if( MEM_WB_regwrite && (MEM_WB_RD!=0) && (EX_MEM_RD!=ID_EX_RS) && (MEM_WB_RD==ID_EX_RS) )
		EXmuxA<=2'b01;
	else
		EXmuxA<=2'b00;
	//
	if( EX_MEM_regwrite && (EX_MEM_RD!=0) && (EX_MEM_RD==ID_EX_RT) )
		EXmuxB<=2'b10;
	else if( MEM_WB_regwrite && (MEM_WB_RD!=0) && (EX_MEM_RD!=ID_EX_RT) && (MEM_WB_RD==ID_EX_RT) )
		EXmuxB<=2'b01;
	else
		EXmuxB<=2'b00;
	//
	if( MEM_WB_regwrite && (MEM_WB_RD!=0) && (MEM_WB_RD==IF_ID_RS) )
		IDmuxA<=1'b1;
	else
		IDmuxA<=1'b0;
	//
	if( MEM_WB_regwrite && (MEM_WB_RD!=0) && (MEM_WB_RD==IF_ID_RT) )
		IDmuxB<=1'b1;
	else
		IDmuxB<=1'b0;

end



endmodule
