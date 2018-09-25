`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/13 09:12:57
// Design Name: 
// Module Name: SignZeroExtend
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


module SignZeroExtend(
    input [15:0] immediate,
    input ExtSel,
    output [31:0] out
    );
    //assign out = {{16{immediate[15]}},immediate[15:0]};
    // 后16位存储立即数
    assign out[15:0] = immediate;
    // 前16位根据立即数符号进行补1或0的操作 
    assign out[31:16] = ExtSel? (immediate[15]? 16'hffff : 16'h0000) : 16'h0000;
endmodule
