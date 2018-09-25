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
        input [15:0] immediate; // ������
        input ExtSel; // �ɸ��źž�����չ������
        output wire [31:0] Extout; //  ��չ���������
        
        assign Extout[15:0] = immediate; // ԭ��������16λ����ʮ�����ָ�λ����λ������չ
        // ExtSelΪ1ʱ���з���λ��չ��ExtSelΪ0ʱ��������չ
        assign Extout[31:16] = ExtSel? (immediate[15]? 16'hffff : 16'h0000) : 16'h0000;
    endmodule
