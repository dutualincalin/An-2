`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 01:56:12 PM
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd(
    input [5:0] valoare_bin,
    output [3:0]BCD0, BCD1
    );
    
    integer i;
    reg [7:0]bcd;
    
    always @(valoare_bin)
        begin
            bcd = 0;
            for(i = 0; i < 6; i = i + 1)
            begin
                bcd = {bcd[6:0], valoare_bin[5 - i]};
                
                if(i < 5 && bcd[3:0] > 4)
                    bcd[3:0] = bcd[3:0] + 3;
                
                if(i < 5 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                   
            end
        end
        
    assign BCD0 = bcd[7:4];
    assign BCD1 = bcd[3:0];
            
endmodule