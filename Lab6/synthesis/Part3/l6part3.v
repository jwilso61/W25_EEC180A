module l6part3 (
		output 	reg			done,
		output 	reg [10:0]	clock_count,
		input 					clk,
		input 					start,
		input 					rst
);

integer row, column, rcPair;
reg [1:0] state;
parameter IDLE = 2'b00, MACOP = 2'b01, DONE = 2'b10;
reg macc_clear;
reg matCWen;
reg [5:0] matCaddr;
reg signed [18:0] matCin;
reg signed [7:0] macInA;
reg signed [7:0] mac1InB;
reg signed [7:0] mac2InB;
reg signed [18:0]  mac2DatBuf;
reg [5:0]  mac2AddrBuf;
wire signed [18:0] mac1Out;
wire signed [18:0] mac2Out;
reg signed [7:0] memA [0:63]	/* synthesis ramstyle = "M9K" */;
reg signed [7:0] memB [0:63]	/* synthesis ramstyle = "M9K" */;
//(* ram_init_file = "ram_a_init.mif"*) reg signed [7:0] memA [0:63]  /* synthesis ramstyle = "M9K" */;
//(* ram_init_file = "ram_b_init.mif"*) reg signed [7:0] memB [0:63]  /* synthesis ramstyle = "M9K" */;

RAMOUTPUT RAMOUTPUT(
		.clk(clk),
		.writeEn(matCWen),// Write enable for a single element
		.addr(matCaddr),	// Address for the write
		.data_in(matCin)  // Data to write into mem[addr]
);

MAC mac1( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(macInA),
		.inB(mac1InB),
		.out(mac1Out)
);

MAC mac2( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(macInA),
		.inB(mac2InB),
		.out(mac2Out)
);

initial begin
	$readmemb("ram_a_init.txt", memA);
	$readmemb("ram_b_init.txt", memB);
	clock_count <= 0;
	row 			<= 0;
	column 		<= 0;
	rcPair 		<= 0;
	matCaddr 	<= 0;
	matCin 		<= 0;
	matCWen 		<= 0;
	macc_clear 	<= 1;
	macInA 		<= 0;
	mac1InB 		<= 0;
	mac2InB 		<= 0;
	mac2AddrBuf <= 0;
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

//				if (row==0 && column==0 && rcPair==0) 	macc_clear <= 1'b1;
				
				if (mac2AddrBuf== 31 && rcPair==2) 	state <= DONE;
				if (row<3  && rcPair==7)					row <= row + 1;		// row iterator
				if (row==3 && rcPair==7)					row <= 1'b0;
				if (column<7 && row==3 && rcPair==7)	column <= column+1;	// column iterator
				if (rcPair<7)									rcPair <= rcPair+1;	// pair iterator
				
				if (rcPair==0 && mac1Out == 0) begin							// ?ensures first pair is not added to itself?
					macInA 	<= memA[column + rcPair*8];
					mac1InB  <= memB[rcPair + row*8];
					mac2InB  <= memB[rcPair + (row+4)*8];
				end else begin
					macInA 	<= memA[column + rcPair*8];
					mac1InB  <= memB[rcPair + row*8];
					mac2InB  <= memB[rcPair + (row+4)*8];
				end
				
				if (rcPair==0)	macc_clear <= 1'b1;
				if (macc_clear==1 && mac1Out!=0) matCWen <= 1;
				
				if (rcPair==2 && matCWen==1) begin		//for buffer
					matCWen <= 1;
					matCin <= mac2DatBuf;
					matCaddr <= mac2AddrBuf + 32;
				end	
				
				if (rcPair==1) begin
					matCin <= mac1Out;
					mac2DatBuf <= mac2Out;
				end

				if (rcPair==7) begin
					rcPair<=0;
					matCaddr   <= row*8 + column;
					mac2AddrBuf<= row*8 + column;
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