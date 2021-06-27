`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 12:16:26 PM
// Design Name: 
// Module Name: mux
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


module mux(input [3:0] a, b, c, d,
    input [1:0] s,
    output wire [3:0] y);
    
    assign y[3:0] = s[1] ? (s[0] ? d : c) : (s[0] ? b : a);
    
endmodule
