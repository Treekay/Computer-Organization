`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:57:57
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(nowPC, InsMemRW, instruction);
    input [31:0] nowPC; // 当前PC地址
    input InsMemRW; // 指令读写信号
    output reg [31:0] instruction; // 当前指令
    
    // 指令寄存器
    reg [7:0] InsMEM[0:127];
    initial begin
        // 从文件中的指令写到指令寄存器中
       $readmemb("C:/Users/admin/Desktop/MultiCycleCPU-basy3version/instructions.txt", InsMEM);
       instruction = 0; // 初始化输出的指令
    end
    
    always @(nowPC or InsMemRW) begin
        if (InsMemRW) begin // 大端存储，高位地址存低位数据，低位地址存高位数据，保持读写时一致即可
            instruction[31:24] = InsMEM[nowPC];
            instruction[23:16] = InsMEM[nowPC+1];
            instruction[15:8] = InsMEM[nowPC+2];
            instruction[7:0] = InsMEM[nowPC+3];
        end
    end
endmodule 
