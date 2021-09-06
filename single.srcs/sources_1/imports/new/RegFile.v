//2021-6-1，吴佳宾
//通用寄存器堆RegFile
`timescale 1ns/10ps
module RegFile(
	input         CLK, //时钟信号
	input         we, //写使能信号
	input  [ 4:0] waddr, //寄存器堆写地址
    input  [ 4:0] raddr1, //读地址1
    input  [ 4:0] raddr2, //读地址2
    input  [31:0] wdata, //写数据
    output [31:0] rdata1, //读数据1
    output [31:0] rdata2 //读数据2
	);

reg [31:0] reg_array[31:0]; //32个32位宽的数据
// //加载数据到存储器，必须使用绝对路径
// initial begin
// 	$readmemh("D:/Codes/Verilog/Single_CPU/rtl/RegFile.txt", reg_array);
// end
//Write
always@(posedge CLK) begin
	if(we) reg_array[waddr] <= wdata;
end
//Read out 1
assign rdata1 = (raddr1 == 5'b0) ? 32'b0 : reg_array[raddr1];
//Read out 2	
assign rdata2 = (raddr2 == 5'b0) ? 32'b0 : reg_array[raddr2];

endmodule