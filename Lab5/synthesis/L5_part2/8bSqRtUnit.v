module eightBSqrt(
    output reg done,
    output [3:0] sqrt,
    input clk,
    input rstN,
    input St,
    input [7:0] N
);

wire [7:0] B;
wire [7:0] tempDifference;
wire borrowOut;
reg [7:0] loadedN;
reg Su;
reg [1:0] state;
parameter IDLE = 2'b00, LOAD = 2'b01, SUBTRACT = 2'b10, DONE = 2'b11;

eightBitSubtractor s0 (
    .D(tempDifference),
    .borrowOut(borrowOut),
    .N(loadedN),
    .oddIn(B)
);

accumulator a0 (
    .B(B),
    .sqrt(sqrt),
    .clk(St),
    .rstN(rstN),
    .incr(Su)
);

always @(posedge St or negedge rstN) begin
    if (!rstN) begin
        loadedN <= 8'b00000000;
        Su <= 0;
        done <= 0;
		  state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
						loadedN <= N;
						state <= SUBTRACT;
            end
 
            LOAD: begin
					Su <= 0;
					loadedN <= tempDifference;
					state <= SUBTRACT;
            end

            SUBTRACT: begin
                if (!borrowOut) begin
                    Su <= 1;
						  state <= LOAD;
                end else begin
                    Su <= 1;
                    state <= DONE;
                end
            end

            DONE: begin
					Su <= 0;
                done <= 1;
                if (clk) begin
                    state <= IDLE;
						  done <= 0;
                end
            end

            default: state <= IDLE;
        endcase
    end
end
endmodule
