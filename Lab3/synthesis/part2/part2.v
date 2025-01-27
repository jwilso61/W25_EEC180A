module part2(
	output	[3:0]	LEDR,
	input 	[7:0]	SW
);
//===REG/WIRE declarations=========================
reg carryIn = 1'b0;
wire overflow;
wire [2:0] lzd4_1Count;
wire [2:0] lzd4_0Count;
wire [2:0] LeadNibOvr;
//===Structural coding=============================
LZD_4 lzd4_1 (lzd4_1Count[2:0], SW[7:4]);
LZD_4 lzd4_0 (lzd4_0Count[2:0], SW[3:0]);

assign LeadNibOvr[2:0] = (lzd4_1Count[2] ==1)
				?(lzd4_0Count[2:0])
				:(3'b000);
part3 #(.N(4)) FA4 (
	.s(LEDR[3:0]), 
	.overflow(overflow), 
	.carryIn(carryIn), 
	.a({1'b0, lzd4_1Count[2:0]}), 
	.b({1'b0, LeadNibOvr[2:0]})
);
endmodule
