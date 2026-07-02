module flushcontrol(
    input branch_taken,
    input jump,
    input jalr,
    output flush
);

assign flush = branch_taken | jump | jalr;

endmodule