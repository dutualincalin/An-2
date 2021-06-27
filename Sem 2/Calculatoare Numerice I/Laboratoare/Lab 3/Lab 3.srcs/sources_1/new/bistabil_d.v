`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2021 02:20:16 PM
// Design Name: 
// Module Name: bistabil_d
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

// Descriere functonare bistabil D
// Iesirea bistabilului va avea valoarea intrarii la fiecare aparitie de front pozitiv.
// In cazul in care semnalul RESET este activ, iesirea va avea valoarea 0.
// In cazul in care semnalul EN este activ, iesirea va avea valoarea intrearii.
// In caz contrar iesirea va avea valoarea anterioara.

module bistabil_d(date, clk, reset, en, qout);

    input [3:0]date;
    input clk, reset, en;
    output reg [3:0]qout;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            qout <= 0;
        else 
            if(en)
                qout <= date;
    end
endmodule
