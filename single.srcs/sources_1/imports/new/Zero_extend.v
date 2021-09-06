`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/21 10:56:58
// Design Name: 
// Module Name: Zero_extend
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


module Zero_extend(
    input   wire[15:0]  imm,
    output  wire[31:0]  zeroext
);

assign zeroext = {16'b0, imm};

endmodule
