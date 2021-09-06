`timescale 1ns/10ps
//-------testbench of RegFile-------
module RegFile_tb();
reg CLK, we;
reg  [ 4:0] waddr;
reg  [ 4:0] raddr1;
reg  [ 4:0] raddr2;
reg  [31:0] wdata;
wire [31:0] rdata1;
wire [31:0] rdata2;
RegFile RegFile(
	.CLK(CLK),
	.we(we),
	.waddr(waddr),
	.raddr1(raddr1),
	.raddr2(raddr2),
	.wdata(wdata),
	.rdata1(rdata1),
	.rdata2(rdata2)
);
initial begin
	CLK = 0;
	we = 1;
	waddr = 5'd31;
	wdata = 32'h0000_0001;
	raddr1 = 5'd0;
	raddr2 = 5'd1;
	#10 raddr2 = 5'd2;
	#10 raddr2 = 5'd3;
	#10 raddr2 = 5'd4;
	#10 raddr2 = 5'd30;
	#10 raddr2 = 5'd31;
	#10 $stop;
end

always #10 CLK = ~CLK;

endmodule