`timescale 1ns/10ps
//2021-6-15,��ѱ�
//SignExtend_sa
module SignExtend_sa(
	input  [4:0] extin, //������չ����
	output [31:0] extout //������չ���
	);
//������չ
assign extout = {{27{extin[4]}}, extin};

endmodule