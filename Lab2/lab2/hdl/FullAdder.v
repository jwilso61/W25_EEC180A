module FullAdder  
(
	output cO, s,
	input a, b, cI
	);
	

assign cO = (a & b) | (a & cI) | ( b & cI);
assign s = a ^ b ^ cI;

endmodule 