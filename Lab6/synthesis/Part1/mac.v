module MAC (
	input clk,
	input macc_clear,
	input signed [7:0] inA,
	input signed [7:0] inB,
	output reg signed [18:0] out
);
	
	reg signed [18:0] S;
	reg signed [18:0] product;
	
always @ (posedge clk) begin
	 product <= inA * inB;
	 if (macc_clear == 1) begin
		S <= product;
	 end else begin
		S <= S + product; 
	end 
	out <= S;
end
endmodule
