/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Pipeline_CPU(
	input clk_i,
	input rst_i
	);
//IF stage
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] pcPlus4;
wire [31:0] instr;
//IF/ID
wire [31:0] pc_r1;
wire [31:0] instr_r1;
//ID stage
wire [1:0] WB_o;
wire [2:0] M_o;
wire [2:0] EX_o;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] Imm_Gen_o;
//ID/Ex
wire [1:0] WB_r1;
wire [2:0] M_r1;
wire [2:0] EX_r1;
wire [31:0] pc_r2;
wire [31:0] RSdata_r1;
wire [31:0] RTdata_r1;
wire [31:0] Imm_Geno_r1;
wire [3:0] ALU_ctrl_r1;
wire [4:0] RDaddr_r1;
wire [6:0] opcode_r1;
//Ex stage
wire [31:0] SL1_o;
wire [31:0] mALUsrc_o;
wire [3:0] ALU_Ctrl_o;
wire [31:0] adder2_o;
wire zero;
wire [31:0] ALU_o;


//Ex/MEM
wire [1:0]  WB_r2;
wire [2:0]  M_r2;
wire [31:0] adder2_r1;
wire zero_r1;
wire [31:0] ALU_r1;
wire [31:0] RTdata_r2;
wire [4:0]  RDaddr_r2;
//Mem stage
wire branch_o;
wire [31:0] DM_o;


//Mem/WB
wire [1:0]  WB_r3;
wire [31:0] DM_r1;
wire [31:0] ALU_r2;
wire [4:0] RDaddr_r3;
//WB 
wire [31:0] RDdata_i;
//pipeline
wire [4:0] IDEXRS;
wire [4:0] IDEXRT;
wire [4:0] IDEXRD;
wire [4:0] EXMEMRD;
wire [4:0] MEMWBRD;
wire [1:0] EXmuxA;
wire [1:0] EXmuxB;
wire [31:0] EXmuxA_o;
wire [31:0] EXmuxB_o;
wire [31:0] IDmuxA_o;
wire [31:0] IDmuxB_o;
wire IDmuxA;
wire IDmuxB;


//IF
MUX_2to1 Mux_PCSrc(
	.data0_i(pcPlus4),       
	.data1_i(adder2_r1),
	.select_i(branch_o),
	.data_o(pc_i)
	);
ProgramCounter PC(
    	.clk_i(clk_i),      
	.rst_i(rst_i),     
	.pc_i(pc_i),   
	.pc_o(pc_o) 
	);
Adder PCAdder(
    	.src1_i(pc_o),     
	.src2_i(32'h4),     
	.sum_o(pcPlus4)    
	);
Instr_Memory IM(
    	.addr_i(pc_o),  
	.instr_o(instr)    
	);		
reg_IFID IFID(
	.clk_i(clk_i),      
	.rst_i(rst_i), 
	.pco_i(pc_o),
	.instro_i(instr),
	//
	.pco_o(pc_r1),
	.instro_o(instr_r1)
	);
	
//ID
Reg_File RF(
        .clk_i(clk_i),      
	.rst_i(rst_i),     
        .RSaddr_i(instr_r1[19:15]),  
        .RTaddr_i(instr_r1[24:20]),  
        .RDaddr_i(RDaddr_r3),  
        .RDdata_i(RDdata_i), 
        .RegWrite_i(WB_r3[1]),
        .RSdata_o(RSdata_o),  
        .RTdata_o(RTdata_o)   
        );		
Decoder Control(
    .instr_i(instr_r1), 
	.WB(WB_o),
	.M(M_o),
	.EX(EX_o)
	);	
Imm_Gen ImmGen(
	.instr_i(instr_r1),
	.Imm_Gen_o(Imm_Gen_o)
	);
MUX_2to1 IDforwardA(
	.data0_i(RSdata_o),       
	.data1_i(RDdata_i),
	.select_i(IDmuxA),
	.data_o(IDmuxA_o)
);
MUX_2to1 IDforwardB(
	.data0_i(RTdata_o),       
	.data1_i(RDdata_i),
	.select_i(IDmuxB),
	.data_o(IDmuxB_o)
);
reg_IDEX IDEX(
	.clk_i(clk_i),      
	.rst_i(rst_i),  
	.WB_i(WB_o),
	.M_i(M_o),
	.EX_i(EX_o),
	.pco_i(pc_r1),
	.RS_i(IDmuxA_o),
	.RT_i(IDmuxB_o),
	.Imm_Geno_i(Imm_Gen_o),
	.ALU_ctrl_i( { instr_r1[30],instr_r1[14:12] } ),
	.RDaddr_i(instr_r1[11:7]),
	.opcode_i(instr_r1[6:0]),
	//
	.WB_o(WB_r1),
	.M_o(M_r1),
	.EX_o(EX_r1),
	.pco_o(pc_r2),
	.RS_o(RSdata_r1),
	.RT_o(RTdata_r1),
	.Imm_Geno_o(Imm_Geno_r1),
	.ALU_ctrl_o(ALU_ctrl_r1),
	.RDaddr_o(RDaddr_r1),
	.opcode_o(opcode_r1),
	//
	.IFIDRS(instr_r1[19:15]),
	.IFIDRT(instr_r1[24:20]),
	.IFIDRD(instr_r1[11:7]),
	.IDEXRS(IDEXRS),
	.IDEXRT(IDEXRT),
	.IDEXRD(IDEXRD)
	);
//EX
Shift_Left_1 SL1(
	.data_i(Imm_Geno_r1),
	.data_o(SL1_o)
	);
Adder Adder2(
    .src1_i(pc_r2),     
	.src2_i(SL1_o),     
	.sum_o(adder2_o)    
	);
MUX_2to1 Mux_ALUSrc(
	.data0_i(RTdata_r1),       
	.data1_i(Imm_Geno_r1),
	.select_i(EX_r1[0]),
	.data_o(mALUsrc_o)
	);			
ALU_Ctrl ALU_Ctrl(
	.instr(ALU_ctrl_r1),
	.ALUOp(EX_r1[2:1]),
	.Opcode(opcode_r1),
	.ALU_Ctrl_o(ALU_Ctrl_o)
	);	
MUX_3to1 EXforwardA(
	.data0_i(RSdata_r1),    
	.data1_i(RDdata_i),
	.data2_i(ALU_r1),
	.select_i(EXmuxA),
	.data_o(EXmuxA_o)
);
MUX_3to1 EXforwardB(
	.data0_i(mALUsrc_o),       
	.data1_i(RDdata_i),
	.data2_i(ALU_r1),
	.select_i(EXmuxB),
	.data_o(EXmuxB_o)
);
alu alu(
	.rst_n(rst_i),
	.src1(EXmuxA_o),
	.src2(EXmuxB_o),
	.ALU_control(ALU_Ctrl_o),
	.zero(zero),
	.result(ALU_o),
	.cout(),
	.overflow()
	);
reg_EXMEM EXMEM(
	.clk_i(clk_i),      
	.rst_i(rst_i), 
	.WB_i(WB_r1),
	.M_i(M_r1),
	.sum_i(adder2_o),
	.zero_i(zero),
	.ALUresult_i(ALU_o),
	.RT_i(RTdata_r1),
	.RDaddr_i(RDaddr_r1),
	//
	.WB_o(WB_r2),
	.M_o(M_r2),
	.sum_o(adder2_r1),
	.zero_o(zero_r1),
	.ALUresult_o(ALU_r1),
	.RT_o(RTdata_r2),
	.RDaddr_o(RDaddr_r2),
	//
	.IDEXRD(IDEXRD),
	.EXMEMRD(EXMEMRD)
	);
//MEM
Ander Ander(
	.branch_i(M_r2[2]),
	.zero_i(zero_r1),
	.branch_o(branch_o)
	);
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALU_r1),
	.data_i(RTdata_r2),
	.MemRead_i(M_r2[1]),
	.MemWrite_i(M_r2[0]),
	.data_o(DM_o)
	);
reg_MEMWB MEMWB(
	.clk_i(clk_i),      
	.rst_i(rst_i), 
	.WB_i(WB_r2),
	.datao_i(DM_o),
	.ALUresult_i(ALU_r1),
	.RDaddr_i(RDaddr_r2),
	//
	.WB_o(WB_r3),
	.datao_o(DM_r1),
	.ALUresult_o(ALU_r2),
	.RDaddr_o(RDaddr_r3),
	//
	.EXMEMRD(EXMEMRD),
	.MEMWBRD(MEMWBRD)
	);
//WB
MUX_2to1 Mux_MemtoReg(
	.data0_i(ALU_r2),       
	.data1_i(DM_r1),
	.select_i(WB_r3[0]),
	.data_o(RDdata_i)
	);
//forwarding
forwarding forwardunit(
    	.ID_EX_RS(IDEXRS), 
	.ID_EX_RT(IDEXRT),
	.EX_MEM_RD(EXMEMRD),
	.MEM_WB_RD(MEMWBRD),
	.EX_MEM_regwrite(WB_r2[1]),
	.MEM_WB_regwrite(WB_r3[1]),
	.EXmuxA(EXmuxA),
	.EXmuxB(EXmuxB),
	//
	.IF_ID_RS(instr_r1[19:15]),
	.IF_ID_RT(instr_r1[24:20]),
	.IDmuxA(IDmuxA),
	.IDmuxB(IDmuxB)
	);

endmodule
		  


