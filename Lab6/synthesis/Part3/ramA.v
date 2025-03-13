module RAMA (
//	output wire signed [1215:0] memory,		// 64 * 19 = 1216 bits
	input wire					clk,
	input wire [5:0]        	addr,    // Address for the write
	output reg signed [7:0]  data_out,// Data to write into mem[addr]
	input wire [7:0]						mdi,
	input wire 						writeEnable

);

reg signed [7:0] mem [63:0];

initial begin
	$readmemb("ram_a_init.txt", mem);
end

always @ (posedge clk) begin
	if (writeEnable) mem[addr] <= mdi;
	data_out <= mem[addr];
	end



	endmodule