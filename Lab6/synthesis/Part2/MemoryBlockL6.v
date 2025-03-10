module memBlock(
	// output reg	[7:0]	N,
	// input wire			clk,
	// input				rstN,
	// input	wire		St
	output 		mdo,
	input 		clk, 
	input 		addr, 
	input 		memWrEn,
    input 	wire mdiA,
    input 	wire mdiB
);

assign memA <= mdiA;
assign memB <= mdiB;

(* ram_init_file = "ram_a_init.mif"*) reg signed [7:0] memA [0:63]  /* synthesis ramstyle = "M9K" */;
(* ram_init_file = "ram_b_init.mif"*) reg signed [7:0] memB [0:63]  /* synthesis ramstyle = "M9K" */;
 
// always @ (posedge clk) begin
// if (mwr) memory[addr] <= mdi; //write mem
// mdo <= memory[addr]; // read mem
// end

endmodule
