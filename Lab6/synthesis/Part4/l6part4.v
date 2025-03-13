module l6part4 (
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
reg [5:0] matAaddr1;
reg [5:0] matAaddr2;
reg [5:0] matBaddr1;
reg [5:0] matBaddr2;

reg signed [18:0] matCin;
reg signed [7:0] mac1InA;
reg signed [7:0] mac2InA;
reg signed [7:0] mac1InB;
reg signed [7:0] mac2InB;
reg signed [18:0]  mac2DatBuf;
reg [5:0]  AddrBuf;
reg signed [18:0]  mac3DatBuf;
reg signed [18:0]  mac4DatBuf;
wire signed [7:0] matAout1;
wire signed [7:0] matAout2;
wire signed [7:0] matBout1;
wire signed [7:0] matBout2;
wire signed [18:0] mac1Out;
wire signed [18:0] mac2Out;
wire signed [18:0] mac3Out;
wire signed [18:0] mac4Out;

RAMOUTPUT RAMOUTPUT(
		.clk(clk),
		.writeEn(matCWen),// Write enable for a single element
		.addr(matCaddr),	// Address for the write
		.data_in(matCin),  // Data to write into mem[addr]
		.data_out(LEDR)
);

RAMA ramA(
		.clk(clk),
		.addr1(matAaddr1),	
		.addr2(matAaddr2),	
		.data_out1(matAout1),
		.data_out2(matAout2),
		.mdi(SW[2]),
		.writeEnable(SW[3])

);

RAMB ramB(
		.clk(clk),
		.addr1(matBaddr1),	
		.addr2(matBaddr2),	
		.data_out1(matBout1),
		.data_out2(matBout2),
		.mdi(SW[2]),
		.writeEnable(SW[3])

);

MAC mac1( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(matAout1),
		.inB(matBout1),
		.out(mac1Out)
);

MAC mac2( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(matAout1),
		.inB(matBout2),
		.out(mac2Out)
);

MAC mac3( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(matAout2),
		.inB(matBout1),
		.out(mac3Out)
);

MAC mac4( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(matAout2),
		.inB(matBout2),
		.out(mac4Out)
);
		
initial begin
	clock_count <= 0;
	row 		<= 0;
	column 		<= 0;
	rcPair 		<= 0;
	matCaddr 	<= 0;
	matCin 		<= 0;
	matCWen 	<= 0;
	macc_clear 	<= 1;
	mac1InA 	<= 0;
	mac2InA 	<= 0;
	mac1InB 	<= 0;
	mac2InB 	<= 0;
	AddrBuf 	<= 0;
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
			
				if (AddrBuf== 27 && rcPair==7) 	state <= DONE;
				if (row<3  && rcPair==7)					row <= row + 1;		// row iterator
				if (row==3 && rcPair==7)					row <= 1'b0;
				if (column<3 && row==3 && rcPair==7)	column <= column+1;	// column iterator
				if (rcPair<7)									rcPair <= rcPair+1;	// pair iterator
				
				if (rcPair==0 && mac1Out == 0) begin							// ?ensures first pair is not added to itself?
					matAaddr1   <= column + rcPair*8;
					matAaddr2   <= (column+4) + rcPair*8;
					matBaddr1  <= rcPair + row*8;
					matBaddr2  <= rcPair + (row+4)*8;
				end else begin
					matAaddr1   <= column + rcPair*8;
					matAaddr2   <= (column+4) + rcPair*8;
					matBaddr1  <= rcPair + row*8;
					matBaddr2  <= rcPair + (row+4)*8;
				end
				
				if (rcPair==1)	macc_clear <= 1'b1;
				
				if (rcPair==5 && matCWen==1) begin		
					matCWen <= 1;
					matCin <= mac4DatBuf;
					matCaddr <= AddrBuf +36;
				end

				if (rcPair==4 && matCWen==1) begin
					matCWen <= 1;
					matCin <= mac3DatBuf;
					matCaddr <= AddrBuf +4;
				end	

				if (rcPair==3 && matCWen==1) begin		
					matCWen <= 1;
					matCin <= mac2DatBuf;
					matCaddr <= AddrBuf +32;
				end	
				
				if (rcPair==2) begin
					matCin <= mac1Out;
					mac2DatBuf <= mac2Out;
					mac3DatBuf <= mac3Out;
					mac4DatBuf <= mac4Out;
				end

				if (rcPair==2 && mac1Out!=0) matCWen <= 1;

				if (rcPair==7) begin
					rcPair<=0;
					matCaddr   <= row*8 + column;
					AddrBuf<= row*8 + column;
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