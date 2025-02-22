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
wire aRst;
reg [7:0] loadedN;
reg Su;
reg aRstReg;
reg [1:0] state;
parameter IDLE = 2'b00, LOAD = 2'b01, SUBTRACT = 2'b10, DONE = 2'b11;

assign aRst = aRstReg;

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
    .rstN(rstN),
    .incr(Su),
	.aRst(aRst)
);

always @(posedge clk or negedge rstN) begin
    if (!rstN) begin
        loadedN <= 8'b00000000;
        Su <= 0;
        done <= 0;
		aRstReg <= 1'b1;
		state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                done <= 0;
				aRstReg <= 1'b0;
                if (St) begin
                    loadedN <= N;
					aRstReg <= 1'b1;
					state <= SUBTRACT;
                end
            end

            LOAD: begin
				Su <= 0;
				loadedN <= tempDifference;
				state <= SUBTRACT;
            end

            SUBTRACT: begin
                if (!borrowOut) begin
                    Su <= 1;
					aRstReg <= 1'b0;
					state <= LOAD;
                end else begin
                    Su <= 0;
                    state <= DONE;
                end
            end

            DONE: begin
                done <= 1;
                if (St) begin
					aRstReg <= 1'b1;
                    state <= IDLE;
                end
            end

            default: state <= IDLE;
        endcase
    end
end
endmodule
