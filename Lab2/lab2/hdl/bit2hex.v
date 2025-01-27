module bit2Hex (

	output [7:0] HEX,
	
	input [3:0] SW
	
);
	

	assign HEX[6] = (~SW[3] & ~SW[2] & ~SW[1]) |(~SW[3] & SW[2] & SW[1] & SW[0]);
	assign HEX[5] = (~SW[3] & ~SW[2] & SW[0]) | (~SW[2] & SW[1] & ~SW[0]) | (~SW[3] & SW[1] & SW[0]) | (SW[3] & SW[2] & ~SW[1]);
	assign HEX[4] = (~SW[3] & SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1]);
	assign HEX[3] = (SW[2] & SW[1] & SW[0]) | (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1] & ~SW[0]);
	assign HEX[2] = (~SW[3] & ~SW[2] & SW[1] & ~SW[0]) | (SW[3] & SW[2] & ~SW[0]) | (SW[3] & SW[2] & SW[1]);
	assign HEX[1] = (SW[3] & SW[1] & SW[0]) | (~SW[3] & SW[2] & ~SW[1] & SW[0]) | (~SW[3] & SW[2] & SW[1] & ~SW[0]) | (SW[3] & SW[2] & ~SW[1] & ~SW[0]);
	assign HEX[0] = (SW[3] & ~SW[2] & SW[1] & SW[0]) | (~SW[3] & ~SW[2] & ~SW[1] & SW[0]) | (SW[3] & SW[2] & ~SW[1]) | (SW[2] & ~SW[1] & ~SW[0]);
	
endmodule 