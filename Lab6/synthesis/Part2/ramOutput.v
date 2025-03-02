module ramOutput (
	output wire [1215:0] 		mem,		// 64 * 19 = 1216 bits
	input	wire						clk,
	input wire              	writeEn,	// Write enable for a single element
	input wire [5:0]        	addr,    // Address for the write
	input wire signed [18:0] 	data_in	// Data to write into mem[addr]
);

reg signed [18:0] memory [63:0];

always @ (posedge clk) begin
	if (writeEn) begin
			memory[addr] <= data_in;
		 end
end

genvar i;
generate
	for (i = 0; i < 64; i = i+1) begin : packLoop
		assign mem[i*19 +:19] = memory[i];
	end
endgenerate

endmodule
