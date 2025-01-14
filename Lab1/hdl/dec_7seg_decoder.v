module dec_7seg_decoder(

	input [3:0]
		SW,
	output[7:0]
		HEX0,
		HEX1
);

	assign HEX0[0] = (~SW[3])&(~SW[2])&(~SW[1])& SW[0] | (~SW[3])&SW[2]&(~SW[1])&(~SW[0]) | SW[3]&SW[2]&SW[1]&(~SW[0]) | SW[3]&(~SW[2])&SW[1]&SW[0];
	assign HEX0[1] = (~SW[3]) & (~SW[1]) & SW[0] | (~SW[3]) & SW[2] & SW[1] & (~SW[0]) | SW[3] & (SW[1]) & (SW[0]);
	assign HEX0[2] = (~SW[3]) & (~SW[2]) & (~SW[1]) &  SW[0] | (~SW[3]) & (~SW[2]) & SW[1] & (~SW[0]) | (~SW[0]) & (~SW[1]) & SW[2] & (SW[3]) | SW[3] & (~SW[2]) & SW[1] & SW[0];
	assign HEX0[3] = (~SW[3]) & (SW[2]) & (~SW[1]) &  (~SW[0]) | (~SW[3]) & (~SW[2]) & (~SW[1]) & (SW[0]) | (~SW[3]) & (SW[1]) & SW[2] & (SW[0]) | SW[3] & (SW[2]) & SW[1] & (~SW[0]) | SW[3] & (~SW[2]) & SW[0]; 
	assign HEX0[4] = (~SW[3]) & SW[2] & (~SW[1]) | (~SW[3]) & SW[1] & SW[0] | SW[3] & (~SW[1]) & SW[0] | SW[3] & SW[2] & SW[1] | SW[2] & SW[0];
	assign HEX0[5] = SW[3] & SW[2] & (~SW[1]) | (~SW[3]) & SW[1] & SW[0] | (~SW[3]) & (~SW[2]) & SW[1];
	assign HEX0[6] = (~SW[3]) & (~SW[2]) & (~SW[1]) | SW[3] & (~SW[2]) & SW[1] | (~SW[3]) & SW[2] & SW[1] & SW[0];
	
	assign HEX1[0] = SW[3] & (SW[2] | SW[1]);
	assign HEX1[1] = SW[3] & (SW[2] | SW[1]);
	assign HEX1[2] = SW[3] & (SW[2] | SW[1]);
	assign HEX1[3] = SW[3] & (SW[2] | SW[1]);
	assign HEX1[4] = 0;
	assign HEX1[5] = 0;
	assign HEX1[6] = 1;
	assign HEX0[7] = 1;
	assign HEX1[7] = 1;

	

endmodule	
	