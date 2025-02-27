module ramOutput (
	output reg	signed [18:0] 	mem [63:0],
	input	wire						clk,
	input wire              	writeEn,      // Write enable for a single element
	input wire [5:0]        	addr,    // Address for the write
	input wire signed [18:0] 	data_in // Data to write into mem[addr]
)

//
//integer i;

always @ (posedge clk) begin
	if (writeEn) begin
			mem[addr] <= data_in;
		 end
end
	 
//always @(posedge clk or negedge rstN) begin
// if (!rstN) begin
//	for (i = 0; i < 64; i = i + 1)
//	  mem[i] <= 19'd0;
// end
endmodule
