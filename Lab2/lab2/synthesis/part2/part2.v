
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module part2(
	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	//////////// SW //////////
	input 		     [7:0]		SW
);
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
wire [7:0] product;

bitmulti multiplier (product[7:0], SW[3:0], SW[7:4]);
bit2Hex b (HEX2[6:0], SW[3:0]);
bit2Hex a (HEX3[6:0], SW[7:4]);
bit2Hex p0 (HEX0[6:0], product[3:0]);
bit2Hex p1 (HEX1[6:0], product[7:4]);
endmodule