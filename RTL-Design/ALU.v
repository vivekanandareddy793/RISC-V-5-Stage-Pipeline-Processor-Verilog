module ALU(A,B,alu_result,alus,branch_taken);
input [31:0]A,B;
input [3:0]alus;
output reg [31:0]alu_result;
output reg branch_taken;
always@(*) begin
      alu_result=32'd0;
      branch_taken=1'b0;
    case(alus)
        4'b0000: alu_result = A + B;
        4'b0001: alu_result = A - B;
        4'b0010: alu_result = A & B;
        4'b0011: alu_result = A | B;
        4'b0100: alu_result = A ^ B;
        4'b0101: alu_result = A << B[4:0];
        4'b0110: alu_result = A >> B[4:0];
        4'b0111: alu_result = $signed(A) >>> B[4:0];
        4'b1000: alu_result = ($signed(A) < $signed(B))?32'b1:32'b0;
        4'b1001: alu_result = (A < B)?32'b1:32'b0;
        4'b1010: branch_taken = (A==B)?1:0;
        4'b1011: branch_taken = (A!=B)?1:0;
        4'b1100: branch_taken = ($signed(A) < $signed(B))?1:0;
        4'b1101: branch_taken = ($signed(A) >= $signed(B))?1:0;
        4'b1110: branch_taken = (A < B)?1:0;
        4'b1111: branch_taken = (A >= B)?1:0; 
        default: alu_result   = A + B;
endcase
end
endmodule