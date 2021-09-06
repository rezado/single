//2021-5-24
//单周期CPU
//虚实地址转换部件
`timescale 1ns/10ps
module Addr_transform(
	input	 [31:0]	tran_in,
	output   [31:0]	tran_out
	);

assign tran_out = (tran_in[31:29] == 3'b100) ? {1'b0,tran_in[30:0]} :
				  (tran_in[31:29] == 3'b101) ? {3'b000,tran_in[26:0]} :
				  tran_in;

endmodule