//2021-6-1，吴佳宾
//通用寄存器堆写地址生成逻辑
`timescale 1ns/10ps
module GenRFDst(
	input [5:0] in0, //rd
	input [5:0] in1, //rt
	input [5:0] in2, //32'd31
	input [2:0] sel_rf_dst,  //选择信号
	output [5:0] rf_dst //写地址
	);

assign rf_dst = ({5{sel_rf_dst[0]}} & in0) | ({5{sel_rf_dst[1]}} & in1) | ({5{sel_rf_dst[2]}} & in2);

endmodule