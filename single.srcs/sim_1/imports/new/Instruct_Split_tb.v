`timescale 1ns/10ps
//--------testbench of Instruct_Split-----------
module Instruct_Split_tb();
reg [31:0] instruct;
wire [5:0] op;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] sa;
wire [15:0] imm;
wire [5:0] func;
Instruct_Split Instruct_Split(
	.instruct(instruct),
	.op(op),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.sa(sa),
	.imm(imm),
	.func(func)
);
initial begin
	instruct = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
end

endmodule