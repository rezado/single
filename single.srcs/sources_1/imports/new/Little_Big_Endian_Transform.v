`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 吴佳宾
// 
// Create Date: 2021/07/21 15:58:30
// Design Name: 
// Module Name: Little_Big_Endian_Transform
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Little_Big_Endian_Transform(
    input   [31:0]  in,
    output  [31:0]  out
);

assign out[31:24] = in[ 7: 0];
assign out[23:16] = in[15: 8];
assign out[15: 8] = in[23:16];
assign out[ 7: 0] = in[31:24];

endmodule
