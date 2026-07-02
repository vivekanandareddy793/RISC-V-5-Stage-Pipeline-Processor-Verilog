module ctrlunit(opcode,regwrite,memread,memwrite,alusrc,branch,jump,jalr);
input [6:0] opcode;
output reg memread,memwrite,regwrite;
output reg alusrc,branch,jump,jalr;
 always@(*)begin
    case (opcode)
       7'b0110011: begin  // R-type
          regwrite = 1; alusrc   = 0;
          memread  = 0; memwrite = 0;
          branch   = 0; jump     = 0;  jalr = 0;
       end
        7'b0010011: begin  // I-type
          regwrite = 1; alusrc   = 1;
          memread  = 0; memwrite = 0;
          branch   = 0; jump     = 0;  jalr = 0;
       end
       7'b0000011: begin   //LW-type
          regwrite = 1; alusrc   = 1;
          memread  = 1; memwrite = 0;
          branch   = 0; jump     = 0;  jalr = 0;
       end
        7'b0100011: begin   //SW-type
          regwrite = 0; alusrc   = 1;
          memread  = 0; memwrite = 1;
          branch   = 0; jump     = 0;  jalr = 0;
        end
        7'b1100011: begin  // BEQ-type
          regwrite = 0; alusrc   = 0;
          memread  = 0; memwrite = 0;
          branch   = 1; jump     = 0;  jalr = 0;
       end
       7'b1101111: begin   //JUMP AND LINK
          regwrite = 1; alusrc   = 1;
          memread  = 0; memwrite = 0;
          branch   = 0; jump     = 1;  jalr = 0;
       end
       7'b1100111: begin   //JUMP AND LINK REGISTER
          regwrite = 1; alusrc   = 1;
          memread  = 0; memwrite = 0;
          branch   = 0; jump     = 0;  jalr = 1;
       end
       7'b0110111: begin   //LUI
          regwrite = 1; alusrc   = 1;
          memread  = 0; memwrite = 0;
          branch   = 0; jump     = 0;  jalr = 0;
       end
       7'b0010111: begin   //AUIPC
          regwrite = 1;alusrc   = 1;
          memread  = 0;memwrite = 0;
          branch   = 0;jump     = 0;  jalr = 0;
       end
       default :begin 
          regwrite = 0;alusrc   = 0;
          memread  = 0;memwrite = 0;
          branch   = 0;jump     = 0;  jalr = 0;
       end
    endcase
 end
endmodule