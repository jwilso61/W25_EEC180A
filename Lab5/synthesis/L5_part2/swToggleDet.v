module swToggleDet(
	 output reg tog_pulse, 	// High for **one clock cycle** on press
    input  wire clk,       // System clock
    input  wire rstN,      // Active-low reset
    input  wire sw    		// Physical switch input  
);

reg sw_prev = 1'b0; 

always @(posedge clk or negedge rstN) begin
	if (!rstN) begin
		button_prev <= 0;
		tog_pulse <= 0;
	end else begin
		tog_pulse <= sw & ~sw_prev; 
		sw_prev <= sw;
	end
end
endmodule
