module ALU_8bit(
	input			[8-1:0] src1,       //8 bit source 1  (input)
	input			[8-1:0] src2,       //8 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 				less,
	input 	    		[2-1:0] operation,  	    //2 bit operation (input) 
	output           	[8-1:0] result,     	    
	output			[8-1:0] cout,      
	output          		P,
	output           		G,
	output			[8-1:0]	eq       
	);

	wire 		[8-1:0] c,p,g;
/* Write your code HERE */
	
	CLA8 c0(	.G(g),
			.P(p),
			.cin(Cin),
			.cout(c),
			.Pout(P),
			.Gout(G)
			);
	ALU_1bit a0(	.src1(src1[0]),
		 	.src2(src2[0]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(Cin),
		 	.less(less),
		 	.operation(operation),
		 	.result(result[0]),
		 	.p(p[0]),
		 	.g(g[0])
			);
	ALU_1bit a1(	.src1(src1[1]),
		 	.src2(src2[1]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[0]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[1]),
		 	.p(p[1]),
		 	.g(g[1])
			);
	ALU_1bit a2(	.src1(src1[2]),
		 	.src2(src2[2]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[1]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[2]),
		 	.p(p[2]),
		 	.g(g[2])
			);
	ALU_1bit a3(	.src1(src1[3]),
		 	.src2(src2[3]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[2]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[3]),
		 	.p(p[3]),
		 	.g(g[3])
			);
	ALU_1bit a4(	.src1(src1[4]),
		 	.src2(src2[4]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[3]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[4]),
		 	.p(p[4]),
		 	.g(g[4])
			);
	ALU_1bit a5(	.src1(src1[5]),
		 	.src2(src2[5]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[4]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[5]),
		 	.p(p[5]),
		 	.g(g[5])
			);
	ALU_1bit a6(	.src1(src1[6]),
		 	.src2(src2[6]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[5]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[6]),
		 	.p(p[6]),
		 	.g(g[6])
			);
	ALU_1bit a7(	.src1(src1[7]),
		 	.src2(src2[7]),
		 	.Ainvert(Ainvert),
		 	.Binvert(Binvert),
		 	.Cin(c[6]),
		 	.less(1'b0),
		 	.operation(operation),
		 	.result(result[7]),
		 	.p(p[7]),
		 	.g(g[7])
			);
	assign cout = c;
	assign eq = p;


endmodule

