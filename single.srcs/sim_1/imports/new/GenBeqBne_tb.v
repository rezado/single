//2021-7-24, Îâ¼Ñ±ö
//-------testbench of GenBeqBne---------
`timescale 1ns/10ps
module GenBeqBne_tb();
reg   [31:0] rdata1, rdata2;
reg   [ 2:0] sel_beqbne;
wire         beq_bne_jump;
GenBeqBne GenBeqBne(
	.rdata1(rdata1),
	.rdata2(rdata2),
	.sel_beqbne(sel_beqbne),
	.beq_bne_jump(beq_bne_jump)
);
initial begin
	rdata1 = 32'd1;
	rdata2 = 32'd1;
	sel_beqbne = 2'd1;
	#10 sel_beqbne = 2'd2;
	#10 $stop;
end

endmodule