`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/12 15:48:33
// Design Name: 
// Module Name: PC
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

module PC(clk, Reset, PCWre, PCSrc, immediate, Address);
    input clk, Reset, PCWre;
    input [1:0] PCSrc;
    input [31:0] immediate;
    output reg [31:0] Address;
    initial begin
        Address = 0;
    end
     // clock�����ص�����Reset�½��ص���ʱִ��
    always @(posedge clk) begin
        // Reset Ϊ0ʱ����PCΪ0
        if (Reset == 0) begin
            Address = 0;  
        end
        // PCWreΪ1ʱ,PC����ָ����һ��ָ��
        // PCWreΪ0ʱͣ����PC������
        else if (PCWre) begin
            if (PCSrc == 2) begin
                Address = immediate * 4;  // j ��תָ��
            end
            else if (PCSrc == 1) begin 
               Address = Address + 4 + immediate * 4;  // beq, bne ��תָ��
            end
            else begin
                Address = Address + 4;  // ��ת����һָ��
            end
        end
    end
endmodule  
