`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2021 10:43:11 PM
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


module TopLevel(c_in, a, b, GG, GP, c_out, sum);
    input c_in;
    input[15:0] a, b, sum;
    output GG, GP, c_out;
    
    wire[3:0] carry_GUAT;
    wire[3:0] UAT_G, UAT_P;
    wire[15:0] carry_UAT, p, g;
    
    sc instance_sc_0(a[0], b[0], c_in, g[0], p[0], sum[0]);
    sc instance_sc_1(a[1], b[1], carry_UAT[0], g[1], p[1], sum[1]);
    sc instance_sc_2(a[2], b[2], carry_UAT[1], g[2], p[2], sum[2]);
    sc instance_sc_3(a[3], b[3], carry_UAT[2], g[3], p[3], sum[3]);
    
    sc instance_sc_4(a[4], b[4], carry_GUAT[0], g[4], p[4], sum[4]);
    sc instance_sc_5(a[5], b[5], carry_UAT[4], g[5], p[5], sum[5]);
    sc instance_sc_6(a[6], b[6], carry_UAT[5], g[6], p[6], sum[6]);
    sc instance_sc_7(a[7], b[7], carry_UAT[6], g[7], p[7], sum[7]);
    
    sc instance_sc_8(a[8], b[8], carry_GUAT[1], g[8], p[8], sum[8]);
    sc instance_sc_9(a[9], b[9], carry_UAT[8], g[9], p[9], sum[9]);
    sc instance_sc_10(a[10], b[10], carry_UAT[9], g[10], p[10], sum[10]);
    sc instance_sc_11(a[11], b[11], carry_UAT[10], g[11], p[11], sum[11]);
    
    sc instance_sc_12(a[12], b[12], carry_GUAT[2], g[12], p[12], sum[12]);
    sc instance_sc_13(a[13], b[13], carry_UAT[12], g[13], p[13], sum[13]);
    sc instance_sc_14(a[14], b[14], carry_UAT[13], g[14], p[14], sum[14]);
    sc instance_sc_15(a[15], b[15], carry_UAT[14], g[15], p[15], sum[15]);
    
    UAT instance_uat_0(c_in, g[3:0], p[3:0], UAT_G[0], UAT_P[0], carry_UAT[3:0]);
    UAT instance_uat_1(carry_GUAT[0], g[7:4], p[7:4], UAT_G[1], UAT_P[1], carry_UAT[7:4]);
    UAT instance_uat_2(carry_GUAT[1], g[11:8], p[11:8], UAT_G[2], UAT_P[2], carry_UAT[11:8]);
    UAT instance_uat_3(carry_GUAT[2], g[15:12], p[15:12], UAT_G[3], UAT_P[3], carry_UAT[15:12]);
    
    GUAT instance_guat_0(c_in, UAT_G, UAT_P, GG, GP, carry_GUAT);
    
    assign c_out = carry_GUAT[3];
endmodule
