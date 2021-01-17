/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps

module reg_IFID(
	input clk_i,
	input rst_i,
	input [31:0] pco_i,
	input [31:0] instro_i,
	output reg [31:0] pco_o,
	output reg [31:0] instro_o
	);
	
	reg [31:0] pco;
	reg [31:0] instro;
	always@(posedge clk_i) begin
		if(rst_i==0)
		begin
			pco_o <= 0;
			instro_o <= 0;			
		end
		else
		begin
			pco_o <= pco_i;
			instro_o <= instro_i;
		end
	end
endmodule


module reg_IDEX(
	input clk_i,
	input rst_i,
	input [1:0] WB_i,
	input [2:0] M_i,
	input [2:0] EX_i,
	input [31:0] pco_i,
	input [31:0] RS_i,
	input [31:0] RT_i,
	input [31:0] Imm_Geno_i,
	input [3:0] ALU_ctrl_i,
	input [4:0] RDaddr_i,
	input [6:0] opcode_i,
	//
	output reg [1:0] WB_o,
	output reg [2:0] M_o,
	output reg [2:0] EX_o,
	output reg [31:0] pco_o,
	output reg [31:0] RS_o,
	output reg [31:0] RT_o,
	output reg [31:0] Imm_Geno_o,
	output reg [3:0] ALU_ctrl_o,
	output reg [4:0] RDaddr_o,
	output reg [6:0] opcode_o,
	//
	input [4:0]IFIDRS,
	input [4:0]IFIDRT,
	input [4:0]IFIDRD,
	output reg [4:0]IDEXRS,
	output reg [4:0]IDEXRT,
	output reg [4:0]IDEXRD
	);
	always@(posedge clk_i) begin
		if(rst_i==0)
		begin
			WB_o <= 0;
			M_o <= 0;
			EX_o <= 0;
			pco_o <= 0;
			RS_o <= 0;
			RT_o <= 0;
			Imm_Geno_o <= 0;
			ALU_ctrl_o <= 0;
			RDaddr_o <= 0;	
			opcode_o <= 0;
			IDEXRS <= 0;
			IDEXRT <= 0;
			IDEXRD <= 0;		
		end
		else
		begin
			WB_o <= WB_i;
			M_o <= M_i;
			EX_o <= EX_i;
			pco_o <= pco_i;
			RS_o <= RS_i;
			RT_o <= RT_i;
			Imm_Geno_o <= Imm_Geno_i;
			ALU_ctrl_o <= ALU_ctrl_i;
			RDaddr_o <= RDaddr_i;
			opcode_o <= opcode_i;
			IDEXRS <= IFIDRS;
			IDEXRT <= IFIDRT;
			IDEXRD <= IFIDRD;
		end
	end
endmodule

module reg_EXMEM(
	input clk_i,
	input rst_i,
	input [1:0] WB_i,
	input [2:0] M_i,
	input [31:0] sum_i,
	input zero_i,
	input [31:0] ALUresult_i,
	input [31:0] RT_i,
	input [4:0] RDaddr_i,
	//
	output reg [1:0] WB_o,
	output reg [2:0] M_o,
	output reg [31:0] sum_o,
	output reg zero_o,
	output reg [31:0] ALUresult_o,
	output reg [31:0] RT_o,
	output reg [4:0] RDaddr_o,
	//
	input  [4:0]IDEXRD,
	output reg [4:0]EXMEMRD
    	);
	always@(posedge clk_i) begin
		if(rst_i==0)
		begin
			WB_o <= 0;
			M_o  <= 0;
			sum_o <= 0;
			zero_o <= 0;
			ALUresult_o <= 0;
			RT_o <= 0;
			RDaddr_o <= 0;
			EXMEMRD <=0;
		end
		else
		begin
			WB_o <= WB_i;
			M_o <= M_i;
			sum_o <= sum_i;
			zero_o <= zero_i;
			ALUresult_o <= ALUresult_i;
			RT_o <= RT_i;
			RDaddr_o <= RDaddr_i;
			EXMEMRD<=IDEXRD;
		end
	end
	
endmodule

module reg_MEMWB(
	input clk_i,
	input rst_i,
	input [1:0] WB_i,
	input [31:0] datao_i,
	input [31:0] ALUresult_i,
	input [4:0] RDaddr_i,
	//
	output reg [1:0] WB_o,
	output reg [31:0] datao_o,
	output reg [31:0] ALUresult_o,
	output reg [4:0] RDaddr_o,
	//
	input  [4:0]EXMEMRD,
	output reg [4:0]MEMWBRD
    	);
	always@(posedge clk_i) begin
		if(rst_i==0)
		begin
			WB_o <= 0;
			datao_o <= 0;
			ALUresult_o <= 0;
			RDaddr_o <= 0;
			MEMWBRD<=0;
		end
		else
		begin
			WB_o <= WB_i;
			datao_o <= datao_i;
			ALUresult_o <= ALUresult_i;
			RDaddr_o <= RDaddr_i;
			MEMWBRD <= EXMEMRD;
		end
	end

endmodule