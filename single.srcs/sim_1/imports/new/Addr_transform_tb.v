`timescale 1ns / 1ps
//-------testbench of Addr_tansform--------
module Addr_transform_tb();
reg [31:0] tran_in;
wire [31:0] tran_out;

Addr_transform Addr_transform(
	.tran_in(tran_in),
	.tran_out(tran_out)
	);

initial begin
	tran_in = 32'h0000_0001;
	#10 tran_in = 32'h8000_0000;
	#10 tran_in = 32'hA000_0000;
	#10 tran_in = 32'hC000_0000;
	#10 tran_in = 32'hE000_0000;
	#10 $stop;
end

endmodule