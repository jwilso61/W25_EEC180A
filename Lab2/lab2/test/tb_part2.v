module tb_part2;

    
    reg [7:0] SW;                
    wire [6:0] HEX0, HEX1, HEX2, HEX3; 
    integer a, b;              
    reg [7:0] expected_product;  
    reg [7:0] decoded_product;   

    part2 UUT (
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .SW(SW)
    );

 
    function [3:0] decode_hex;
        input [6:0] hex;
        case (hex)
            7'b1000000: decode_hex = 4'h0; // 0
            7'b1111001: decode_hex = 4'h1; // 1
            7'b0100100: decode_hex = 4'h2; // 2
            7'b0110000: decode_hex = 4'h3; // 3
            7'b0011001: decode_hex = 4'h4; // 4
            7'b0010010: decode_hex = 4'h5; // 5
            7'b0000010: decode_hex = 4'h6; // 6
            7'b1111000: decode_hex = 4'h7; // 7
            7'b0000000: decode_hex = 4'h8; // 8
            7'b0010000: decode_hex = 4'h9; // 9
            7'b0100000: decode_hex = 4'hA; // A
            7'b0000011: decode_hex = 4'hB; // B
            7'b0100111: decode_hex = 4'hC; // C
            7'b0100001: decode_hex = 4'hD; // D
            7'b0000100: decode_hex = 4'hE; // E
            7'b0001110: decode_hex = 4'hF; // F
            default:    decode_hex = 4'hX; // Invalid
        endcase
    endfunction

    // Test sequence
    initial begin
        // Iterate over all possible 4-bit values for a and b
        for (a = 4'h0; a <= 4'hf; a = a + 1) begin
            for (b = 4'h0; b <= 4'hf; b = b + 1) 
				begin
                // Apply inputs
                SW[3:0] = b;    // Lower 4 bits for a
                SW[7:4] = a;    // Upper 4 bits for b
                #10;            // Wait for outputs to stabilize

                // Decode HEX outputs back to binary
                decoded_product = {decode_hex(HEX1), decode_hex(HEX0)};
                expected_product = a * b;

                // Check for errors
                if (decoded_product != expected_product) 
                    $display("ERROR: a=%h, b=%h, Expected=%h, Got=%h",
                             a, b, expected_product, decoded_product);
                
                    $display("PASS: a=%h, b=%h, Product=%h",
                             a, b, decoded_product);
                end
            end
				        #10 $finish;	

        end

        // Finish simulation
endmodule

