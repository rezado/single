//2021-7-11, 吴佳宾
//PC输入生成逻辑GenNextPC
`timescale 1ns/10ps
module GenNextPC(
	input   [31:0]   in0, //PC + 4
	input   [31:0]   in1, //PC + offset
	input   [31:0]   in2, //PC link instr_index
	input   [31:0]   in3, //rdata1
	input   [ 3:0]   sel_nextpc, //控制信号 独热码
	output  [31:0]   PCsrc //确定的PC值
);

assign PCsrc = (sel_nextpc[0]) ? in0 :
	            (sel_nextpc[1]) ? in1 :
	            (sel_nextpc[2]) ? in2 :
	            (sel_nextpc[3]) ? in3 :
	            32'd0;

endmodule