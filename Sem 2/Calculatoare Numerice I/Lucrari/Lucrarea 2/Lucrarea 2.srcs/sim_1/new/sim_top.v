`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 09:18:08 PM
// Design Name: 
// Module Name: sim_top
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


module sim_top();
    reg reset, clk, pauza;
    wire [6:0] secs_7z, secs_7u, mins_7z, mins_7u, hours_7z, hours_7u;
    
    top_circuit top_level(clk, reset, pauza, secs_7z, secs_7u, mins_7z, mins_7u, hours_7z, hours_7u);
    
    initial begin
        #0 clk = 0; reset = 0; pauza = 0;
        #10 reset = 1; pauza = 0;
        #10 reset = 0; pauza = 0;
    end
    
    always #10 clk = ~clk;
endmodule