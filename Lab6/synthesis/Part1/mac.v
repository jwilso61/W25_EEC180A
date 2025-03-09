module MAC (
	output wire signed [18:0] out,
	input clk,
	input macc_clear,
	input signed [7:0] inA,
	input signed [7:0] inB
);
	
	reg signed [18:0] accumulator;
	wire signed [18:0] product;
	assign out = accumulator;
	assign product = inA * inB;
	
always @ (posedge clk) begin
	 if (macc_clear == 1) begin
		accumulator <= product;
	 end else begin
		accumulator <= accumulator + product; 
	end
end
endmodule
