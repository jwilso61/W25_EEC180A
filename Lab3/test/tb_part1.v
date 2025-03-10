module tb_part1;

    wire [2:0] LEDR;
    reg [3:0] SW = 4'b0000;
    reg [2:0] leading_zeros = 3'b000;
    reg [3:0] count = 4'b0000;
	
part1 UUT (.LEDR(LEDR),	.SW(SW) );

always @ (count) begin
    case (count)
	4'b0000: leading_zeros = 3'b100;
	4'b0001: leading_zeros = 3'b011;
	4'b0010: leading_zeros = 3'b010;
	4'b0011: leading_zeros = 3'b010;
	4'b0100: leading_zeros = 3'b001;
	4'b0101: leading_zeros = 3'b001;
	4'b0110: leading_zeros = 3'b001;
	4'b0111: leading_zeros = 3'b001;
	4'b1000: leading_zeros = 3'b000;
	4'b1001: leading_zeros = 3'b000;
	4'b1010: leading_zeros = 3'b000;
	4'b1011: leading_zeros = 3'b000;
	4'b1100: leading_zeros = 3'b000;
	4'b1101: leading_zeros = 3'b000;
	4'b1110: leading_zeros = 3'b000;
	4'b1111: leading_zeros = 3'b000;
    endcase
end
	
initial begin
    #160
    for (count = 4'b0000; count <= 4'b1111; count = count + 1) begin
    SW[3:0] = count[3:0];
    #10
	if ( LEDR[2:0] != leading_zeros[2:0]) begin
	    $display("ERROR: output: %b, expected: %b", LEDR, leading_zeros);
	    end else begin
		$display("PASS: output: %b, expected: %b, SW = %b, count = %b", 
				LEDR, leading_zeros, SW, count);
	    end		
	end
	#160 $finish;
    end
endmodule
