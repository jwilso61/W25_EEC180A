module bitmulti(

	output [7:0] p,
	
	input [3:0] a, 
	input [3:0] b
	
);
// 0th bit
	and and0 (p[0], a[0], b[0]);
// 1st bit	
	and and1 (a1b0, a[1], b[0]);
	and and2 (a0b1, a[0], b[1]);
	
	FullAdder FA0 (Co0, p[1], a1b0, a0b1, 0);
// 2nd bit
	and and3 (a2b0, a[2], b[0]);
	and and4 (a1b1, a[1], b[1]);
	and and5 (a0b2, a[0], b[2]);
		
	FullAdder FA1 (Co1, S0, a2b0, a1b1, Co0);
	FullAdder FA2 (Co2, p[2], a0b2, S0, 0);
// 3rd bit
	and and6 (a3b0, a[3], b[0]);
	and and7 (a2b1, a[2], b[1]);
	and and8 (a1b2, a[1], b[2]);
	and and9 (a0b3, a[0], b[3]);
		
	FullAdder FA3(Co3, s3, a3b0, a2b1, Co1);
	FullAdder FA4(Co4, s4, a1b2, s3, Co2);
	FullAdder FA5(Co5, p[3], s4, a0b3, 0);
	
//4th bit
	and and10(a3b1, a[3], b[1]);
	and and11(a2b2, a[2], b[2]);
	and and12(a1b3, a[1], b[3]);
	
	FullAdder FA6(Co6, s6, a3b1, 0, Co3);
	FullAdder FA7(Co7, s7, a2b2, s6, Co4);
	FullAdder FA8(Co8, p[4], a1b3, s7, Co5);
	
//5th bit
	and and13(a3b2, a[3], b[2]);
	and and14(a2b3, a[2], b[3]);
	
	FullAdder FA9 (Co9, s9, a3b2, Co6, Co7);
	FullAdder FA10(Co10, p[5], a2b3, s9, Co8);
	
//6th bit & 7th bit
	and and15 (a3b3, a[3], b[3]);
	
	FullAdder FA11 (p[7], p[6], a3b3, Co9, Co10);
	

endmodule
	


	
	