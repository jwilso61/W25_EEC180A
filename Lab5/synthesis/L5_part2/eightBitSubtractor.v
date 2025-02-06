
module eightBitSubtractor(
    output [7:0] D, 
    output borrowOut,     
    input [7:0] N, oddIn
);

wire [7:0] borrow;
assign borrow[0] = 0;

genvar i;
generate
    for (i=0; i<8; i=i+1) begin : FSgen
	FullSubtractor u0 (
		.Bo(borrow[i+1]),
		.D(D[i]),
		.a(N[i]),
		.b(oddIn[i]),
		.bI(borrow[i])
);
    end
endgenerate
assign borrowOut = borrow[7];
endmodule