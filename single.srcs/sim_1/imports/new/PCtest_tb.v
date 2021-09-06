//-----testbench of PCtest-------
`timescale 1ns/10ps
module PCtest_tb();
reg CLK, reset;
wire [31:0] PC_src;
wire [31:0] PC_out;
PCtest PCtest(
	.CLK(CLK),
	.reset(reset),
	.PC_src(PC_src),
	.PC_out(PC_out)
);
initial begin
	CLK = 0;
	reset = 0;
	#5 reset = 1;
	#7 reset = 0;
	#55 reset = 1;
end
always #10 CLK = ~CLK;
endmodule