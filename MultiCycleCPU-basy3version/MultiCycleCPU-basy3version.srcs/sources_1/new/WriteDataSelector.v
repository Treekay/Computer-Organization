`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 17:27:45
// Design Name: 
// Module Name: WriteDataSelector
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


module WriteDataSelector(WrRegDSrc, PC4, DMoutDR, WriteData);
    input WrRegDSrc; // 由该信号决定选择哪个输入的数据作为要写入寄存器的数据
    input [31:0] PC4, DMoutDR; // PC+4后的地址 和 来自数据存储器延迟模块的数据
    output wire [31:0] WriteData; // 输出的要写入寄存器的数据

    // 选择要写入寄存器的数据
    assign WriteData = WrRegDSrc ? DMoutDR : PC4;
endmodule
