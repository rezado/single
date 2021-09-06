//2021-6-8,吴佳宾
//ALU源操作数输入alu_src2生成逻辑
module GenALUSrc2(
	input [31:0] in0, //对应寄存器堆读端口2数据读出
	input [31:0] in1, //对应指令码的imm域符号扩展至32位
	input [31:0] in2, //对应常值32'd8
	input [31:0] in3, //对应指令码的imm域零扩展至32位
	input [3:0]  sel_alu_src2, //选择信号
	output [31:0] alu_src2 //alu_src2
	);

assign alu_src2 = (sel_alu_src2[0]) ? in0 :
	              (sel_alu_src2[1]) ? in1 :
	              (sel_alu_src2[2]) ? in2 :
				  (sel_alu_src2[3]) ? in3 :
	               32'd0;

endmodule