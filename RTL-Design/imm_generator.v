module immgen(instr,opcode,imm);
input [31:0]instr;
input [6:0]opcode;
output reg [31:0] imm;
always@(*) begin
     case (opcode)
         7'b0010011: // I_type
                imm= {{20{instr[31]}}, instr[31:20]};
                7'b0010011: begin if (instr[14:12] == 3'b001 || instr[14:12] == 3'b101)
                                          imm = {27'd0, instr[24:20]}; 
                                  else 
                                          imm = {{20{instr[31]}}, instr[31:20]}; 
                            end

            7'b0000011:  // LW
                imm = {{20{instr[31]}}, instr[31:20]};

            7'b0100011: // SW
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            7'b1100011: // BEQ
                imm = {{19{instr[31]}}, instr[31], instr[7],
                       instr[30:25], instr[11:8], 1'b0};

            7'b1101111: //JUMP and link
                imm = {{11{instr[31]}}, instr[31], instr[19:12],
                       instr[20], instr[30:21], 1'b0};

            7'b1100111: //JUMP and link register
                imm = {{20{instr[31]}}, instr[31:20]};

            7'b0110111: //LUI
                imm = {instr[31:12],12'b0};

            7'b0010111: //AUIPC
                imm = {instr[31:12],12'b0};
                
            default:
                imm = 32'd0;      
     endcase
end
endmodule 