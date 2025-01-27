module tb_part1;
	reg  [3:0] count;
	wire [2:0] LEDR;
	wire [3:0] SW;
	
	
	
	part1 UUT (
		.SW(SW),
		.LEDR(LEDR)
		);
		
assign SW[3:0] = count;
		
	initial begin
		count = 4'b0000;
		repeat (16) begin
			#10
			$display("input = %b, leading zeros = %b", count, {LEDR[2], LEDR[1], LEDR[0]});
			count = count + 4'b0001;
			end
		end	
		
endmodule
	