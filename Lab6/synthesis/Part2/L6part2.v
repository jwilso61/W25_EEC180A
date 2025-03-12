module L6part2 (
		output 	reg			done,
		output 	reg [10:0]	clock_count,
		input 					clk,
		input 					start,
		input 					rst,
		output	 [8:0]  LEDR,
		input 	[3:0] SW
		
);




integer row, column, rcPair;
reg [1:0] state;
parameter IDLE = 2'b00, MACOP = 2'b01, DONE = 2'b10;
reg macc_clear;
reg matCWen;
reg [5:0] matCaddr;
reg [5:0] matAaddr;
reg [5:0] matBaddr;
reg signed [18:0] matCin;
wire signed [7:0] matAout;
wire signed [7:0] matBout;
reg signed [7:0] macInA;
reg signed [7:0] macInB;






wire signed [18:0] macOut;
///* synthesis ramstyle = "M9K" */reg signed [7:0] memA [0:63]	;
///* synthesis ramstyle = "M9K" */reg signed [7:0] memB [0:63]	;
//(* ram_init_file = "ram_a_init.mif"*) reg signed [7:0] memA [0:63]  /* synthesis ramstyle = "M9K" */;
//(* ram_init_file = "ram_b_init.mif"*) reg signed [7:0] memB [0:63]  /* synthesis ramstyle = "M9K" */;




RAMOUTPUT RAMOUTPUT(
		.clk(clk),
		.writeEn(matCWen),// Write enable for a single element
		.addr(matCaddr),	// Address for the write
		.data_in(matCin),  // Data to write into mem[addr]
		.data_out(LEDR)
);


RAMA ramA(
		.clk(clk),
		.addr(matAaddr),	
		.data_out(matAout),
		.mdi(SW[0]),
		.writeEnable(SW[1])

		


);

RAMB ramB(
		.clk(clk),
		.addr(matBaddr),	
		.data_out(matBout),
		.mdi(SW[2]),
		.writeEnable(SW[3])

);


MAC mac( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(macInA),
		.inB(macInB),
		.out(macOut)
);

initial begin
//	$readmemb("ram_a_init.txt", memA);
//	$readmemb("ram_b_init.txt", memB);
	row <= 0;
	column <= 0;
	rcPair <= 0;
	matCaddr <= 0;
	matCin <= 0;
	matCWen <= 0;
	macc_clear <= 1;
	macInA <= 0;
	macInB <= 0;
end


always @(posedge clk or posedge rst) begin

		if (rst) begin
			done <= 0;
		   state <= IDLE;
		end else begin
		
		case (state)  
			IDLE: begin
				if (start) begin
					clock_count <= 11'b0;
					state <= MACOP;
				end
			end
			
			MACOP: begin
				clock_count = clock_count+1;
				macc_clear <= 1'b0;
				matCWen <= 0;

				if (row==0 && column==0 && rcPair==0) macc_clear <= 1'b1;

				if (matCaddr==6'b111111 && rcPair==2) state <= DONE;
				
				if (row<7  && rcPair==7)							row <= row + 1;				// row iterator
				if (row==7 && rcPair==7)							row <= 1'b0;
				
				if (column<7 && row==7 && rcPair==7)		column <= column+1;		// column iterator
				
				if (rcPair<7)										rcPair <= rcPair+1;			// pair iterator
				
				if (rcPair==0 && macOut == 0) begin							// ?ensures first pair is not added to itself?
					matAaddr <= column + rcPair*8;
					matBaddr <= rcPair + row*8;
					macInA <= matAout;
					macInB <= matBout;
				end else begin
					matAaddr <= column + rcPair*8;
					matBaddr <= rcPair + row*8;
					macInA <= matAout;
					macInB <= matBout;
				end
				
				if (rcPair==0)			macc_clear <= 1'b1;
				if (macc_clear==1 && macOut!=0) 	matCWen <= 1;
				
				if (rcPair==1) 		matCin <= macOut;

				if (rcPair==7) begin
					rcPair<=0;
					matCaddr <= row*8 + column;
				end
				
			end
			
			DONE: begin
				done <= 1;
			end

			default: state <= IDLE;
	  
	  endcase
    end
		
end




endmodule