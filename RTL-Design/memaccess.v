module memaccess(readdata,memread,memdata,memwrite,func3,addr,clk);
input clk,memread,memwrite;
input [2:0]func3;
input [31:0]memdata,addr;
output reg [31:0]readdata;
reg [31:0] mem [31:0];
integer i;

  initial begin
          for(i=0;i<32;i=i+1)
               mem[i] = 32'd0;
    end
always@(posedge clk)begin
    if(memwrite) begin
        case(func3)
            3'b000: mem[addr[6:2]][7:0]=memdata[7:0]; //Sb
            3'b001: mem[addr[6:2]][15:0]=memdata[15:0]; //Sh
            3'b010: mem[addr[6:2]]=memdata; //Sw
            default: mem[addr[6:2]]=memdata;
        endcase
    end
end
always@(posedge clk)begin
    if(memread)
        case(func3)
            3'b000: readdata={{24{mem[addr[6:2]][7]}},mem[addr[6:2]][7:0]}; //Lb
            3'b001: readdata={{16{mem[addr[6:2]][15]}},mem[addr[6:2]][15:0]}; //Lh
            3'b010: readdata=mem[addr[6:2]][31:0]; //Lw
            3'b100: readdata={24'd0,mem[addr[6:2]][7:0]}; //Lbu
            3'b101: readdata={16'd0,mem[addr[6:2]][15:0]}; //Lhu
            default: readdata=mem[addr[6:2]];
        endcase
    else
        readdata = 32'd0;
end
endmodule