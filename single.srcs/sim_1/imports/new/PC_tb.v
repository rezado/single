//2021-7-12 Îâ¼Ñ±ö
//---------testbench of PC/PCadd/PCBranch/GenNextPC-------------
`timescale 1ns/10ps
module PC_tb();
//PC
reg CLK, reset;
wire  [31:0]   PC_src, PC_out;
//PCadd
wire  [31:0]   nextPC;
//PCBranch
reg   [15:0]   offset;
reg   [25:0]   instr_index;
wire  [31:0]   beqpc;
wire  [31:0]   jalpc;
//GenNextPC
reg   [ 3:0]   sel_nextpc;
reg   [31:0]   rdata1;

PC PC(
	.CLK(CLK),
	.reset(reset),
	.PC_src(PC_src),
	.PC_out(PC_out)
);
PCadd PCadd(
	.CLK(CLK),
	.reset(reset),
	.oldPC(PC_out),
	.newPC(nextPC)
);
PCBranch PCBranch(
	.pcadd(nextPC),
	.offset(offset),
	.beq_bne_jump(1'b1),
	.instr_index(instr_index),
	.beqpc(beqpc),
	.jalpc(jalpc)
);
GenNextPC GenNextPC(
	.in0(nextPC),
	.in1(beqpc),
	.in2(jalpc),
	.in3(rdata1),
	.sel_nextpc(sel_nextpc),
	.PCsrc(PC_src)
);

initial begin
    CLK = 0;
	reset = 0;
	offset = 32'd1;
	instr_index = 32'd2;
	rdata1 = 32'd4;
	sel_nextpc = 4'b0001;
	#1 reset = 1;
	#10 reset = 0;
	#30 sel_nextpc = 4'b0010;
	#30 sel_nextpc = 4'b0100;
	#30 sel_nextpc = 4'b1000;
	$stop;
end

always #10 CLK = ~CLK;

endmodule