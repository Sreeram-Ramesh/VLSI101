module alu_tb;
 reg [3:0] a;
    reg [3:0] b;
    reg [2:0] op;
    wire [3:0] result;
    wire carry_out;
    wire zero;

    // Instantiate the ALU

    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .carry_out(carry_out),
        .zero(zero)
    );

    initial begin
        a = 4'd0;
        b = 4'd0;
        op = 3'b000;
        #10;
        a = 4'd5; b = 4'd3; op = 3'b000; // a + b
        #10;
       // Test Case 2: Subtraction
        #10;
        a = 4'd5; b = 4'd3; op = 3'b001; // a - b
        #10;
        a = 4'd7; b = 4'd3; op = 3'b010; // a & b
        #10;
        // Test Case 4: OR
        #10;
        a = 4'd7; b = 4'd3; op = 3'b011; // a | b
        #10;
        // Test Case 5: XOR
        #10;
        a = 4'd7; b = 4'd3; op = 3'b100; // a ^ b
        #10;


        // Test Case 6: NOT
        #10;
        a = 4'd5; b = 4'dx; op = 3'b101; // ~a
        #10;


        // Test Case 7: Default case
        #10;
        a = 4'd0; b = 4'd0; op = 3'bxxx; // Invalid operation
        #10;


        // Finish simulation

        $finish;

    end


    // Monitor output

    initial begin

        $monitor("At time %t: a = %d, b = %d, op = %b, result = %d, carry_out = %b, zero = %b",

                 $time, a, b, op, result, carry_out, zero);

    end

endmodule