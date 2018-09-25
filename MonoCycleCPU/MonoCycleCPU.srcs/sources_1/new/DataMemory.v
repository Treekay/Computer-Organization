`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 22:01:48
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


module DataMemory(
   input [31:0] Daddr,
   input [31:0] DataIn,
   input RD,
   input WR,
   output reg [31:0] DataOut
   );
    // 数据存储器存储单元宽度使用8位
    reg[7:0] memory[0:127];
    reg[31:0] address;
    
    // read data  
    always @(RD) begin  
        if (RD == 0) begin
            address = (Daddr << 2);
            // DataOut是32位的，将4个8位存储器恢复成32位存储器
            DataOut = (memory[address]<<24)+(memory[address+1]<<16)+(memory[address+2]<<8)+memory[address+3];
        end
    end
    
    // write data
    integer i;
    initial begin
        DataOut = 8'h00000000;
        for (i = 0; i < 128; i = i+1) memory[i] <= 0;
    end
    always @(WR or Daddr or DataIn) begin
         if (WR == 0) begin
             address = Daddr << 2;
             memory[address] = DataIn[31:24];
             memory[address+1] = DataIn[23:16];
             memory[address+2] = DataIn[15:8];
             memory[address+3] = DataIn[7:0];
         end
     end
endmodule
