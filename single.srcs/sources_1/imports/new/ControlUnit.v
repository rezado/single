//2021-7-12，吴佳宾
//指令译码
`timescale 1ns/10ps
module ControlUnit(
	input   [ 5:0]    op, //操作
	input   [ 4:0]    sa, //sa域
	input   [ 5:0]    func, //ALU操作码
	output            inst_ram_en, //指令RAM片选
	output            inst_ram_wen, //指令RAM读使能
	output  [ 2:0]    sel_alu_src1, //ALU源操作数1
	output  [ 3:0]    sel_alu_src2, //ALU源操作数2
	output  [12:0]    alu_op, //ALU操作码
	output            data_ram_en, //DataRam片选
	output            data_ram_wen, //DataRam写使能
	output            rf_we, //寄存器堆写使能
	output  [ 2:0]    sel_rf_dst, //寄存器堆写地址生成逻辑
	output            sel_rf_res, //寄存器堆读地址生成逻辑
	output  [ 3:0]    sel_nextpc, //pc输入生成逻辑
	output  [ 1:0]    sel_beqbne //选择BEQ BNE
);
/*
op对应指令
000000 ADDU ADD SUB SLT SLTU AND
001001 ADDIU
001010 SLTI
*/
wire inst_addu;
wire inst_addiu;
wire inst_subu;
wire inst_lw;
wire inst_sw;
wire inst_slt;
wire inst_sltu;
wire inst_sll;
wire inst_srl;
wire inst_sra;
wire inst_lui;
wire inst_and;
wire inst_or;
wire inst_ori;
wire inst_xor;
wire inst_nor;
wire inst_beq;
wire inst_bne;
wire inst_jal;
wire inst_jr;
wire inst_mul;
//指令译码
assign inst_addu = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100001);
assign inst_addiu = (op == 6'b001001);
assign inst_subu = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100011);
assign inst_slt = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b101010);
assign inst_sltu = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b101011);
assign inst_sll = (op == 6'b000000) && sa && (func == 6'b000000);
assign inst_srl = (op == 6'b000000) && sa && (func == 6'b000010);
assign inst_sra = (op == 6'b000000) && sa && (func == 6'b000011);
assign inst_lui = (op == 6'b001111);
assign inst_and = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100100);
assign inst_or = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100101);
assign inst_xor = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100110);
assign inst_nor = (op == 6'b000000) && (sa == 5'b00000) && (func == 6'b100111);
assign inst_lw = (op == 6'b100011);
assign inst_sw = (op == 6'b101011);
assign inst_beq = (op == 6'b000100);
assign inst_bne = (op == 6'b000101);
assign inst_jal = (op == 6'b000011);
assign inst_jr = (op == 6'b000000) && (func == 6'b001000);
assign inst_ori = (op == 6'b001101);
assign inst_mul = (op == 6'b011100) && (func == 6'b000010);
//控制信号生成
assign inst_ram_en = 1;
assign inst_ram_wen = 1;
assign sel_nextpc = {inst_jr,
					 inst_jal, inst_bne | inst_beq,
	                 inst_addu | inst_addiu | inst_subu | inst_lw | inst_sw | 
	                 inst_slt | inst_sltu | inst_sll | inst_srl | inst_sra | inst_lui | 
	                 inst_and | inst_or | inst_xor | inst_nor | inst_ori | inst_mul};
assign sel_alu_src1 = {inst_sll | inst_srl | inst_sra,
	                   inst_jal,
	                   inst_addu | inst_addiu | inst_subu | inst_lw | inst_sw |
					   inst_slt | inst_sltu | inst_and | inst_or | inst_xor | inst_ori  | inst_nor | inst_mul};
assign sel_alu_src2 = {inst_ori,
					   inst_jal,
                       inst_addiu | inst_lw | inst_sw | inst_lui,
					   inst_addu | inst_subu | inst_slt | inst_sltu | inst_sll | 
                       inst_srl | inst_sra | inst_and | inst_or | inst_xor | inst_nor | inst_mul};
assign data_ram_en = inst_lw | inst_sw;
assign data_ram_wen = inst_sw;
assign rf_we = inst_addu | inst_addiu | inst_subu | inst_lw | inst_sltu | inst_slt | inst_sll | inst_srl
             | inst_sra | inst_lui | inst_and | inst_or | inst_xor | inst_nor | inst_jal | inst_ori | inst_mul;
assign sel_rf_dst = {inst_jal,
                     inst_addiu | inst_lw | inst_lui | inst_ori,
					 inst_addu | inst_subu | inst_slt | inst_sltu | inst_sll 
                    | inst_srl | inst_sra | inst_and | inst_or | inst_xor | inst_nor | inst_mul};
assign sel_rf_res = inst_lw;
assign alu_op = {inst_mul, inst_lui, inst_sra, inst_srl, inst_sll, inst_xor, inst_or | inst_ori, inst_nor,
	             inst_and, inst_sltu, inst_slt, inst_subu, inst_addu | inst_addiu |
	             inst_lw | inst_sw | inst_jal};
assign sel_beqbne = {inst_bne, inst_beq};

endmodule