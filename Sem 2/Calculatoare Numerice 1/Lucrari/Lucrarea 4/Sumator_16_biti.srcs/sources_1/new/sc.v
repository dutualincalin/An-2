`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2021 10:00:24 PM
// Design Name: 
// Module Name: sc
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


module sc(a, b, c_in, p, g, suma);
    input a, b, c_in;
    output wire p, g, suma;
    
    assign suma = a + b + c_in;
    assign p = a + b;
    assign g = a * b;
endmodule
