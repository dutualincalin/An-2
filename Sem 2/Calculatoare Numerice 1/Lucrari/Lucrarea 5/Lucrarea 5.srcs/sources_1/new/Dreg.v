`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2021 06:56:13 PM
// Design Name: 
// Module Name: Dreg
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


module Dreg(clk, reset, d, q);
    input clk, reset;
    input [4:0] d;
    output reg [4:0] q;
    
    always @(posedge clk, posedge reset)
        if(reset) q <= 4'b0;
        else q <= d;
endmodule
