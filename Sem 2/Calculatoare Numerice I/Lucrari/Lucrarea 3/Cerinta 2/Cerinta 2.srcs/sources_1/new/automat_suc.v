`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 06:47:57 PM
// Design Name: 
// Module Name: automat_suc
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
//          5         suc + rest 1
//  s_reset -> s_add5 ---------> s_rest -> s_reset
//     |                                     ^
//     |   10        suc + rest 6            |
//     \----> s_add10 -----------> s_rest---/
//////////////////////////////////////////////////////////////////////////////////


module automat_suc(clk, reset, add_5, add_10, suc, rest_6, rest_1);
    input clk, reset, add_5, add_10;
    output wire suc, rest_6, rest_1;
    
    reg [1:0] currentstate;
    reg [1:0] nextstate;
    
    localparam 
    s_reset = 0,
    s_add5 = 1,
    s_rest = 2,
    s_add10 = 3;
    
    always @(posedge clk)
        currentstate <= nextstate;
    
    always @(clk, reset)
    begin
        
        if(reset)
        begin
            nextstate = s_reset;
        end
        
        else
            case(currentstate)
                s_reset: nextstate = add_5 ? s_add5 : add_10 ? s_add10 : currentstate;
                s_add5 : nextstate = s_rest;
                s_rest : nextstate = s_reset;
                s_add10: nextstate = s_rest;
                default: nextstate = s_reset; 
            endcase
        end
        
        assign suc = (currentstate == s_add10) || (currentstate == s_add5);
        assign rest_6 = (currentstate == s_add10);
        assign rest_1 = (currentstate == s_add5);
endmodule

    