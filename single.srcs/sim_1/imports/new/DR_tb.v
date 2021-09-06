`timescale 1ns/10ps
//2021-6-14,Îâ¼Ñ±ö
//---------testbench of DR----------
module DR_tb();
reg CLK, we;
reg  [ 4:0] addr;
reg  [31:0] wdata;
wire [31:0] rdata;
DR DR(
	.CLK(CLK),
	.we(we),
	.addr(addr),
	.wdata(wdata),
	.rdata(rdata)
);
initial begin
	CLK = 0;
	we = 0;
	addr = 5'd0;
	#10 addr = 5'd1; we = 1; wdata = 32'hffff_ffff;
    #10 $stop;
end

always #10 CLK = ~CLK;

endmodule