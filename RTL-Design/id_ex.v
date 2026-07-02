module id_ex(
    input clk,
    input reset,
    input flush,

    // Data signals
    input [31:0] pc_in,
    input [31:0] A_in,
    input [31:0] B_in,
    input [31:0] imm_in,

    input [4:0] rd_in,
    input [4:0] rs1_in,
    input [4:0] rs2_in,

    input [6:0] opcode_in,
    input [2:0] func3_in,
    input [6:0] func7_in,

    // Control signals
    input regwrite_in,
    input memread_in,
    input memwrite_in,
    input alusrc_in,
    input branch_in,
    input jump_in,
    input jalr_in,

    // Data outputs
    output reg [31:0] pc_out,
    output reg [31:0] A_out,
    output reg [31:0] B_out,
    output reg [31:0] imm_out,

    output reg [4:0] rd_out,
    output reg [4:0] rs1_out,
    output reg [4:0] rs2_out,

    output reg [6:0] opcode_out,
    output reg [2:0] func3_out,
    output reg [6:0] func7_out,

    // Control outputs
    output reg regwrite_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg alusrc_out,
    output reg branch_out,
    output reg jump_out,
    output reg jalr_out
);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        pc_out  <= 32'd0;
        A_out   <= 32'd0;
        B_out   <= 32'd0;
        imm_out <= 32'd0;

        rd_out  <= 5'd0;
        rs1_out <= 5'd0;
        rs2_out <= 5'd0;

        opcode_out <= 7'd0;
        func3_out  <= 3'd0;
        func7_out  <= 7'd0;

        regwrite_out <= 1'b0;
        memread_out  <= 1'b0;
        memwrite_out <= 1'b0;
        alusrc_out   <= 1'b0;
        branch_out   <= 1'b0;
        jump_out     <= 1'b0;
        jalr_out     <= 1'b0;
    end
     else if(flush)
    begin
        pc_out  <= 32'd0;
        A_out   <= 32'd0;
        B_out   <= 32'd0;
        imm_out <= 32'd0;

        rd_out  <= 5'd0;
        rs1_out <= 5'd0;
        rs2_out <= 5'd0;

        opcode_out <= 7'd0;
        func3_out  <= 3'd0;
        func7_out  <= 7'd0;

        regwrite_out <= 1'b0;
        memread_out  <= 1'b0;
        memwrite_out <= 1'b0;
        alusrc_out   <= 1'b0;
        branch_out   <= 1'b0;
        jump_out     <= 1'b0;
        jalr_out     <= 1'b0;
    end

    else
    begin
        pc_out  <= pc_in;
        A_out   <= A_in;
        B_out   <= B_in;
        imm_out <= imm_in;

        rd_out  <= rd_in;
        rs1_out <= rs1_in;
        rs2_out <= rs2_in;

        opcode_out <= opcode_in;
        func3_out  <= func3_in;
        func7_out  <= func7_in;

        regwrite_out <= regwrite_in;
        memread_out  <= memread_in;
        memwrite_out <= memwrite_in;
        alusrc_out   <= alusrc_in;
        branch_out   <= branch_in;
        jump_out     <= jump_in;
        jalr_out     <= jalr_in;
    end
end


endmodule