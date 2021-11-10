`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2021 06:25:22 PM
// Design Name: 
// Module Name: Lacat
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


module Lacat(clk, rst, b0, b1, unlock);
    input clk, rst, b0, b1;
    output wire unlock;
    reg[2:0] cs, ns;
    
    localparam s_reset = 0, 
    s_0 = 1,
    s_01 = 2,
    s_010 = 3,
    s_0101 = 4,
    s_01011 = 5;
    
    always @(posedge clk)
        cs <= ns;
        
    always @(*) begin
        if(rst)
            ns = s_reset;
        else
            case(cs)
                s_reset : ns = b0 ? s_0 : b1 ? s_reset : cs;
                s_0 : ns = b0 ? s_0 : b1 ? s_01 : cs;
                s_01 : ns = b0 ? s_010 : b1 ? s_reset : cs;
                s_010 : ns = b0 ? s_0 : b1 ? s_0101 : cs;
                s_0101 : ns = b0 ? s_010 : b1 ? s_01011 : cs;
                s_01011 : ns = b0 ? s_0 : b1 ? s_reset : cs;
                default : ns = s_reset;
             endcase
    end
    assign unlock = ( cs == s_01011);
endmodule
