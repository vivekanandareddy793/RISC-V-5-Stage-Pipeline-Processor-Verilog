module instrdecode(opcode,rs1,rs2,rd,func3,func7,instr);
input [31:0]instr;
output reg [6:0]opcode;
output reg [4:0]rs1;
output reg [4:0]rs2;
output reg [4:0]rd;
output reg [2:0]func3;
output reg [6:0]func7;
always@(*) begin
     opcode = instr[6:0];
     rs1    = instr[19:15];
     rs2    = instr[24:20];
     rd     = instr[11:7];
     func3  = instr[14:12];
     func7  = instr[31:25];
end
endmodule