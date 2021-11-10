`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 09:09:52 PM
// Design Name: 
// Module Name: top_circuit
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


module top_circuit(clk, reset, pauza, secs_7z, secs_7u, mins_7z, mins_7u, hours_7z, hours_7u);
    input reset, clk, pauza;
    output [6:0] secs_7z, secs_7u, mins_7z, mins_7u, hours_7z, hours_7u;
    
    wire cout_sec, cout_min, cout_hour;
    wire [5:0] val_sec, val_min, val_hour;
    wire [3:0] BCD0, BCD1, BCD2, BCD3, BCD4, BCD5;
    
    numarator sec_counter(clk, reset, pauza, val_sec, cout_sec);
    numarator min_counter(cout_sec, reset, pauza, val_min, cout_min);
    numarator hour_counter(cout_min, reset, pauza, val_hour, cout_hour);
    
    bin2bcd sec_conv(val_sec, BCD0, BCD1);
    bin2bcd min_conv(val_min, BCD2, BCD3);
    bin2bcd hour_conv(val_hour, BCD4, BCD5);
    
    afisare_7seg secs_7_z(clk, reset, BCD0, secs_7z);
    afisare_7seg secs_7_u(clk, reset, BCD1, secs_7u);
    afisare_7seg mins_7_z(clk, reset, BCD2, mins_7z);
    afisare_7seg mins_7_u(clk, reset, BCD3, mins_7u);
    afisare_7seg hours_7_z(clk, reset, BCD4, hours_7z);
    afisare_7seg hours_7_u(clk, reset, BCD5, hours_7u);
    
endmodule