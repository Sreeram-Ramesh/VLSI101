module alu (
    input wire [3:0] a,       // 4-bit input A
    input wire [3:0] b,       // 4-bit input B
    input wire [2:0] op,      // 3-bit operation selector
    output reg [3:0] result,  // 4-bit result
    output reg carry_out,     // Carry out for addition
    output reg zero           // Zero flag
);
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter AND = 3'b010;
    parameter OR  = 3'b011;
    parameter XOR = 3'b100;
    parameter NOT = 3'b101;
    
    always @(*) begin
        case (op)
        
            ADD: begin
                {carry_out, result} = a + b; // Perform addition with carry
            end
            
            SUB: begin
                {carry_out, result} = a - b; // Perform subtraction with carry

            end

            AND: begin
                result = a & b; // Perform bitwise AND
                carry_out = 0;
            end

            OR: begin
                result = a | b; // Perform bitwise OR
                carry_out = 0;

            end

            XOR: begin
                result = a ^ b; // Perform bitwise XOR
                carry_out = 0;
            end

            NOT: begin
                result = ~a;    // Perform bitwise NOT (only on input A)
               carry_out = 0;
            end
            default: begin
                result = 4'b0000; // Default case
                carry_out = 0;
            end
        endcase        
        zero = (result == 4'b0000); // Set zero flag if result is zero
    end
endmodule