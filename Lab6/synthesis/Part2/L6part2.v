module L6part2 (
		output 	reg			done,
		output 	reg [10:0]	clock_count,
		input 					clk,
		input 					start,
		input 					rst
);

integer i, j, k;
reg [2:0] state;
reg signed [18:0] partial;
parameter IDLE = 3'b000, INIT = 3'b001, MACLOAD = 3'b010, MACOP = 3'b011, PARCLR = 3'b100, DONE = 3'b101;

reg macc_clear;
reg matCWen;
reg [5:0] matCaddr;
reg signed [18:0] matCin;
reg signed [7:0] macInA;
reg signed [7:0] macInB;
wire signed [18:0] macOut;
reg signed [7:0] memA [63:0]	/* synthesis ramstyle = "M9K" */;
reg signed [7:0] memB [63:0]	/* synthesis ramstyle = "M9K" */;
//(* ram_init_file = "ram_a_init.mif"*) reg [511:0] memA  /* synthesis ramstyle = "M9K" */;
//(* ram_init_file = "ram_b_init.mif"*) reg [511:0] memB  /* synthesis ramstyle = "M9K" */;
wire signed [1215:0] mem;

RAMOUTPUT RAMOUTPUT(
		.mem(mem),
		.clk(clk),
		.writeEn(matCWen),// Write enable for a single element
		.addr(matCaddr),	// Address for the write
		.data_in(matCin)  // Data to write into mem[addr]
);

MAC mac( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(macInA),
		.inB(macInB),
		.out(macOut)
);

initial begin
	$readmemb("ram_a_init.txt", memA);
	$readmemb("ram_b_init.txt", memB);
	i <= 0;
	j <= 0;
	k <= 0;
end


always @(posedge clk or posedge rst) begin
		if (rst) begin
			done <= 0;
		   state <= IDLE;
		end else begin
		case (state)  
			IDLE: begin
				if (start) begin
					macc_clear = 0;
					state <= INIT;
				end
			end

			INIT: begin
				clock_count <= 11'b0;
				state <= PARCLR;
			end

			MACLOAD: begin
				macc_clear = 1'b0;
				if (i==7 && j==7 && k==7) begin
					i<=0;
					state <= DONE;
				end else if (i==7 && j==7 && k!=7) begin
					state <= MACOP;
				end
				
				if (i<7 && j==7)  begin 
					i <= i+1;
					state <= MACOP;	
				end // column iterator 
				if (j==7 && k==7) begin 
					j <= 0;
					state <= MACOP;
				end // row iterator
				if (j<7  && k==7) begin 
					j <= j+1;
					state <= MACOP;
				end
				if (k<7) begin 								// pair iterator 
					k <= k+1;
					state <= MACOP;
				end 
					
				if (k==7) begin 
					k<=0;
	  				matCWen <= 1;
					matCaddr <= i +j*8;
					matCin <= partial;
					state <= MACOP;
				end
				
			end
			
			MACOP: begin
				matCWen <= 0;
				if (k==0 && partial != 0) begin
					macc_clear = 1'b1;
					state = PARCLR;
				end else if (k==0 && partial == 0) begin
					macc_clear = 1'b1;
					macInA <= memA[j*8 + k];
					macInB <= memB[k + i*8];
					state <= MACLOAD;
				end else begin
					macInA <= memA[j*8 + k];
					macInB <= memB[k + i*8];
					partial <= partial + macOut;
					state <= MACLOAD;
				end
			end
			
			PARCLR: begin
				partial <= 0;
				state <= MACOP;
			end
			
			DONE: begin
				done <= 1;
			end

			default: state <= IDLE;
	  endcase
    end
end
endmodule