`timescale 1ns/10ps
//2021-6-15,吴佳宾
//ALUsrc1生成逻辑
module GenALUSrc1(
	input    [31:0]    in0, //rf_rdata1
	input    [31:0]    in1, //PC
	input    [31:0]    in2, //signext(sa)
	input    [ 2:0]    sel_alu_src1, //选择信号
	output   [31:0]    alu_src1 //ALU源操作数1
);

assign alu_src1 = sel_alu_src1[0] ? in0 :
                  sel_alu_src1[1] ? in1 :
                  sel_alu_src1[2] ? in2 :
                  32'd0;

endmodule