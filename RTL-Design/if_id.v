module if_id(clk,reset,if_id_write,flush,pc_in,instr_in,pc_out,instr_out);
input clk,reset;
input if_id_write;
input flush;
input [31:0]pc_in;
input [31:0]instr_in;
output reg [31:0]pc_out;
output reg [31:0]instr_out; 

always@(posedge clk or posedge reset) begin 
    if(reset) begin
               pc_out    <= 32'd0;
               instr_out <= 32'd0;
    end
      else if(flush)      begin
               pc_out    <= 32'd0;
               instr_out <= 32'd0;
    end

    else if(if_id_write)      begin
               pc_out    <= pc_in;
               instr_out <= instr_in;
    end
     
end
endmodule