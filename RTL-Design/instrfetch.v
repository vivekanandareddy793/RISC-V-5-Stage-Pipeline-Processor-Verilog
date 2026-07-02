module instrfetch(pc,pc_next,clk,reset,pc_write,instr);
input clk,reset;
input pc_write;
input [31:0]pc_next;
output wire [31:0]pc;
output wire [31:0]instr;
pc PC1(pc,clk,reset,pc_write,pc_next);
instrmemory  IM1(pc,instr);
endmodule