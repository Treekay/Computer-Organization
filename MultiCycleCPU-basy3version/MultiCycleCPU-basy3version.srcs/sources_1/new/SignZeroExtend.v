`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:59:10
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

    module SignZeroExtend(immediate, ExtSel, Extout);
        input [15:0] immediate; // 立即数
        input ExtSel; // 由该信号决定拓展的类型
        output wire [31:0] Extout; //  拓展后的立即数
        
        assign Extout[15:0] = immediate; // 原立即数有16位，低十六保持复位，高位进行拓展
        // ExtSel为1时进行符号位拓展，ExtSel为0时进行零拓展
        assign Extout[31:16] = ExtSel? (immediate[15]? 16'hffff : 16'h0000) : 16'h0000;
    endmodule
