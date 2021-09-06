//-------testbench of ALU--------
`timescale 1ns/10ps
module ALU_tb();
reg [11:0]alu_control;
reg [31:0]alu_src1, alu_src2;
wire [31:0]alu_result;
ALU ALU(
	.alu_control(alu_control),
	.alu_src1(alu_src1),
	.alu_src2(alu_src2),
	.alu_result(alu_result)
);

initial
begin
	alu_control = 12'd1;
	alu_src1 = 32'h3fffffff;
	alu_src2 = 32'd1;
	#130 $stop;
end

always #10 alu_control = alu_control << 1;

endmodule