module ex_mem(
    input clk,
    input reset,

    // Data inputs
    input [31:0] alu_result_in,
    input [31:0] B_in,
    input [4:0] rd_in,
    input [2:0] func3_in,
    input [6:0] opcode_in,
    input [31:0] pc_in,
    input [31:0] imm_in,

    // Control inputs
    input regwrite_in,
    input memread_in,
    input memwrite_in,

    // Data outputs
    output reg [31:0] alu_result_out,
    output reg [31:0] B_out,
    output reg [4:0] rd_out,
    output reg [2:0] func3_out,
    output reg [6:0] opcode_out,
    output reg [31:0] pc_out,
    output reg [31:0] imm_out,


    // Control outputs
    output reg regwrite_out,
    output reg memread_out,
    output reg memwrite_out
);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        alu_result_out <= 32'd0;
        B_out      <= 32'd0;
        rd_out     <= 5'd0;
        func3_out  <= 3'd0;
        opcode_out <=7'd0;
        pc_out     <= 32'd0;
        imm_out    <=32'd0;

        regwrite_out  <= 1'b0;
        memread_out   <= 1'b0;
        memwrite_out  <= 1'b0;
    end
    else
    begin
        alu_result_out <= alu_result_in;

        B_out      <= B_in;
        rd_out     <= rd_in;
        func3_out  <= func3_in;
        opcode_out <=opcode_in;
        pc_out     <= pc_in;
        imm_out    <=imm_in;

        regwrite_out  <= regwrite_in;
        memread_out   <= memread_in;
        memwrite_out  <= memwrite_in;
    end
end
endmodule