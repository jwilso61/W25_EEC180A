module FullSubtractor(
	output Bo, D,
	input a, b, bI
	);
	

assign Bo = bI & ~(a ^ b) | (~a & b) ;
assign D = (a ^ b) ^ bI;

endmodule 