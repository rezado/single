//2021-6-1，吴佳宾
//通用寄存器堆写数据生成逻辑
`timescale 1ns/10ps
module GenRFRes(
	input [31:0] in0, //in0对应ALU计算结果alu_res
	input [31:0] in1, //in1对应从RAM读出的load操作返回值ld_res
	input sel_rf_res,  //选择信号 1选择DRAM输出 0对应ALU输出
	output [31:0] rf_res //数据输出
	);

assign rf_res = sel_rf_res ? in1 : in0;

endmodule