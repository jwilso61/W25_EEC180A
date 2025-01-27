

module tb_part2;
    integer x, i;
    reg [3:0] LEDR;
    reg [7:0] SW;

part2 UUT (
    .LEDR(LEDR[3:0]),
    .SW(SW[7:0])
);

initial begin
    #10
    for (i=0; i<10; i=i+1) begin
        #10
        x = $random & 8'b11111111;
	#10
	SW[7:0] = x;
	#10
	$display("Rand input: %b | LEDR output: %b", x[7:0], LEDR[3:0]);
    end
    $finish;
end
endmodule