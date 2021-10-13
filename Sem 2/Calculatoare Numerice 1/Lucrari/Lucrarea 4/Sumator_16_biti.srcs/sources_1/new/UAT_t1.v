`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2021 10:08:23 PM
// Design Name: 
// Module Name: UAT_t1
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


module UAT(c_in, g_in, p_in, UAT_g, UAT_p, carry_UAT);
    input c_in;
    input[3:0] g_in, p_in;
    output UAT_g, UAT_p;
    output [3:0] carry_UAT;
    
    assign UAT_p = p_in[3] * p_in[2] * p_in[1] * p_in[0];
    assign UAT_g = g_in[3] + p_in[3] * g_in[2] + p_in[3] * p_in[2] * g_in[1] + p_in[3] * p_in[2] * p_in[1] * g_in[0];
    
    assign carry_UAT[0] = g_in[0] + p_in[0] * c_in;
    assign carry_UAT[1] = g_in[1] + p_in[1] * carry_UAT[0];
    assign carry_UAT[2] = g_in[2] + p_in[2] * carry_UAT[1];
    assign carry_UAT[3] = g_in[3] + p_in[3] * carry_UAT[2];
endmodule
