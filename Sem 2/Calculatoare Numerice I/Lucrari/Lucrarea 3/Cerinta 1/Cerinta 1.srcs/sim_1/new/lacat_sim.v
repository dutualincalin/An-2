`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2021 06:46:09 PM
// Design Name: 
// Module Name: lacat_sim
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


module lacat_sim();
    reg b0, b1, clk, rst;
    wire unlock;
    
    Lacat lacatel(clk, rst, b0, b1, unlock);
    
    initial begin
    #0 clk = 0; rst = 1; b0 = 0; b1 = 0;
    #30 rst = 0; b0 = 1;
    #20 b0 = 0; b1 = 1;
    #20 b0 = 1;
    #20 b0 = 0;
    #20 b1 = 1;
    #20 b1 = 0;
    #60 b1 = 1;
    end
    
    always #10 clk = ~clk;
endmodule
