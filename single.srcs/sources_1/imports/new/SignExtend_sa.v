`timescale 1ns/10ps
//2021-6-15,吴佳宾
//SignExtend_sa
module SignExtend_sa(
	input  [4:0] extin, //符号扩展输入
	output [31:0] extout //符号扩展输出
	);
//符号扩展
assign extout = {{27{extin[4]}}, extin};

endmodule