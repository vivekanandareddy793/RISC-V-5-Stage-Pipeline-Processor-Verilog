module regfile(A,B,clk,regwrite,rs1,rs2,rd,writedata);
input clk,regwrite;
input [4:0]rs1,rs2,rd;
input [31:0]writedata;
output [31:0]A,B;
reg [31:0] registers[31:0];
integer i;
 initial begin 
        for(i=0;i<32;i=i+1)
            registers[i]=32'd0;
 end   
 always@(posedge clk) begin
   if(regwrite==1 && rd!=0) begin
           registers[rd]<=writedata;
    end
end
 
//ssign A=(rs1!=0) ? registers[rs1] : 32'd0;
//assign B=(rs2!=0) ? registers[rs2] : 32'd0;
assign A = (regwrite && rd==rs1 && rd!=0) ? writedata : (rs1!=0 ? registers[rs1] : 0);
assign B = (regwrite && rd==rs2 && rd!=0) ? writedata : (rs2!=0 ? registers[rs2] : 0);
endmodule