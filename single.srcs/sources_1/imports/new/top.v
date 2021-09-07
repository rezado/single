`timescale 1ns/10ps
//2021-7-12,吴佳宾
//SingleCPU顶层文件
module top(
	input             CLK, //时钟信号
	input             reset, //复位信号
	//指令分割
	output   [31:0]   instruct, //指令
	output   [ 5:0]   op, //操作码
	output   [ 4:0]   rs, //rs域
	output   [ 4:0]   rt, //rt域
	output   [ 4:0]   rd, //rd域
	output   [ 4:0]   sa, //sa域
	output   [15:0]   imm, //imm立即数
	output   [ 5:0]   func, //ALU操作码
	output   [25:0]   instr_index, //J-Type
	//PC
	output   [31:0]   PC_src, //PC+4
	output   [31:0]   PC_out, //当前指令
	//IR
	output   [31:0]   IR_addr, //IR地址输入
	output   [31:0]   IR_rdata, //IR读出数据
	//Control_Unit
	output            inst_ram_en, //指令RAM片选
	output            inst_ram_wen, //指令RAM读使能
	output   [ 2:0]   sel_alu_src1, //ALU源操作数1
	output   [ 3:0]   sel_alu_src2, //ALU源操作数2
	output   [12:0]   alu_op, //ALU操作码
	output            data_ram_en, //DataRam片选
	output            data_ram_wen, //DataRam读使能
	output            rf_we, //寄存器堆写使能
	output   [ 2:0]   sel_rf_dst, //寄存器堆写地址生成逻辑
	output            sel_rf_res, //寄存器堆读地址生成逻辑
	output   [ 4:0]   sel_nextpc, //PC输入生成逻辑
	//ALU
	output	 [31:0]   alu_result, //ALU运算结果
	output   [31:0]   alu_src1, //ALU操作数1
	output   [31:0]   alu_src2, //ALU操作数2
	output            zero, //零标志位
	//Signextend
	output   [31:0]   imm_ext, //指令码imm扩展32位
	output   [31:0]   sa_ext, //移位sa扩展32位
	//Zero_extend
	output   [31:0]   imm_zeroext, //32位零扩展
	//RegFile
	output   [ 4:0]   rf_waddr, //寄存器堆写地址
    output   [ 4:0]   rf_raddr1, //regfile读地址1
    output   [ 4:0]   rf_raddr2, //regfile读地址2
    output   [31:0]   rf_wdata, //regfile写数据
    output   [31:0]   rf_rdata1, //regfile读数据1
    output   [31:0]   rf_rdata2, //regfile读数据2
    //DataRam
    output   [31:0]   dr_addr, //DR读、写地址
	output   [31:0]   dr_wdata, //DR写数据
	output   [31:0]   dr_rdata, //DR读数据
	output   [31:0]   dr_rdata_LTB //DR小端转大端
);
//PC跳转方式用
wire  [31:0] nextpc, beqpc, bnepc, jalpc;

assign rf_raddr1 = rs;
assign rf_raddr2 = rt;
PC PC(
	.CLK(CLK),
	.reset(reset),
	.PC_src(PC_src),
	.PC_out(PC_out)
);
PCadd PCadd(
	.oldPC(PC_out),
	.newPC(nextpc)
);
PCBranch PCBranch(
	.pcadd       (nextpc      ),
	.offset      (imm         ),
	.zero        (zero        ),
	.instr_index (instr_index ),
	.beqpc       (beqpc       ),
	.bnepc       (bnepc       ),
	.jalpc       (jalpc       )
);

GenNextPC GenNextPC(
	.in0(nextpc),
	.in1(beqpc),
	.in2(bnepc),
	.in3(jalpc),
	.in4(rf_rdata1),
	.sel_nextpc(sel_nextpc),
	.PCsrc(PC_src)
);
Addr_transform Addr_transform_1(
	.tran_in(PC_out),
	.tran_out(IR_addr)
);
//block Ram
IR IR (
  .clka(CLK),    // input wire clka
  .wea(4'b0),      // input wire [3 : 0] wea
  .addra(IR_addr >> 2),  // input wire [15 : 0] addra
  .dina(32'd0),    // input wire [31 : 0] dina
  .douta(IR_rdata)  // output wire [31 : 0] douta
);
Little_Big_Endian_Transform IR_LTB(
	.in  (IR_rdata),
	.out (instruct)
);

// IR IR (
//   .clka(CLK),    // input wire clka
//   .wea(2'b0),      // input wire [1 : 0] wea
//   .addra(IR_addr),  // input wire [15 : 0] addra
//   .dina(dina),    // input wire [15 : 0] dina
//   .douta(douta)  // output wire [15 : 0] douta
// );
Instruct_Split Instruct_Split(
	.instruct(instruct),
	.op(op),
	.rs(rs),
	.rt(rt),
	.rd(rd),
	.sa(sa),
	.imm(imm),
	.func(func),
	.instr_index(instr_index)
);
ControlUnit ControlUnit(
	.op           (op           ),
	.sa           (sa           ),
	.func         (func         ),
	.inst_ram_en  (inst_ram_en  ),
	.inst_ram_wen (inst_ram_wen ),
	.sel_alu_src1 (sel_alu_src1 ),
	.sel_alu_src2 (sel_alu_src2 ),
	.alu_op       (alu_op       ),
	.data_ram_en  (data_ram_en  ),
	.data_ram_wen (data_ram_wen ),
	.rf_we        (rf_we        ),
	.sel_rf_dst   (sel_rf_dst   ),
	.sel_rf_res   (sel_rf_res   ),
	.sel_nextpc   (sel_nextpc   )
);

Addr_transform Addr_transform_2(
	.tran_in(alu_result),
	.tran_out(dr_addr)
);
// DR DR(
// 	.CLK(CLK),
// 	.en(data_ram_en),
// 	.we(data_ram_wen),
// 	.addr(dr_addr),
// 	.wdata(dr_wdata),
// 	.rdata(dr_rdata)
// );
//block Ram
Little_Big_Endian_Transform DR_BTL(
	.in  (rf_rdata2),
	.out (dr_wdata)
);
Little_Big_Endian_Transform DR_LTB(
	.in  (dr_rdata),
	.out (dr_rdata_LTB)
);
DR DR (
  .clka(CLK),    // input wire clka
  .ena(data_ram_en),      // input wire ena
  .wea({4{data_ram_wen}}),      // input wire [3 : 0] wea
  .addra(dr_addr >> 2),  // input wire [15 : 0] addra
  .dina(dr_wdata),    // input wire [31 : 0] dina
  .douta(dr_rdata)  // output wire [31 : 0] douta
);
GenRFDst GenRFDst(
	.in0(rd),
	.in1(rt),
	.in2(32'd31),
	.sel_rf_dst(sel_rf_dst),
	.rf_dst(rf_waddr)
);
GenRFRes GenRFRes(
	.in0(alu_result),
	.in1(dr_rdata_LTB),
	.sel_rf_res(sel_rf_res),
	.rf_res(rf_wdata)
);
SignExtend SignExtend(
	.extin(imm),
	.extout(imm_ext)
);
Zero_extend Zero_extend(
    .imm(imm),
    .zeroext(imm_zeroext)
);
SignExtend_sa SignExtend_sa(
	.extin(sa),
	.extout(sa_ext)
);
GenALUSrc1 GenALUSrc1(
	.in0(rf_rdata1),
	.in1(PC_out),
	.in2(sa_ext),
	.sel_alu_src1(sel_alu_src1),
	.alu_src1(alu_src1)
);
GenALUSrc2 GenALUSrc2(
	.in0(rf_rdata2),
	.in1(imm_ext),
	.in2(32'd8),
	.in3(imm_zeroext),
	.sel_alu_src2(sel_alu_src2),
	.alu_src2(alu_src2)
);
ALU ALU(
	.alu_control(alu_op),
	.alu_src1(alu_src1),
	.alu_src2(alu_src2),
	.alu_result(alu_result),
	.zero(zero)
);
RegFile RegFile(
	.CLK(CLK),
	.we(rf_we),
	.waddr(rf_waddr),
	.raddr1(rf_raddr1),
	.raddr2(rf_raddr2),
	.wdata(rf_wdata),
	.rdata1(rf_rdata1),
	.rdata2(rf_rdata2)
);

endmodule