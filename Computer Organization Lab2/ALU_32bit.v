module ALU_32bit(
	input			[32-1:0]src1,       //32 bit source 1  (input)
	input			[32-1:0]src2,       //32 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 				less,
	input 	    		[2-1:0] operation,  	    //2 bit operation (input) 
	output           	[32-1:0]result,     	    
	output				cout,
	output				overflow,
	output				sign,
	output			[8-1:0] eq       
);
	wire [4-1:0] 	c,p,g;
	wire [8-1:0]	ov;
	
	CLA4 c0(.G(g),
		.P(p),
		.cin(Cin),
		.cout(c)
	);

	ALU_8bit a0(
		.src1(src1[8-1:0]),       //8 bit source 1  (input)
		.src2(src2[8-1:0]),       //8 bit source 2  (input)
		.Ainvert(Ainvert),    //1 bit A_invert  (input)
		.Binvert(Binvert),    //1 bit B_invert  (input)
		.Cin(Cin),        //1 bit carry in  (input)
		.less(less),
		.operation(operation),  	    //2 bit operation (input) 
		.result(result[8-1:0]),     	    
		.P(p[0]),
		.G(g[0])     
	);
	ALU_8bit a1(
		.src1(src1[16-1:8]),       //8 bit source 1  (input)
		.src2(src2[16-1:8]),       //8 bit source 2  (input)
		.Ainvert(Ainvert),    //1 bit A_invert  (input)
		.Binvert(Binvert),    //1 bit B_invert  (input)
		.Cin(c[0]),        //1 bit carry in  (input)
		.less(1'b0),
		.operation(operation),  	    //2 bit operation (input) 
		.result(result[16-1:8]),     	    
		.P(p[1]),
		.G(g[1])         
	);
	ALU_8bit a2(
		.src1(src1[24-1:16]),       //8 bit source 1  (input)
		.src2(src2[24-1:16]),       //8 bit source 2  (input)
		.Ainvert(Ainvert),    //1 bit A_invert  (input)
		.Binvert(Binvert),    //1 bit B_invert  (input)
		.Cin(c[1]),        //1 bit carry in  (input)
		.less(1'b0),
		.operation(operation),  	    //2 bit operation (input) 
		.result(result[24-1:16]),     	    
		.P(p[2]),
		.G(g[2])        
	);
	ALU_8bit a3(
		.src1(src1[32-1:24]),       //8 bit source 1  (input)
		.src2(src2[32-1:24]),       //8 bit source 2  (input)
		.Ainvert(Ainvert),    //1 bit A_invert  (input)
		.Binvert(Binvert),    //1 bit B_invert  (input)
		.Cin(c[2]),        //1 bit carry in  (input)
		.cout(ov),
		.less(1'b0),
		.operation(operation),  	    //2 bit operation (input) 
		.result(result[32-1:24]),     	    
		.P(p[3]),
		.G(g[3]),
		.eq(eq)       
	);
	assign cout = c[3];
	assign overflow = c[3]^ov[6];
	assign sign = eq[7]^ov[6];
endmodule 