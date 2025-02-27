module twoBitDownCounter (
    input wire clk,          
    input wire reset,  
    output reg [1:0] count   
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 2'b00;
        else begin
            case (count)
                2'b00: count <= 2'b11;
                2'b11: count <= 2'b10;
                2'b10: count <= 2'b01;
                2'b01: count <= 2'b00;
            endcase
        end
    end
endmodule


module tb_twoBitDownCounter;
    reg clk;
    reg reset;
    wire [1:0] count;

    twoBitDownCounter UUT (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor($time, " ns | clk = %b | reset = %b | count = %b", clk, reset, count);
        reset = 1;
        #10;
        reset = 0;
        #100;
        reset = 1;
        #10;
        reset = 0;
        #100;
        $finish;
    end
endmodule