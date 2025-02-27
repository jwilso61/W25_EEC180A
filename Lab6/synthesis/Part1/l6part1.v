module l6part1(
	input 		     [1:0]		KEY,
	output		     [9:0]		LEDR,
	input 		     [9:0]		SW
);

MAC mac (KEY[1], KEY[0], SW[7:0], SW[7:0], LEDR[9:0]);
endmodule
