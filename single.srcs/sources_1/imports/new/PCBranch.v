//2021-7-12,吴佳宾
//PCBranch
`timescale 1ns/10ps
module PCBranch(
	input       [31:0]   pcadd, //PC
	input       [15:0]   offset, //BEQ BNE
	input                beq_bne_jump, //beq bne的跳转信号
	input       [25:0]   instr_index, //JAL
	output      [31:0]   beqpc, //执行beq跳转的PC
	output      [31:0]   jalpc //执行jal跳转的PC
);
wire [31:0] signleft_offset; //offset符号扩展 左移两位
assign signleft_offset = {{14{offset[15]}}, offset, 2'b00};
assign beqpc = beq_bne_jump ?  pcadd+signleft_offset : pcadd + 4;
assign jalpc = {pcadd[31], pcadd[30], pcadd[29], pcadd[28], instr_index[23:0], 2'b00};

endmodule