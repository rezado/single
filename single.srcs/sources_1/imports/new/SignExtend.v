//2021-6-8,吴佳宾
//符号扩展
`timescale 1ns/10ps
module SignExtend(
	input [15:0] extin, //符号扩展输入
	output [31:0] extout //符号扩展输出
	);
//符号扩展
assign extout = {{16{extin[15]}}, extin};

endmodule