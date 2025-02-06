


/*
Inputs: Clock, ResetN, St, N
Outputs: Done, Sqrt
*/

module eightbSqtt(
	output done,
	output Sqrt,
	input clk,
	input rstN,
	input St,
	input N
);

reg [7:0] N;


eightBitSubtractor s0 (
	.D(N)
	.borrowOut()
	.N(N)
	.oddIn()
)


	