module L5part2(
	output wire 	[0:0] 		LEDR,
	output		    [7:0]		HEX0,
	output		    [7:0]		HEX2,
	output		    [7:0]		HEX3,
	input 		    [1:0]		KEY,
	input			[0]			SW,
	input wire	MAX10_CLK1_50
);

wire Clock = MAX10_CLK1_50;
wire stPulse;
wire tick = KEY[1];
wire [3:0] Sqrt;
wire [7:0] N;

swToggleDet swTogDet (
	.tog_pulse(stPulse),
	.clk(Clock),
   .rstN(KEY[0]),
	.sw(SW[0])	
);

memBlock m1 (
	.N(N),
	.clk(Clock),
	.rstN(KEY[0]),
	.St(tick)
);

eightBSqrt eightBSqrt0 (
	.done(LEDR[0]),
	.sqrt(Sqrt),
	.clk(tick),
	.rstN(KEY[0]),
	.St(stPulse),
	.N(N)
);

bit2Hex N74Display (HEX3[7:0], N[7:4]);
bit2Hex N30Display (HEX2[7:0], N[3:0]);
bit2Hex sqrtDisplay (HEX0[7:0], Sqrt[3:0]);

endmodule
