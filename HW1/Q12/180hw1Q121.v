module prime (in, isprime);

input [3:0] in; // 4-bit input
output isprime; // true if input is prime

reg isprime;

always @ (in) begin
	case (in)
	1, 2, 3, 5, 7, 12, 13 : isprime = 1'b1;
	default: isprime = 1'b0;
	endcase
end
endmodule
/////////TESTBENCH///////////////////////////
module tb_prime;
    reg [3:0] in;       
    wire isprime;     
    
    prime UUT (
        .in(in),
        .isprime(isprime)
    );
    
    function primeCheck;
        input [3:0] num;
        case (num)
            2, 3, 5, 7, 11, 13: primeCheck = 1'b1;
            default: primeCheck = 1'b0;
        endcase
    endfunction

    initial begin
        $display("Start...");
        for (in=0; in<=15; in=in+1) begin
            #5;
            if (isprime !== primeCheck(in)) begin
                $display("FAIL: Input = %d | Expected = %b | Actual = %b", in, primeCheck(in), isprime);
            end else begin
                $display("PASS: Input = %d | Output = %b", in, isprime);
            end
        end
        $display("done");
        $finish;
    end
endmodule
