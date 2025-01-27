//EEC180A-W2025 - L2p3
module part3
    #(parameter N = 8)(
    output [N-1:0] s, 
    output overflow,  
    input carryIn,     
    input [N-1:0] a, b
);
//==REG/WIRE declaration=================================
wire [N:0] carry;
//==Structural coding====================================
assign carry[0] = carryIn;
genvar i;
generate
    for (i=0; i<N; i=i+1) begin : FAgen
	FullAdder u0 (
		.cO(carry[i+1]),
		.s(s[i]),
		.a(a[i]),
		.b(b[i]),
		.cI(carry[i])
);
    end
endgenerate
assign overflow = carry[N-1] ^ carry[N];
endmodule