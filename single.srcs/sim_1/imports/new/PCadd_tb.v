//--------testbench of PCadd-------
`timescale 1ns/10ps
module PCadd_tb();
reg CLK;
reg reset;
reg [31:0] oldPC;
wire [31:0] newPC;
PCadd PCadd(
	.CLK(CLK),
	.reset(reset),
	.oldPC(oldPC),
	.newPC(newPC)
);
initial begin
	CLK = 1'b0;
	reset = 1'b0;
	oldPC = 32'h0000_0000;
	#32 reset = 1;
	#10 $stop;
end

always #10 CLK = ~CLK;

endmodule