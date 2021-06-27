`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 11:55:52 PM
// Design Name: 
// Module Name: part_circuit
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


module part_circuit(clk, reset, pauza, valoare_bin1, valoare_bin2, valoare_bin3, BCD0, BCD1, BCD2, BCD3, BCD4, BCD5);
    input clk, reset, pauza;
    wire cout_sec, cout_min, cout_hour;
    output [5:0] valoare_bin1, valoare_bin2, valoare_bin3;
    output [3:0]BCD0, BCD1, BCD2, BCD3, BCD4, BCD5;
    
    numarator sec(clk, reset, pauza, valoare_bin1, cout_sec);
    numarator min(cout_sec, reset, pauza, valoare_bin2, cout_min);
    numarator hour(cout_min, reset, pauza, valoare_bin3, cout_hour);
    
    bin2bcd secs(valoare_bin1, BCD0, BCD1);
    bin2bcd mins(valoare_bin2, BCD2, BCD3);
    bin2bcd hours(valoare_bin3, BCD4, BCD5);
endmodule
