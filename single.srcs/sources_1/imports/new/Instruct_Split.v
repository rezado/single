//2021-7-11,吴佳宾
//指令分割
`timescale 1ns/10ps
module Instruct_Split(
	input   [31:0]     instruct, //指令
	output  [ 5:0]     op, //操作码
	output  [ 4:0]     rs, //rs域
	output  [ 4:0]     rt, //rt域
	output  [ 4:0]     rd, //rd域
	output  [ 4:0]     sa, //sa域
	output  [15:0]     imm, //imm立即数
	output  [ 5:0]     func, //ALU操作码
	output  [25:0]     instr_index //J-Type
	);

assign op = instruct[31:26];
assign rs = instruct[25:21];
assign rt = instruct[20:16];
assign rd = instruct[15:11];
assign sa = instruct[10: 6];
assign imm = instruct[15:0];
assign func = instruct[5:0];
assign instr_index = instruct[25:0];

endmodule