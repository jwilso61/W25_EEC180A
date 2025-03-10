module RAMOUTPUT (
//	output wire signed [1215:0] memory,		// 64 * 19 = 1216 bits
	input wire					clk,
	input wire              	writeEn,	// Write enable for a single element
	input wire [5:0]        	addr,    // Address for the write
	input wire signed [18:0] 	data_in	// Data to write into mem[addr]
);

reg signed [18:0] mem [63:0];

always @ (posedge clk) begin
	if (writeEn) mem[addr] <= data_in;
end
endmodule
