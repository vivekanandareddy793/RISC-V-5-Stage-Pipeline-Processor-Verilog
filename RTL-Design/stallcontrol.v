module stallcontrol(
    input control_stall,
    input regwrite_in,
    input memread_in,
    input memwrite_in,
    input branch_in,
    input jump_in,
    input jalr_in,
    input alusrc_in,
    output regwrite_out,
    output memread_out,
    output memwrite_out,
    output branch_out,
    output jump_out,
    output jalr_out,
    output alusrc_out
);

assign regwrite_out = control_stall ? 1'b0 : regwrite_in;
assign memread_out  = control_stall ? 1'b0 : memread_in;
assign memwrite_out = control_stall ? 1'b0 : memwrite_in;
assign branch_out   = control_stall ? 1'b0 : branch_in;
assign jump_out     = control_stall ? 1'b0 : jump_in;
assign jalr_out     = control_stall ? 1'b0 : jalr_in;
assign alusrc_out   = control_stall ? 1'b0 : alusrc_in;
endmodule