module tb_part1;
reg [2:0] count;
wire [7:0] HEX0;
wire [1:0] KEY;
wire [9:0] SW;
assign SW[0] = count[0];
assign KEY[1:0] = count[2:1];

part1 UUT (.HEX0(HEX0),
.KEY(KEY),  .SW(SW));
initial begin
count = 3'b000;
repeat (8) begin
#100
$display("in = %b, out = %b", count, HEX0[7]);
count = count + 3'b001;
end
end
endmodule