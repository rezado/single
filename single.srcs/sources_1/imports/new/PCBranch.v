//2021-7-12,吴佳宾
//PCBranch
`timescale 1ns/10ps
module PCBranch(
	input       [31:0]   pcadd, //PC
	input       [15:0]   offset, //BEQ BNE
	input                zero, //ALU零标志位
	input       [25:0]   instr_index, //JAL
	output      [31:0]   beqpc, //执行beq跳转的PC
	output      [31:0]   bnepc, //执行bne跳转的PC
	output      [31:0]   jalpc //执行jal跳转的PC
);
wire [31:0] signleft_offset; //offset符号扩展 左移两位
assign signleft_offset = {{14{offset[15]}}, offset, 2'b00};
assign beqpc = zero ?  pcadd-4+signleft_offset : pcadd;
assign bnepc = zero ? pcadd : pcadd-4+signleft_offset;
assign jalpc = {pcadd[31], pcadd[30], pcadd[29], pcadd[28], instr_index[23:0], 2'b00};

endmodule