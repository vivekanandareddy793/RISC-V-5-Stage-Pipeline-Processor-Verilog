module hazarddetect(
    input memread_ex,
    input [4:0] rd_ex,
    input [4:0] rs1_id,
    input [4:0] rs2_id,
    output reg pc_write,
    output reg if_id_write,
    output reg control_stall
);

always @(*) begin
    if(memread_ex && (rd_ex != 5'd0) && ((rd_ex == rs1_id) || (rd_ex == rs2_id))) begin
             pc_write      = 1'b0;
             if_id_write   = 1'b0;
             control_stall = 1'b1;
    end
    else begin
             pc_write      = 1'b1;
             if_id_write   = 1'b1;
             control_stall = 1'b0;
    end
end

endmodule