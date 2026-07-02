module mem_wb(
    input clk,
    input reset,

    // Data inputs
    input [31:0] alu_result_in,
    input [31:0] readdata_in,
    input [4:0] rd_in,
    input [6:0] opcode_in,
    input [31:0] pc_in,
    input [31:0] imm_in,

    // Control input
    input regwrite_in,

    // Data outputs
    output reg [31:0] alu_result_out,
    output reg [31:0] readdata_out,
    output reg [4:0] rd_out,
    output reg [6:0] opcode_out,
    output reg [31:0] pc_out,
    output reg [31:0] imm_out,

    // Control output
    output reg regwrite_out
);

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        alu_result_out <= 32'd0;
        readdata_out   <= 32'd0;
        rd_out         <= 5'd0;
        regwrite_out   <= 1'b0;
        opcode_out     <= 7'd0;
        pc_out         <= 32'd0;
        imm_out        <= 32'd0;
    end
    else
    begin
        alu_result_out <= alu_result_in;
        readdata_out   <= readdata_in;
        rd_out         <= rd_in;
        regwrite_out   <= regwrite_in;
         opcode_out    <= opcode_in;
        pc_out         <= pc_in;
        imm_out        <= imm_in;
    end
end

endmodule