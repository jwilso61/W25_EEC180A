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
reg [2:0] state;
parameter IDLE = 3'b000, LOAD = 3'b001, PROP = 3'b010, SUBTRACT = 3'b011, DONE = 3'b100;

eightBitSubtractor s0 (
    .D(tempDifference),
    .borrowOut(borrowOut),
    .N(loadedN),
    .oddIn(B)
);

accumulator a0 (
    .B(B),
    .sqrt(sqrt),
    .clk(clk),
    .rst(rstN),
    .incr(Su),
    .load(1'b0)
);


always @(posedge clk or negedge rstN) begin
    if (!rstN) begin
        state <= IDLE;
        loadedN <= 8'b0;
        Su <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                done <= 0;
                if (St) begin
                    state <= LOAD;
                end
            end

            LOAD: begin
		        loadedN <= N;
                state <= PROP;
            end

	       PROP: begin
                state <= SUBTRACT;
		        Su <= 0;
            end

            SUBTRACT: begin
                if (!borrowOut) begin
                    loadedN <= tempDifference;
                    Su <= 1;
		            state <= PROP;
                end else begin
                    Su <= 0;
                    state <= DONE;
                end
            end

            DONE: begin
                done <= 1;
                if (!St) begin  
                    state <= IDLE;
                end
            end

            default: state <= IDLE;
        endcase
    end
end
endmodule
