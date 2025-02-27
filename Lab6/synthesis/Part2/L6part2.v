module L6part2 (
		output 	reg		done
		output 	[10:0]	clock_count 
		input 				clk
		input 				start
		input 				rstN
		
)

integer curA, curB, curK;
wire macInA;
wire macInB;
reg done;
reg [1:0] state;
parameter IDLE = 2'b00, INIT = 2'b01, MAC = 2'b10, DONE = 2'b11;

wire macc_clear;
reg [7:0] memA [63:0] /* synthesis ramstyle = "M9K" */;
reg [7:0] memB [63:0] /* synthesis ramstyle = "M9K" */;

initial begin
$readmemb("C:\EEC 180\Lab6\simulation\tb_l6part2\ram_a_init.txt", mema);
$readmemb("C:\EEC 180\Lab6\simulation\tb_l6part2\ram_b_init.txt", memb);
macc_clear = 1;
macc_clear
end

ramOutput RAMOUTPUT(
		.mem(),
		.clk(clk),
		.writeEn(matCWen), // Write enable for a single element
		.addr(matCaddr),    // Address for the write
		.data_in(matCin)  // Data to write into mem[addr]
)

MAC mac( 
		.clk(clk),
		.macc_clear(macc_clear),
		.inA(macInA),
		.inB(macInB),
		.out(macOut)
)

always @(posedge start or negedge rstN) begin
    if (!rstN) begin
		  state = IDLE;
    end else begin
        case (state)
            IDLE: begin
					done
            end
 
            INIT: begin
				
            end

            MAC: begin
				
				for(i=0;i<8;i=i+1) begin
					 for(j=0;j<8;j=j+1) begin
						for(k=0;k<8;k=k+1) begin
							macInA = memA[i][k];
							macInB = memB[k][j]
							matrixC[8*i+j] = matrixC[8*i+j] + matrixA[j+8*k]*matrixB[k+8*i];
						end
					 end
				  end
            end

            DONE: begin
				
            end

            default: state <= IDLE;
        endcase
    end
end
endmodule