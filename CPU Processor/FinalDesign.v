`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:27:13 04/18/2017 
// Design Name: 
// Module Name:    FinalDesign 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FinalDesign(clk, button, switch, reset, AN, seven
    );
input clk, button, switch, reset;
output [3:0] AN; 
output [6:0] seven;
wire debouncer,clk_divider_M, clk_divider_K;
wire [15:0] counter;
reg [15:0] testCount;
wire [3:0] small_bin;
reg [3:0] test_bin;
wire counter_in;

clk_div_M M1(clk, clk_divider_M);
clk_div_K M4(clk, clk_divider_K);
Debouncer M2(button, clk, debouncer);
assign counter_in = (switch & clk_divider_M) | (!switch & debouncer);
SixteenBitCounter M3(counter_in, clk, reset, counter);
seven_alternate M5(clk_divider_K, reset, counter, small_bin, AN);
binary_to_7segment M6(small_bin, seven);

endmodule
