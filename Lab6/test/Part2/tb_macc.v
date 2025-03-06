`timescale 1ns/10ps

// Test bench module
module tb_macc;

// Input Array
/////////////////////////////////////////////////////////
//                  Test Bench Signals                 //
/////////////////////////////////////////////////////////

reg clk;

/////////////////////////////////////////////////////////
//                  I/O Declarations                   //
/////////////////////////////////////////////////////////
// declare variables to hold signals going into submodule
reg signed [7:0] inA, inB;
reg macc_clear;

// Output Signals
wire signed [18:0] macc_out;


/////////////////////////////////////////////////////////
//              Submodule Instantiation                //
/////////////////////////////////////////////////////////

/*****************************************
RENAME SIGNALS TO MATCH YOUR MODULE
******************************************/
mac DUT
(
    .clk        (clk),
    .macc_clear (macc_clear),
    .inA        (inA),
    .inB        (inB),
    .macc_out    (macc_out)
  );

initial begin
    // YOUR CODE GOES HERE

    $stop; // End Simulation
end


// Clock
always begin
   #10;           // wait for initial block to initialize clock
   clk <= ~clk;
end

endmodule
