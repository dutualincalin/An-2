`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2021 12:01:23 AM
// Design Name: 
// Module Name: sim_part_circuit
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


module sim_part_circuit();
    reg reset, clk, pauza;
    wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4, BCD5;
    wire [5:0] valoare_bin1, valoare_bin2, valoare_bin3;
    
    part_circuit bucata(clk, reset, pauza, valoare_bin1, valoare_bin2, valoare_bin3, BCD0, BCD1, BCD2, BCD3, BCD4, BCD5);
    
    initial begin
        #0 clk = 0; reset = 0; pauza = 0;
        #10 reset = 1; pauza = 0;
        #10 reset = 0; pauza = 0;
    end
    
    always #5 clk = ~clk;
endmodule
