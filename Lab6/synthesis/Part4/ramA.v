module RAMA (
	input wire					clk,
	input wire [5:0]        	addr1,    // Address for the write
	input wire [5:0]        	addr2,    // Address for the write
	output reg signed [7:0]  data_out1,// Data to write into mem[addr]
	output reg signed [7:0]  data_out2,// Data to write into mem[addr]
	input wire [7:0]						mdi,
	input wire 						writeEnable
);

reg signed [7:0] mem [63:0];

initial begin
	$readmemb("ram_a_init.txt", mem);
end

always @ (posedge clk) begin
	if (writeEnable) mem[addr1] <= mdi;
	data_out1 <= mem[addr1];
	data_out2 <= mem[addr2];
	end

endmodule
