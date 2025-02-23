module accumulator(
    output reg [7:0] B,
    output reg [3:0] sqrt,
    input  clk,
    input rstN,
    input incr
);

always @(posedge incr or negedge rstN) begin
    if (!rstN) begin
      B <= 8'b00000001;
      sqrt <= 4'b0000;
    end else if (incr) begin
      B <= B + 8'b00000010;
      sqrt <= B + 4'b0001 >> 1;
    end
end
endmodule
