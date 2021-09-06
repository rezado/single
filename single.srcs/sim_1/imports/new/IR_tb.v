`timescale 1ns/10ps
//-------testbench of IR--------
module IR_tb();
reg inst_ram_en, inst_ram_wen;
reg [31:0] IR_addr;
wire [31:0] IR_out;

IR IR(
	.inst_ram_en(inst_ram_en),
	.inst_ram_wen(inst_ram_wen),
	.IR_addr(IR_addr),
	.IR_out(IR_out)
);

initial begin
	inst_ram_en = 1;
	inst_ram_wen = 1;
	IR_addr = 32'd0;
	#10 IR_addr = 32'd4;
	#10 IR_addr = 32'd8;
	#10 IR_addr = 32'd12;
	#10 IR_addr = 32'd16;
	#10 IR_addr = 32'd20;
	#10 IR_addr = 32'd24;
	$stop;
end

endmodule