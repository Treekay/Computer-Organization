`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 19:57:11
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


module PC(clk, RST, PCWre, nextPC, nowPC);
    input clk;
    input RST;
    input PCWre;
    input [31:0] nextPC;
    output reg [31:0] nowPC;
    
    always @(posedge clk) begin
        if (RST == 0) begin     //  ��RSTΪ0ʱ����ǰPC��ַ����Ϊ0
            nowPC <= 0;
        end
        else begin      //  ֻ�е�PCWreΪ1ʱ�Ž���PCд����������ʱ�򲻶Ե�ǰPC�����޸�
            nowPC <= PCWre ? nextPC : nowPC;
        end
    end
endmodule
