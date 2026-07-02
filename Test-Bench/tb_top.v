
module tb_processor;
reg clk;
reg reset;

processor RISC(clk,reset);
always #5 clk = ~clk;
integer i;
initial begin
    $dumpfile("risc.vcd");
    $dumpvars(0,tb_processor);
    
    clk = 0;
    reset = 1;
    #20;
    reset = 0;

    #2000;
    for(i=0;i<32;i=i+1)
        $display("x%0d = %h (%0d)",i,RISC.REGFILE.registers[i],RISC.REGFILE.registers[i]);

    $finish;
end

endmodule