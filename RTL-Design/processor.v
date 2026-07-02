module processor(
    input clk,
    input reset
);
// HAZARD 
wire pc_write;
wire if_id_write;
wire control_stall;
wire flush;

//STALL
wire regwrite_stall;
wire memread_stall;
wire memwrite_stall;
wire branch_stall;
wire jump_stall;
wire jalr_stall;
wire alusrc_stall;

// IF STAGE SIGNALS
wire [31:0] pc;
wire [31:0] pc_next;
wire [31:0] instr;
wire [31:0] pc_ifid;
wire [31:0] instr_ifid;

// ID STAGE SIGNALS
wire [6:0] opcode;
wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;
wire [2:0] func3;
wire [6:0] func7;
wire [31:0] A;
wire [31:0] B;
wire [31:0] imm;
wire regwrite;
wire memread;
wire memwrite;
wire alusrc;
wire branch;
wire jump;
wire jalr;
wire [31:0] writedata;

// ID/EX PIPELINE SIGNALS
wire [31:0] pc_ex;
wire [31:0] A_ex;
wire [31:0] B_ex;
wire [31:0] imm_ex;
wire [4:0] rd_ex;
wire [4:0] rs1_ex;
wire [4:0] rs2_ex;
wire [6:0] opcode_ex;
wire [2:0] func3_ex;
wire [6:0] func7_ex;
wire regwrite_ex;
wire memread_ex;
wire memwrite_ex;
wire alusrc_ex;
wire branch_ex;
wire jump_ex;
wire jalr_ex;

// EX STAGE SIGNALS
wire [1:0] ForwardA, ForwardB;
wire [31:0] forwardA_data;
wire [31:0] forwardB_data;
wire [31:0] alu_B_final;

wire [3:0] alus;
wire [31:0] alu_B;
wire [31:0] alu_result;
wire branch_taken;
wire [31:0] branch_target;
wire [31:0] jal_target;
wire [31:0] jalr_target;

// EX/MEM PIPELINE SIGNALS
wire [31:0] alu_result_mem;
wire [31:0] B_mem;
wire [4:0] rd_mem;
wire [2:0] func3_mem;
wire regwrite_mem;
wire memread_mem;
wire memwrite_mem;
wire [6:0]opcode_mem;
wire [31:0]imm_mem;
wire [31:0]pc_mem;

// MEM STAGE SIGNALS
wire [31:0] readdata;

// MEM/WB PIPELINE SIGNALS
wire [31:0] alu_result_wb;
wire [31:0] readdata_wb;
wire [4:0] rd_wb;
wire regwrite_wb;
wire [6:0]opcode_wb;
wire [31:0]imm_wb;
wire [31:0]pc_wb;

// IF STAGE
instrfetch IF(pc,pc_next,clk,reset,pc_write,instr);
if_id IF_ID(clk,reset,if_id_write,flush,pc,instr,pc_ifid,instr_ifid);

// ID STAGE
instrdecode INSTRDECODE(opcode,rs1,rs2,rd,func3,func7,instr_ifid);
regfile REGFILE(A,B,clk,regwrite_wb,rs1,rs2,rd_wb,writedata);
ctrlunit CTRLUNIT(opcode,regwrite,memread,memwrite,alusrc,branch,jump,jalr);
immgen IMMGEN(instr_ifid,opcode,imm);
stallcontrol STALL(control_stall,regwrite,memread,memwrite,branch,jump,jalr,alusrc,regwrite_stall,
memread_stall,memwrite_stall,branch_stall,jump_stall,jalr_stall,alusrc_stall);
id_ex ID_EX(clk,reset,flush,pc_ifid,A,B,imm,rd,rs1,rs2,opcode,func3,func7,regwrite_stall,memread_stall,
memwrite_stall,alusrc_stall,branch_stall,jump_stall,jalr_stall,pc_ex,A_ex,B_ex,imm_ex,rd_ex,rs1_ex,
rs2_ex,opcode_ex,func3_ex,func7_ex,regwrite_ex,memread_ex,memwrite_ex,alusrc_ex,branch_ex,jump_ex,jalr_ex);
hazarddetect HAZARD(memread_ex,rd_ex,rs1,rs2,pc_write,if_id_write,control_stall);

// EX STAGE
forwardingunit FU(rs1_ex,rs2_ex,rd_mem,rd_wb,regwrite_mem,regwrite_wb,ForwardA,ForwardB);
aluctrl ALUCTRL(opcode_ex,func3_ex,func7_ex,alus);
assign forwardA_data =
    (ForwardA == 2'b00) ? A_ex :
    (ForwardA == 2'b10) ? alu_result_mem : writedata;
assign forwardB_data =
    (ForwardB == 2'b00) ? B_ex :
    (ForwardB == 2'b10) ? alu_result_mem : writedata;
assign alu_B_final = alusrc_ex ? imm_ex : forwardB_data;

ALU ALU(forwardA_data,alu_B_final,alu_result,alus,branch_taken);
assign branch_target = pc_ex + imm_ex;
assign jal_target    = pc_ex + imm_ex;
assign jalr_target   = (forwardA_data + imm_ex) & ~32'd1; // for even
assign pc_next       = jalr_ex ? jalr_target :
                       jump_ex ? jal_target :
                       (branch_ex && branch_taken) ? branch_target : (pc + 32'd4);  
flushcontrol FLUSH(branch_taken && branch_ex,jump_ex,jalr_ex,flush);
ex_mem EXMEM(clk,reset,alu_result,forwardB_data,rd_ex,func3_ex, opcode_ex,pc_ex,imm_ex,
regwrite_ex,memread_ex,memwrite_ex,alu_result_mem,B_mem,rd_mem,func3_mem,opcode_mem,pc_mem,
imm_mem,regwrite_mem,memread_mem,memwrite_mem);


// MEM STAGE
memaccess MEMA(readdata,memread_mem,B_mem,memwrite_mem,func3_mem,alu_result_mem,clk);
mem_wb MEMWB(clk,reset,alu_result_mem,readdata,rd_mem,opcode_mem,pc_mem,imm_mem,regwrite_mem,
alu_result_wb,readdata_wb,rd_wb,opcode_wb,pc_wb,imm_wb, regwrite_wb);


// WRITE BACK STAGE
writedata WRITEDATA(writedata,pc_wb,imm_wb,opcode_wb,alu_result_wb,readdata_wb);

endmodule
