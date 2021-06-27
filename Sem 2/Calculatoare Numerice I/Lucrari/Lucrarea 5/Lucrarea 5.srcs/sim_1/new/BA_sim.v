`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2021 08:21:30 PM
// Design Name: 
// Module Name: BA_sim
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


module BA_sim();
    reg reset, clk;
    reg a, b, c, d, e;
    wire f;
    
    TopLevel BA1(clk, reset, a, b, c, d, e, f);
    
    initial begin
        #0 clk = 1; reset = 1;
        #20 reset = 0; a = 1; b = 0; c = 1; d = 0; e = 1; // 1 * 0 + 1 - (0 * 1) = 1
        #20 a = 0; b = 0; c = 0; d = 0; e = 0; // 0 * 0 + 0 - (0 * 0) = 0
        #20 a = 1; b = 1; c = 1; d = 1; e = 1; // 1 * 1 + 1 - (1 * 1) = 1
        #20 a = 1; b = 1; c = 0; d = 1; e = 1; // 1 * 1 + 0 - (1 * 1) = 0
    end
    
    always #10 clk = ~clk;
endmodule
