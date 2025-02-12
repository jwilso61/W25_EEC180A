module tb_sqrt;

parameter num_vectors=16; // 16 words
reg Clock, Resetn, Start;
wire Done;
reg [7:0] InputVal;
wire [3:0] OutputSqrt;
reg [7:0] vectors [0:num_vectors-1];
integer i;

eightBSqrt UUT (.done(Done), .sqrt(OutputSqrt), .clk(Clock), .rstN(Resetn), 
.St(Start), .N(InputVal));

initial // Clock generator
	begin
	Clock = 1'b0;
	forever #20 Clock = ~Clock; // Clock period = 40 ns
end

initial // Test stimulus
begin
    Resetn = 1'b0; // synchronous reset of state machine
    Start = 1'b0;  // set Start to 'false'
    #80 Resetn = 1'b1; // reset low for 2 Clock periods
    $readmemb("testvecs", vectors); // read testvecs file
    for (i = 0; i < num_vectors; i = i + 1) begin
        InputVal = vectors[i]; // load input value
        #20 Start = 1'b1; // Start = 'true'
        wait (Done == 1);
        $display("Input=%d, SqRt=%d, done=%h", 
                 InputVal, OutputSqrt, Done);
        #40 Start = 1'b0; // After data is captured, reset Start
        wait (Done == 0);
        #40 Resetn = 1'b0; // reset high for 1 Clock period
	#40 Resetn = 1'b1; // reset low for 1 Clock period
    end
    $finish;
end

endmodule
