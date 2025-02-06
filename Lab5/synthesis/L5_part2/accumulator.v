
module accumulator(
    output [7:0] B,
	 output [3;0] sqrt,
    input incr,
	 input rst
);

wire B[7:0];
wire sqrt[3:0];
 
always @ (posedge incr | posedge rst) begin
if (rst) begin
	B = 8'b00000001;
end else begin
	B = B+2;
	sqrt[3:0] = B[4:1];
end

endmodule
