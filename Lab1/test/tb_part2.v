module tb_part2;
reg [3:0] count;
wire [7:0] HEX0;
wire [7:0] HEX1;

wire [3:0] SW;
wire [7:0] HEX2;
wire [7:0] HEX3;
wire [7:0] HEX4;
wire [7:0] HEX5;


assign SW[3:0] = count;
part2 UUT (.HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2),
.HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5),
.KEY(KEY), .LEDR(LEDR), .SW(SW));
initial begin
count = 4'b0000;
repeat (16) begin
#100
$display("in = %b, hex0 = %b, hex1 = %b", count, HEX0, HEX1);
count = count + 4'b0001;
end
end
endmodule