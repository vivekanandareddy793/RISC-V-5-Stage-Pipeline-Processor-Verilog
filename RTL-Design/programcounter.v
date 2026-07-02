module pc(pc,clk,reset,pc_write,pc_next);
input clk,reset;
input pc_write;
input [31:0]pc_next;
output reg [31:0]pc;
always@(posedge clk or posedge reset) begin 
     if(reset)
           pc<=32'd0;

     else if(pc_write)
           pc<=pc_next;
end
endmodule