module tb_part3;
    parameter N = 8;

    reg carryIn;
    reg [N-1:0] a, b;

    wire [N-1:0] s;
    wire overflow;  

part3 UUT (
	.s(s), 
	.overflow(overflow), 
	.carryIn(carryIn), 
	.a(a), 
	.b(b)
);

initial begin
    carryIn = 1'b0;
    a = 1'b0;
    b = 1'b0;

    $monitor("Time=%0t | a=%b | b=%b | carryIn=%b | s=%b | overflow=%b", 
              $time, a, b, carryIn, s, overflow);

    #10 a = {N-1{1'b0}}; b = {N-1{1'b1}}; carryIn = 0; // Add all 0s + all 1s
    #10 a = {N-1{1'b1}}; b = {N-1{1'b1}}; carryIn = 0; // Add all 1s + all 1s (Overflow expected)
    #10 a = {N-1{1'b0}}; b = {N-1{1'b0}}; carryIn = 1; // Add all 0s + carryIn
    
    #10 $stop;
end
endmodule