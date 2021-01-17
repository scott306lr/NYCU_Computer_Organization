/***************************************************
Student Name: 王培碩 施家齊
Student ID: 0816137 0716241
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] ALUresult;
//wire
wire [31:0] DM_o;
//what
wire [31:0] pc_i;
wire [31:0] RDdata_i;
wire [31:0] adder1_o;
wire [31:0] adder2_o;
wire [31:0] Imm_Gen_o;
wire [31:0] SL_o;
wire [31:0] data_o;
wire [3:0]  ALU_Ctrl_o;
wire zero;
wire and_o;
wire [31:0] Mux_PCSrc_o;
wire [31:0] Mux_MemtoReg_o;
//decoder
wire ALUSrc;
wire MemtoReg;
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire [1:0]ALUOp;
wire [1:0]Jump;
assign and_o=Branch&zero;

ProgramCounter PC(
		//i
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,
		//o
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
		//i
       .addr_i(pc_o),
		//o
	    .instr_o(instr)    
	    );		

Reg_File RF(
      //i
	.clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(RDdata_i)  , 
        .RegWrite_i(RegWrite),
		//o
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );		

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUresult),
		.data_i(RTdata_o),
		.MemRead_i(MemRead),
		.MemWrite_i(MemWrite),
		//o
		.data_o(DM_o)
		);
		
Decoder Decoder(
      .instr_i(instr), 
		//o
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
	   .RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
	   .Branch(Branch),
		.ALUOp(ALUOp),
		.Jump(Jump)
	    );
		
Adder Adder1(
       .src1_i(pc_o),     
	    .src2_i(32'b100),     
	    .sum_o(adder1_o)    
	    );
		
Imm_Gen ImmGen(
		.instr_i(instr),
		.Imm_Gen_o(Imm_Gen_o)
		);
	
Shift_Left_1 SL1(
		.data_i(Imm_Gen_o),
		.data_o(SL_o)
		);
	
MUX_2to1 Mux_ALUSrc(
		.data0_i(RTdata_o),       
		.data1_i(Imm_Gen_o),
		.select_i(ALUSrc),
		.data_o(data_o)
		);
			
ALU_Ctrl ALU_Ctrl(
		.instr({ {instr[30]},	instr[14:12]	}),
		.ALUOp(ALUOp),
		.Opcode(instr[6:0]),
		.ALU_Ctrl_o(ALU_Ctrl_o)
		);
		
Adder Adder2(
       .src1_i(pc_o),     
	    .src2_i(SL_o),     
	    .sum_o(adder2_o)    
	    );
		
alu alu(
		.rst_n(rst_i),
		.src1(RSdata_o),
		.src2(data_o),
		.ALU_control(ALU_Ctrl_o),
		.zero(zero),
		.result(ALUresult),
		.cout(),
		.overflow()
		);
/*Ander ander(
		 .src1_i(Branch),     
	    .src2_i(zero),     
	    .sum_o(and_o)    
		);*/
MUX_2to1 Mux_PCSrc(
		.data0_i(adder1_o),
		.data1_i(adder2_o),
		.select_i(and_o),
		.data_o(Mux_PCSrc_o)
		);
MUX_3to1 Mux_PCSrc3(
		.data0_i(Mux_PCSrc_o),
		.data1_i(SL_o),
		.data2_i(RSdata_o),
		.select_i(Jump),
		.data_o(pc_i)
		);
MUX_3to1 Mux_WriteDataSrc(
		.data0_i(Mux_MemtoReg_o),
		.data1_i(adder1_o),
		.data2_i(0),
		.select_i(Jump),
		.data_o(RDdata_i)
		);
MUX_2to1 Mux_MemtoReg(
		.data0_i(ALUresult),       
		.data1_i(DM_o),
		.select_i(MemtoReg),
		.data_o(Mux_MemtoReg_o)
		);
		
endmodule
		  


