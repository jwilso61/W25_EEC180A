module L5part2(
	output wire 	  [0:0] 		LEDR,
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	input 		     [1:0]		KEY,
	input wire	MAX10_CLK1_50
);
wire Clock = MAX10_CLK1_50;
wire StEdge;
wire St;
wire [3:0] Sqrt;
wire [7:0] N;

buttonEdgeDet buttonED (
	.button_edge(StEdge),
	.clk(Clock),
   .rstN(KEY[0]),
	.button(KEY[1])	
);

memBlock m1 (
	.N(N),
	.clk(Clock),
	.rstN(KEY[0]),
	.St(StEdge)
);

eightBSqrt eightBSqrt0 (
	.done(LEDR[0]),
	.sqrt(Sqrt),
	.clk(Clock),
	.rstN(KEY[0]),
	.St(StEdge),
	.N(N)
);

bit2Hex N74Display (HEX3[7:0], N[7:4]);
bit2Hex N30Display (HEX2[7:0], N[3:0]);
bit2Hex sqrtDisplay (HEX0[7:0], Sqrt[3:0]);

endmodule
