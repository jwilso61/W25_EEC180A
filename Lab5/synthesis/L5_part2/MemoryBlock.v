module memBlock(
	output reg	[7:0]	N,
	input wire			clk,
	input				rstN,
	input	wire		St
);

(* ram_init_file = "memInFile1.mif"*) reg [7:0] memory1 [15:0] /* synthesis ramstyle = "M9K" */;
 
reg [3:0] counter = 4'b0000;

always @ (posedge clk) begin
	if (!rstN) begin
		counter <= 4'b0000;
	end else begin
		if (St) begin
			N <= memory1[counter];
			counter <= counter + 1'b1;
		end
	end
end
endmodule
