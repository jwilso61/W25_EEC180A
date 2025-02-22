module edge2pulse(
	 output reg out_pulse, 	// High for **one clock cycle** on press
    input  wire clk,       // System clock
    input  wire rstN,      // Active-low reset
    input  wire in    		// Physical switch input  
);

reg in_prev = 1'b0; 

always @(posedge clk or negedge rstN) begin
	if (!rstN) begin
		in_prev <= 0;
		out_pulse <= 0;
	end else begin
		out_pulse <= in & ~in_prev; 
		in_prev <= in;
	end
end
endmodule
