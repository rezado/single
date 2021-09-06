//2021-7-11, 吴佳宾
//BEQBNE分支判断比较逻辑GenBeqBne
`timescale 1ns/10ps
module GenBeqBne(
	input    [31:0]    rdata1,
	input    [31:0]    rdata2,
	input    [ 1:0]    sel_beqbne, //sel[0]表示beq sel[1]表示bne
	output             beq_bne_jump //跳转信号 
);
wire equal;
assign equal = (rdata1 == rdata2);
assign beq_bne_jump = (sel_beqbne[0] && equal) || (sel_beqbne[1] && ~equal);

endmodule