`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 02:26:31 PM
// Design Name: 
// Module Name: Sumator
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


module Sumator(a, b, cin, s, cout);
    input a, b, cin;
    output reg s, cout;
    
//    assign s = a ^ b ^cin;
//    assign cout = (a | b) & cin | (a & b);
    
    always @(a, b, cin)
        {cout, s} = a + b + cin; 
endmodule
