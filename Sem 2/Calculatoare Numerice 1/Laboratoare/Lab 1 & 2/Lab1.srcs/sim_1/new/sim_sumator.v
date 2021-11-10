`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 02:39:16 PM
// Design Name: 
// Module Name: sim_sumator
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


module sim_sumator();

reg a, b, cin;

// instantiem
Sumator instanta(a, b, cin, s, cout);

initial begin
    #10 a = 0; b = 0; cin = 0;// la 10
    #10 a = 0; b = 0; cin = 1;// la 20
    #10 a = 1; b = 1; cin = 0;// la 30
    #10 a = 1; b = 1; cin = 1;// la 40
end

endmodule
