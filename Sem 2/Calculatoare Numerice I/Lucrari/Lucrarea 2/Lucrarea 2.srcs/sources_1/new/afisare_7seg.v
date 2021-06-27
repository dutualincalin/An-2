`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 01:57:35 PM
// Design Name: 
// Module Name: afisare_7seg
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


module afisare_7seg(
    input clk_out_seg, reset,
    input [3:0] BCD,
    output reg [6:0] Seg);
    
    always @(*)
    begin
    
        if(reset)
            Seg = 7'b0000001;
        else
            if(clk_out_seg)
                case (BCD)
                    4'b0000 : Seg = 7'b0000001;
                    4'b0001 : Seg = 7'b1001111;
                    4'b0010 : Seg = 7'b0010010;
                    4'b0011 : Seg = 7'b0000110;
                    4'b0100 : Seg = 7'b1101100;
                    4'b0101 : Seg = 7'b0100100;
                    4'b0110 : Seg = 7'b0100000;
                    4'b0111 : Seg = 7'b0001111;
                    4'b1000 : Seg = 7'b0000000;
                    4'b1001 : Seg = 7'b0001100;
                endcase
    end
endmodule