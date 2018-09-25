`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:55:58
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(Daddr, DataIn, RD, WR, DataOut);
   input [31:0] Daddr;
   input [31:0] DataIn;
   input RD;
   input WR;
   output reg [31:0] DataOut;
   
    // 8位的数据存储器
    reg[7:0] memory[0:127];
    
    // read data  
    always @(RD or Daddr) begin  
        if (RD == 0) begin
            DataOut[31:24] = memory[Daddr];  
            DataOut[23:16] = memory[Daddr+1];  
            DataOut[15:8] = memory[Daddr+2];  
            DataOut[7:0] = memory[Daddr+3];
        end
    end
    
    // 初始化
    integer i;
    initial begin
        DataOut = 8'h00000000;
        for (i = 0; i < 128; i = i+1) memory[i] <= 0;
    end
    // write data
    always @(WR or Daddr or DataIn) begin
         if (WR == 0) begin
             memory[Daddr] = DataIn[31:24];
             memory[Daddr+1] = DataIn[23:16];
             memory[Daddr+2] = DataIn[15:8];
             memory[Daddr+3] = DataIn[7:0];
         end
     end
endmodule
