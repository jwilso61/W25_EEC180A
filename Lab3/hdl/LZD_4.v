module LZD_4(
    output [2:0] LEDR,	
    input [3:0] SW
);
	
assign LEDR[2] = ~(SW[3] | SW[2] | SW[1] | SW[0]);
assign LEDR[1] = ((SW[0] | SW[1]) & ~SW[3] & ~SW[2]);
assign LEDR[0] = (SW[2] | (~SW[1] & SW[0])) & ~SW[3];
endmodule 