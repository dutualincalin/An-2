`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 09:56:49 PM
// Design Name: 
// Module Name: sim_automat_suc
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


module sim_automat_suc();
    reg clk, reset, add_5, add_10;
    wire suc, rest_6, rest_1;
    
    automat_suc auto(clk, reset, add_5, add_10, suc, rest_6, rest_1);
    
    initial begin
        #10 clk = 1; reset = 1;
        #10 reset = 0; add_5 = 1; add_10 = 0;
        #10 add_5 = 0;
        #60 add_10 = 1;
        #10 add_10 = 0;
    end
    
    always #10 clk = ~clk;
endmodule
