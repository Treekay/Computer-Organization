`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 22:01:29
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


module InstructionMemory(
    input [31:0] pc,   
    output [5:0] op,   
    output [4:0] rs, rt, rd,  
    output [15:0] immediate,
    output [4:0] sa
    );
    // 指令存储器存储单元宽度使用8位
    reg [7:0] mem[0:127];
    reg [31:0] address;
    reg [31:0] instruction;
    initial begin
        // 从文件中读取指令
       $readmemb("C:/Users/admin/Desktop/CPU/MonoCycleCPU/instructions.txt", mem);
       instruction = 0; // 指令初始化
    end
    
    always @(pc) begin
        // pc的最后两位都为0，从第三位开始取
        address = pc[31:2] << 2;
        // 每次从文件读取一条32位的指令
        // 存到4个8位的存储器单元
        // 再合并为32位的指令
        instruction = (mem[address]<<24) + (mem[address+1]<<16) + (mem[address+2]<<8) + mem[address+3];
    end
    // output  
    assign op = instruction[31:26];  
    assign rs = instruction[25:21];  
    assign rt = instruction[20:16];  
    assign rd = instruction[15:11];  
    assign immediate = instruction[15:0];
    assign sa = instruction[10:6];
endmodule 
