module L5part2(
	output wire 	[0:0] 		LEDR,
	output		    [7:0]		HEX0,
	output		    [7:0]		HEX2,
	output		    [7:0]		HEX3,
	input 		    [1:0]		KEY,
	input				 [0:0]		SW,
	input wire	MAX10_CLK1_50
);

wire Clock = MAX10_CLK1_50;
wire stPulse;
wire [3:0] Sqrt;
wire [7:0] N;
reg tick;
wire tp;
reg St;
wire done;
reg dtick;

assign LEDR[0] = done;


edge2pulse swTogPulse (
	.out_pulse(stPulse),
	.clk(Clock),
   .rstN(KEY[0]),
	.in(SW[0])	
);

edge2pulse tickerButton (
	.out_pulse(tp),
	.clk(Clock),
   .rstN(KEY[0]),
	.in(!KEY[1])	
);

memBlock m1 (
	.N(N),
	.clk(Clock),
	.rstN(KEY[0]),
	.St(dtick)
);

eightBSqrt eightBSqrt0 (
	.done(done),
	.sqrt(Sqrt),
	.clk(tp),
	.rstN(KEY[0]),
	.St(SW[0]),
	.N(N)
);

always @ (posedge Clock) begin
	if (done) begin
		dtick <= tp;
	end else begin
		dtick <= 1'b0;
	end
end

bit2Hex N74Display (HEX3[7:0], N[7:4]);
bit2Hex N30Display (HEX2[7:0], N[3:0]);
bit2Hex sqrtDisplay (HEX0[7:0], Sqrt[3:0]);

endmodule
