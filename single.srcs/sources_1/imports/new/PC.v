//2021-5-23,吴佳宾
//PC
`timescale 1ns/10ps
module PC(
	input				CLK, //时钟信号
	input				reset, //是否复位
	input	[31:0]		PC_src, //PC+4得到的值
	output	reg	[31:0]	PC_out //当前指令的地址
);

always@(posedge CLK or posedge reset) begin
//	if(reset)	PC_out <=  32'hBFC00000; //复位值
	if(reset)   PC_out <= 32'd0; //方便测试
	else  	PC_out <= PC_src;
end

endmodule