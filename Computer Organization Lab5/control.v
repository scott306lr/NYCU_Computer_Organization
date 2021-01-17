/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Decoder(
    input [31:0]instr_i, 
	output [1:0]WB,
	output [2:0]M,
	output [2:0]EX
	);
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field;
wire	[10-1:0]	ctrl_o;

assign opcode = instr_i[6:0];
assign funct3 = instr_i[14:12];

// Check Instr. Field
// 0:R-type, 1:I-type, 2:S-type, 3:B-type, 5:J-type	
assign Instr_field = (opcode==7'b0110011)?0:(	//R 0
		     (opcode==7'b0010011)?1:(	//I 1
		     (opcode==7'b1100011)?3:(   //BLT 3
		     (opcode==7'b0000011)?4:(	//LW  1
                     (opcode==7'b0100011)?5:(	//SW  2
		     (opcode==7'b1101111)?6:(	//JAL 5
		     (opcode==7'b1100111)?7:(	//JALR 6
		      1)))))));    						
assign ctrl_o = (Instr_field==0)?10'b0000100010:(		//R-type
		(Instr_field==1)?10'b0010100010:(		//I-type
		(Instr_field==3)?10'b0000000101:(		//branch
		(Instr_field==4)?10'b0011110000:(		//lw
		(Instr_field==5)?10'b0010001000:( 		//SW
		(Instr_field==6)?10'b0100100011:(		//jal
		(Instr_field==7)?10'b1000100000:(		//jalr
		10'b0000000000)))))));

assign WB[1]=ctrl_o[5];
assign WB[0]=ctrl_o[6];
//assign RegWrite = Ctrl_o[5];
//assign MemtoReg = Ctrl_o[6];
assign M[2]=ctrl_o[2];
assign M[1]=ctrl_o[4];
assign M[0]=ctrl_o[3];
//assign Branch = Ctrl_o[2];
//assign MemRead = Ctrl_o[4];
//assign MemWrite = Ctrl_o[3];
assign EX[2:1]=ctrl_o[1:0];
assign EX[0]=ctrl_o[7];
//assign ALUOp = Ctrl_o[1:0];
//assign ALUSrc = Ctrl_o[7];
//assign Jump = Ctrl_o[9:8]; not used

endmodule