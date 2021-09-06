`timescale 1ns/10ps
//2021-7-12 吴佳宾
//Single_CPU顶层测试文件
//----------testbench of top----------
module top_tb();
	reg             CLK; //时钟信号
	reg             reset; //复位信号
	//指令分割
	wire   [31:0]   instruct; //指令
	wire   [ 5:0]   op; //操作码
	wire   [ 4:0]   rs; //rs域
	wire   [ 4:0]   rt; //rt域
	wire   [ 4:0]   rd; //rd域
	wire   [ 4:0]   sa; //sa域
	wire   [15:0]   imm; //imm立即数
	wire   [ 5:0]   func; //ALU操作码
	wire   [25:0]   instr_index; //J-Type
	//PC
	wire   [31:0]   PC_src; //PC+4
	wire   [31:0]   PC_out; //当前指令
	//IR
	wire   [31:0]   IR_addr; //IR地址输入
	wire   [31:0]   IR_rdata; //IR读出数据
	//Control_Unit
	wire            inst_ram_en; //指令RAM片选
	wire            inst_ram_wen; //指令RAM读使能
	wire   [ 2:0]   sel_alu_src1; //ALU源操作数1
	wire   [ 3:0]   sel_alu_src2; //ALU源操作数2
	wire   [12:0]   alu_op; //ALU操作码
	wire            data_ram_en; //DataRam片选
	wire            data_ram_wen; //DataRam读使能
	wire            rf_we; //寄存器堆写使能
	wire   [ 2:0]   sel_rf_dst; //寄存器堆写地址生成逻辑
	wire            sel_rf_res; //寄存器堆读地址生成逻辑
	wire   [ 3:0]   sel_nextpc; //PC输入生成逻辑
	wire   [ 1:0]   sel_beqbne; //BEQ BNE选择信号
	//ALU
	wire   [31:0]   alu_result; //ALU运算结果
	wire   [31:0]   alu_src1; //ALU操作数1
	wire   [31:0]   alu_src2; //ALU操作数2
	//Signextend
	wire   [31:0]   imm_ext; //指令码imm扩展32位
	wire   [31:0]   sa_ext; //移位sa扩展32位
	//Zero_extend
	wire   [31:0]   imm_zeroext; //32位零扩展
	//RegFile
	wire   [ 4:0]   rf_waddr; //寄存器堆写地址
    wire   [ 4:0]   rf_raddr1; //regfile读地址1
    wire   [ 4:0]   rf_raddr2; //regfile读地址2
    wire   [31:0]   rf_wdata; //regfile写数据
    wire   [31:0]   rf_rdata1; //regfile读数据1
    wire   [31:0]   rf_rdata2; //regfile读数据2
    //DataRam
    wire   [31:0]   dr_addr; //DR读、写地址
	wire   [31:0]   dr_wdata; //DR写数据
	wire   [31:0]   dr_rdata; //DR读数据
	wire   [31:0]   dr_rdata_LTB; //DR小端转大端
	//跳转信号
	wire            beq_bne_jump;
top top(
	.CLK          (CLK          ),
	.reset        (reset        ),
	.instruct     (instruct     ),
	.op           (op           ),
	.rs           (rs           ),
	.rt           (rt           ),
	.rd           (rd           ),
	.sa           (sa           ),
	.imm          (imm          ),
	.func         (func         ),
	.instr_index  (instr_index  ),
	.PC_src       (PC_src       ),
	.PC_out       (PC_out       ),
	.IR_addr      (IR_addr      ),
	.IR_rdata     (IR_rdata     ),
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
	.sel_nextpc   (sel_nextpc   ),
	.sel_beqbne   (sel_beqbne   ),
	.alu_result   (alu_result   ),
	.alu_src1     (alu_src1     ),
	.alu_src2     (alu_src2     ),
	.imm_ext      (imm_ext      ),
	.sa_ext       (sa_ext       ),
	.imm_zeroext  (imm_zeroext  ),
	.rf_waddr     (rf_waddr     ),
	.rf_raddr1    (rf_raddr1    ),
	.rf_raddr2    (rf_raddr2    ),
	.rf_wdata     (rf_wdata     ),
	.rf_rdata1    (rf_rdata1    ),
	.rf_rdata2    (rf_rdata2    ),
	.dr_addr      (dr_addr      ),
	.dr_wdata     (dr_wdata     ),
	.dr_rdata     (dr_rdata     ),
	.dr_rdata_LTB (dr_rdata_LTB ),
	.beq_bne_jump (beq_bne_jump )
);

initial begin
	CLK = 0;
	reset = 1;
	#1 reset = 0;
end

always #10 CLK = ~CLK;

endmodule