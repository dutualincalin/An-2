`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2021 02:29:00 PM
// Design Name: 
// Module Name: sim_bistabil_d_sincron
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


module sim_bistabil_d_sincron();

    reg [3:0]date;
    reg clk, reset, en;
    wire [3:0]qout;
    
    bistabil_d instanta(date, clk, reset, en, qout);
    
    initial begin
        #0 clk=0; reset=0;
        #20 reset=1; date=3;
        #20 reset=0; date=3;
        #20 reset=0; date=5; en=1;
        #20 reset=0; date=7; en=1;
        #20 reset=0; date=9; en=1;
        #20 reset=1; date=9; en = 0;
    end
    
    always #20 clk = ~clk;
    
endmodule
