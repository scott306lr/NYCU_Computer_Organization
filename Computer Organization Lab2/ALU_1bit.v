/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 				less,
	input 	    [2-1:0] operation,  	    //2 bit operation (input) 
	output reg          result,     	    //1 bit result    (output)
	output           p,
	output           g       
	);
	wire 		A,B,tp;
/* Write your code HERE */
	assign A = Ainvert ^ src1;
	assign B = Binvert ^ src2;
	assign AND = A & B;
	assign OR = A | B;
	assign tp = A ^ B;
	assign ADD = tp ^ Cin;

	assign p = tp;
	assign g = AND;

	always@(*) begin // 
  		case(operation)                 
   			2'b00: result = AND;   //AND.NOR
  			2'b01: result = OR;    //OR.NAND     
  			2'b10: result = ADD;   //Add.Sub(Cin=1)  
  			2'b11: result = less;  //SLT  
		endcase
		
	end
	
	endmodule
