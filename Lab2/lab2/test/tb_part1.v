module tb_part1;
	reg [7:0] a;
	reg [7:0] b;
//	wire [7:0] a;
//	wire [7:0] b;
	
	reg carryin;
	wire overflow;
	wire[7:0] sum;
	

	
	
part1 UUT ( sum[7:0], overflow, carryin, a, b);

initial begin
	
	for (carryin = 0; carryin <= 1; carryin = carryin +1)
		
		begin

		for (a = 8'b00000000; a <= 8'b11111111; a = a + 1)
			begin
			
			for (b = 8'b00000000; b <= 8'b1111111; b = b + 1)
				begin
				#10
				if ( sum[7:0] != (a + b))
					$display("ERROR: a=%b, b = %b, sum =%b", a, b, sum[7:0]);
				
				if ( overflow == 1)
					$display("ERROR: overflow = %b", overflow);
					end
				
				end
			end
			#10 $finish;
			
		end
		
endmodule

		