`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 12:27:28 PM
// Design Name: 
// Module Name: sim_mux
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


module sim_mux();

reg [3:0] a, b, c, d;
reg [1:0] s;
wire [3:0] y;

mux mux41(a, b, c, d, s, y);

initial begin
    #100 a = 1; b = 0; c = 1; d = 0; s[0] = 0; s[1] = 0;
    #100 a = 1; b = 0; c = 1; d = 0; s[1] = 0; s[0] = 1;
    #100 a = 1; b = 0; c = 1; d = 0; s[1] = 1; s[0] = 0;
    #100 a = 1; b = 0; c = 1; d = 0; s[1] = 1; s[0] = 1;
end
 
endmodule
