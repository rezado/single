//2021-7-18,吴佳宾
//PC+4
`timescale 1ns/10ps
module PCadd(
	input              [31:0]   oldPC, //当前指令地址
	output reg     [31:0]   newPC //下一条指令地址
	);

always @(*) begin
	newPC <= oldPC + 4;
end

endmodule