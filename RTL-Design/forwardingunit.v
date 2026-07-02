module forwardingunit(
    input [4:0] rs1_ex, rs2_ex,
    input [4:0] rd_mem, rd_wb,
    input regwrite_mem, regwrite_wb,
    output reg [1:0] ForwardA, ForwardB
);

always @(*) begin
    ForwardA = 2'b00;
    ForwardB = 2'b00;
    
    if(regwrite_mem && (rd_mem != 0) && (rd_mem == rs1_ex))
          ForwardA = 2'b10;
    else if(regwrite_wb && (rd_wb != 0) && (rd_wb == rs1_ex))
          ForwardA = 2'b01;

    if(regwrite_mem && (rd_mem != 0) && (rd_mem == rs2_ex))
          ForwardB = 2'b10;
    else if(regwrite_wb && (rd_wb != 0) && (rd_wb == rs2_ex))
          ForwardB = 2'b01;
end

endmodule