module writedata(writedata,pc,imm,opcode,alu_result,readdata);
input [31:0]pc,imm;
input [6:0]opcode;
input [31:0]alu_result,readdata;
output reg [31:0]writedata;
always@(*) 
    case(opcode)
    7'b0110011: writedata=alu_result;
    7'b0010011: writedata=alu_result;
    7'b0000011: writedata=readdata;
    7'b0100011: writedata=32'd0;
    7'b1100011: writedata=32'd0;
    7'b1101111: writedata=pc+32'd4;
    7'b1100111: writedata=pc+32'd4;
    7'b0110111: writedata=imm;
    7'b0010111: writedata=pc+imm;
    default   : writedata=alu_result;
    endcase
endmodule