//2021-6-8,��ѱ�
//������չ
`timescale 1ns/10ps
module SignExtend(
	input [15:0] extin, //������չ����
	output [31:0] extout //������չ���
	);
//������չ
assign extout = {{16{extin[15]}}, extin};

endmodule