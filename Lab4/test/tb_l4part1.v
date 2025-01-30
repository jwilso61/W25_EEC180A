module tb_l4part1;
    integer i, j;
    wire Z;
    wire [2:0] state;
    reg C;
    reg X;
    reg RST;
    reg CLK;
    reg [19:0] bs [0:1];
    reg [19:0] vs [0:1];

l4part1 UUT (.Z(Z), .state(state), .CLK(CLK), .X(X), .RST(RST) );

initial begin
	CLK = 0;
	forever #5 CLK <= ~CLK;
end

initial begin
    bs[1] = 20'b01010100101000101111;
    vs[1] = 20'b00010100001000000000;
    bs[0] = 20'b01010100101110101000;
    vs[0] = 20'b00010100001011111111;
    RST = 1'b1;
    X = 1'b0;
    #20
    RST = 1'b0;
    for (i=1; i>=0; i=i-1) begin
	for (j=19; j>=0; j=j-1) begin
        	X = bs[i][j];
		#10
		C = (Z == vs[i][j]);
		$display("Current :State %b | Output: %b | OK? = %b", state[2:0], Z, C);
	end
    X = 1'b0;
    #10
    RST = 1'b1;
    #10
    RST = 1'b0;
    end
    #5
    $finish;
end
endmodule