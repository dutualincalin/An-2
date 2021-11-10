`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2021 12:45:54 PM
// Design Name: 
// Module Name: CLA_sim
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


module CLA_sim();
    reg[15:0] a, b;
    reg c_in;
    wire GG, GP, c_out;
    wire[15:0] sum;
    TopLevel CLA(c_in, a, b, GG, GP, c_out, sum);
    
    initial begin
    #0 a = 0; b = 1; c_in = 1;
    #50 a = 1; b = 1;
    #50 a = 3000; b = 2000; c_in = 1;
    #50 c_in = 0;
    end
endmodule
