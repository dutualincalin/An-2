`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2021 10:37:35 PM
// Design Name: 
// Module Name: GUAT
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


module GUAT(c_in, UAT_g, UAT_p, GUAT_g, GUAT_p, carry_GUAT);
    input c_in;
    input[3:0] UAT_g, UAT_p;
    output GUAT_g, GUAT_p;
    output [3:0] carry_GUAT;
    
    assign GUAT_p = UAT_p[3] * UAT_p[2] * UAT_p[1] * UAT_p[0];
    assign GUAT_g = UAT_g[3] + UAT_p[3] * UAT_g[2] + UAT_p[3] * UAT_p[2] * UAT_g[1] + UAT_p[3] * UAT_p[2] * UAT_p[1] * UAT_g[0];
    
    assign carry_GUAT[0] = UAT_g + c_in * UAT_p;
    assign carry_GUAT[1] = UAT_g + carry_GUAT[0] * UAT_p;
    assign carry_GUAT[2] = UAT_g + carry_GUAT[1] * UAT_p;
    assign carry_GUAT[3] = UAT_g + carry_GUAT[2] * UAT_p;
endmodule
