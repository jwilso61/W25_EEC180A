module L5part2(
S
	input 		     [1:0]		KEY,
	output		     [9:0]		LEDR,
	input 		     [9:0]		SW
);


(* ram_init_file = "L5part2Mem.mif" *) reg [7:0] memory [15:0] /* synthesis ramstyle = "M9K" */;

endmodule
