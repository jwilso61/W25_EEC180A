module buttonEdgeDet(
	 output reg button_edge, // High for **one clock cycle** on press
    input  wire clk,       // System clock
    input  wire rstN,      // Active-low reset
    input  wire button    // Physical button input  
);

reg button_prev = 1'b0; 

always @(posedge clk or negedge rstN) begin
	if (!rstN) begin
		button_prev <= 0;
		button_edge <= 0;
	end else begin
		button_edge <= button & ~button_prev; 
		button_prev <= button; 
	end
end
endmodule
