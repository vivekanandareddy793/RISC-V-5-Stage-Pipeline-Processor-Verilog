module aluctrl(
    input [6:0] opcode,
    input [2:0] func3,
    input [6:0] func7,
    output reg [3:0] alus
);

always @(*) begin
    case(opcode)
    // R-Type
    7'b0110011: begin
        case({func7,func3})
            10'b0000000000: alus = 4'b0000; // ADD
            10'b0100000000: alus = 4'b0001; // SUB
            10'b0000000111: alus = 4'b0010; // AND
            10'b0000000110: alus = 4'b0011; // OR
            10'b0000000100: alus = 4'b0100; // XOR
            10'b0000000001: alus = 4'b0101; // SLL
            10'b0000000101: alus = 4'b0110; // SRL
            10'b0100000101: alus = 4'b0111; // SRA
            10'b0000000010: alus = 4'b1000; // SLT
            10'b0000000011: alus = 4'b1001; // SLTU
            default: alus = 4'b0000;
        endcase
    end

    // I-Type Arithmetic
    7'b0010011: begin
        case(func3)
            3'b000: alus = 4'b0000; // ADDI
            3'b010: alus = 4'b1000; // SLTI
            3'b011: alus = 4'b1001; // SLTIU
            3'b100: alus = 4'b0100; // XORI
            3'b110: alus = 4'b0011; // ORI
            3'b111: alus = 4'b0010; // ANDI
            3'b001: alus = 4'b0101; // SLLI
            3'b101: begin
                if(func7 == 7'b0000000)
                    alus = 4'b0110; // SRLI
                else if(func7 == 7'b0100000)
                    alus = 4'b0111; // SRAI
                else
                    alus = 4'b0000;
            end

            default: alus = 4'b0000;
        endcase
    end

    
    // Load / Store
    7'b0000011: alus = 4'b0000; // LOAD
    7'b0100011: alus = 4'b0000; // STORE

    // Branch
    7'b1100011: begin
        case(func3)
            3'b000: alus = 4'b1010; // BEQ
            3'b001: alus = 4'b1011; // BNE
            3'b100: alus = 4'b1100; // BLT
            3'b101: alus = 4'b1101; // BGE
            3'b110: alus = 4'b1110; // BLTU
            3'b111: alus = 4'b1111; // BGEU
            default: alus = 4'b0000;
        endcase
    end

    // JAL / JALR
    7'b1101111: alus = 4'b0000; // JAL
    7'b1100111: alus = 4'b0000; // JALR

    // LUI / AUIPC
    7'b0110111: alus = 4'b0000; // LUI
    7'b0010111: alus = 4'b0000; // AUIPC

    default: alus = 4'b0000;

    endcase
end

endmodule