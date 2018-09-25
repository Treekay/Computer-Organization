`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/20 20:56:45
// Design Name: 
// Module Name: NextState
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


module NextState(inState, opcode, nextState);
    input [2:0] inState; // µ±Ç°×´Ì¬
    input [5:0] opcode; // Ö¸Áî²Ù×÷Âë
    output reg[2:0] nextState; // ÏÂÒ»¸ö×´Ì¬
    parameter [2:0] IF = 3'b000, // IF×´Ì¬
                     ID = 3'b001, // ID×´Ì¬
                     EXE = 3'b010, // EXE×´Ì¬
                     WB = 3'b011, // WB×´Ì¬
                     MEM = 3'b100; // MEM×´Ì¬
    always @(inState or opcode) begin
        case (inState)
            IF: nextState = ID;
            ID: begin
                case (opcode) 
                    6'b111000: // j
                        nextState = IF;
                    6'b111001: // jr
                        nextState = IF;
                    6'b111010: // jal
                        nextState = IF;
                    6'b111111: // halt
                        nextState = IF;
                    default:
                        nextState = EXE;
                endcase
            end
            EXE: begin
                case (opcode)
                    6'b110100:  // beq
                        nextState = IF;
                    6'b110110:  // bltz
                        nextState = IF;
                    6'b110000:  // sw
                        nextState = MEM;
                    6'b110001:  // lw
                        nextState = MEM;
                    default:
                        nextState = WB;
                endcase 
            end
            MEM: begin // sw -> IF , lw -> WB
                nextState = opcode == 6'b110000 ? IF : WB;
            end
            WB: begin
                nextState = IF;
            end
            default: nextState = IF;
        endcase
    end
endmodule
