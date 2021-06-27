`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2021 07:28:19 PM
// Design Name: 
// Module Name: TopLevel
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


module TopLevel(clk, reset, a, b, c, d, e, f);
    input wire clk, reset, a, b, c, d, e;
    output wire f;
    
    wire [4:0] q1, q2, q3, q4;
    wire sum, mul1, mul2, dif; 
    
    Dreg reg1(clk, reset, {a,b,c,d,e}, q1);
    inmultitor prod1(q1[4], q1[3], mul1);
    inmultitor prod2(q1[1], q1[0], mul2);
    
    Dreg reg2(clk, reset, {0,0,mul1,q1[2],mul2}, q2);
    sumator sum1(q2[2], q2[1], sum);
    
    Dreg reg3(clk, reset, {0,0,0,sum,q2[0]}, q3);
    diferentiator dif1(q3[1], q3[0], dif);
    
    Dreg reg4(clk, reset, {0,0,0,0,dif},q4);
    
    assign f = q4[0];
endmodule
