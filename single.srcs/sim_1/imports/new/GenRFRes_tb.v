`timescale 1ns/10ps
//------testbench of GenRFRes--------
module GenRFRes_tb();
reg [31:0] in0;
reg [31:0] in1;
reg sel_rf_res;
wire [31:0] rf_res;
GenRFRes GenRFRes(
	.in0(in0),
	.in1(in1),
	.sel_rf_res(sel_rf_res),
	.rf_res(rf_res)
);
initial begin
	in0 = 32'h0000_0001;
	in1 = 32'h0000_0002;
	sel_rf_res = 0;
	#10 sel_rf_res = 1;
	#10 $stop;
end
endmodule