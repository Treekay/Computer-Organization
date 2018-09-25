`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 22:02:09
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(clk, RegWre, RegDst, opCode, rs, rt, rd, immediate, DBDataSrc, dataFromALU, dataFromRW, Data1, Data2, writeData); 
     input clk, RegDst, RegWre, DBDataSrc;
     input [5:0] opCode;
     input [4:0] rs, rt, rd;
     input [10:0] immediate;
     input [31:0] dataFromALU, dataFromRW;  
     output [31:0] Data1, Data2;

     wire [4:0] writeReg;  // 要写的寄存器端口
     output wire [31:0] writeData;  // 要写的数据
     // RegDst为真时，处理R型指令，rd为目标操作数寄存器，为假时处理I型指令,详见控制信号作用表
     assign writeReg = RegDst? rd : rt;
     // ALUM2Reg为0时，使用来自ALU的输出，为1时，使用来自数据存储器(DM)的输出,详见控制信号作用表
     assign writeData = DBDataSrc? dataFromRW : dataFromALU;  // 实现数据选择器

     // 初始化寄存器
     reg [31:0] register[0:31];  
     integer i;  
     initial begin
        for (i = 0; i < 32; i = i+1) register[i] <= 0;  
     end  

     // output：随register变化而变化
     // Data1 为ALU运算时的A，当指令为sll时，A的值从立即数的16位中获得
     // Data2 位ALU运算中的B，其值始终是为rt
     assign Data1 = (opCode == 6'b011000) ? immediate[10:6] : register[rs];
     assign Data2 = register[rt];

     always @(posedge clk) begin  
         if (RegWre && writeReg) register[writeReg] = writeData;  // 防止数据写入0号寄存器(writeReg=0)
     end
endmodule
