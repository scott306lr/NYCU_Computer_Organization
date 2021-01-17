/***************************************************
Student Name: ¤ý°öºÓ ¬I®a»ô
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
//PC
wire [31:0] pc_i;
wire [31:0] pc_o;
//Instr Mem
wire [31:0] instr;
//Register
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
//decorder
wire ALUSrc;
wire Branch;
wire Zero;
wire PCSrc;
wire [1:0] ALUOp;
wire [31:0] ImmGen_o;
wire [31:0] Mux_ALUSrc_o;
wire [31:0] SL1_o;
wire [3:0] ALUctrl_i;
wire [3:0] ALUctrl_o;
wire [31:0] Sum_o;
wire [31:0] PCplus4;


assign ALUctrl_i[3]=instr[30];
assign ALUctrl_i[2:0]=instr[14:12];
assign PCSrc = Branch & Zero;

ProgramCounter PC(
			.clk_i(clk_i),      
			.rst_i(rst_i),     
			.pc_i(pc_i) ,   
			.pc_o(pc_o) 
				);

Instr_Memory IM(
			.addr_i(pc_o),  
			.instr_o(instr)    
	    );
		
Reg_File RF(
			.clk_i(clk_i),      
			.rst_i(rst_i) ,     
			.RSaddr_i(instr[19:15]) ,  
			.RTaddr_i(instr[24:20]) ,  
			.RDaddr_i(instr[11:7]) ,  
			.RDdata_i(ALUresult)  , 
			.RegWrite_i (RegWrite),
			.RSdata_o(RSdata_o) ,  
			.RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        .instr_i(instr), 
		.ALUSrc(ALUSrc),
	    .RegWrite(RegWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp)      
	    );	

Adder Adder1(
        .src1_i(pc_o),     
	    .src2_i(32'b100),     
	    .sum_o(PCplus4)    
	    );
		
Imm_Gen ImmGen(
		.instr_i(instr),
		.Imm_Gen_o(ImmGen_o)
		);
	
Shift_Left_1 SL1(
		.data_i(ImmGen_o),
		.data_o(SL1_o)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(ImmGen_o),
		.select_i(ALUSrc),
		.data_o(Mux_ALUSrc_o)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr(ALUctrl_i),
		.ALUOp(ALUOp),
		.ALU_Ctrl_o(ALUctrl_o)
		);
		
Adder Adder2(
        .src1_i(pc_o),     
	    .src2_i(SL1_o),     
	    .sum_o(Sum_o)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(Mux_ALUSrc_o),
		.ALU_control(ALUctrl_o),
		.zero(Zero),
		.result(ALUresult),
		.cout(),
		.overflow()
		);
	
MUX_2to1 Mux_PCSrc(
		.data0_i(PCplus4),       
		.data1_i(Sum_o),
		.select_i(PCSrc),
		.data_o(pc_i)
		);
		
endmodule
		  


