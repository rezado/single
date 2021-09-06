`timescale 1ns/10ps
//2021-6-14,吴佳宾
//------testbench of ControlUnit-----
module ControlUnit_tb();
reg   [31:0] instruct;
wire  [ 5:0] op;
wire  [ 4:0] rs;
wire  [ 4:0] rt;
wire  [ 4:0] rd;
wire  [ 4:0] sa;
wire  [15:0] imm;
wire  [ 5:0] func;
wire         inst_ram_en; //指令RAM片选
wire         inst_ram_wen; //指令RAM读使能
wire  [ 2:0] sel_alu_src2; //ALU源操作数2
wire  [11:0] alu_op; //ALU操作码
wire         data_ram_en; //DataRam片选
wire         data_ram_wen; //DataRam读使能
wire         rf_we; //寄存器堆写使能
wire  [ 2:0] sel_rf_dst; //寄存器堆写地址生成逻辑
wire         sel_rf_res; //寄存器堆读地址生成逻辑
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
ControlUnit ControlUnit(
	.op(op),
	.sa(sa),
	.func(func),
	.inst_ram_en(inst_ram_en),
	.inst_ram_wen(inst_ram_wen),
	.sel_alu_src2(sel_alu_src2),
	.alu_op(alu_op),
	.data_ram_en(data_ram_en),
	.data_ram_wen(data_ram_wen),
	.rf_we(rf_we),
	.sel_rf_dst(sel_rf_dst),
	.sel_rf_res(sel_rf_res)
);
initial begin
	instruct = 32'b000000_00001_00010_00011_00000_100001;
	#10 $stop;
end

endmodule