`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 19:42:51
// Design Name: 
// Module Name: IR
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


module IR(clk, IRWre, instruction, ins_out, op, rs, rt, rd, immediate, sa, addr);
    input clk; // 时钟信号
    input IRWre; // IR写指令信号
    input [31:0] instruction; // 当前指令
    output reg [31:0] ins_out; // 延迟输出的指令
    output wire [5:0] op; // 指令操作码
    output wire [4:0] rs, rt, rd; // 各操作数寄存器
    output wire [15:0] immediate; // 立即数
    output wire [10:6] sa; // 位移量
    output wire [25:0] addr; // 地址（跳转字节地址)
    
    // 时钟脉冲下降沿触发，延迟，目的是使指令代码保持稳定
    always @(negedge clk) begin
        if (IRWre) begin
            ins_out = instruction;        
        end
    end
    
   assign op = instruction[31:26];  
   assign rs = instruction[25:21];  
   assign rt = instruction[20:16];  
   assign rd = instruction[15:11];  
   assign immediate = instruction[15:0];
   assign sa = instruction[10:6];
   assign addr = instruction[25:0];
endmodule
