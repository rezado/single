//--------testbench of nextPC----------
`timescale 1ns/10ps
module PCBranch_tb();
reg   [31:0] pcadd;
reg   [15:0] offset;
reg   [25:0] instr_index;
reg          beq_bne_jump;
wire  [31:0] beqpc;
wire  [31:0] jalpc;

PCBranch PCBranch(
	.pcadd(pcadd),
	.offset(offset),
	.beq_bne_jump(beq_bne_jump),
	.instr_index(instr_index),
	.beqpc(beqpc),
	.jalpc(jalpc)
);

initial begin
	pcadd = 32'hf000_0000;
	beq_bne_jump = 1'b1;
	offset = 16'd1;
	instr_index = 26'd2;
	#50 $stop;
end

always #10 pcadd = pcadd + 1;

endmodule