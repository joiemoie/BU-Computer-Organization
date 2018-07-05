module Processor
  (input clk,
   input [31:0] instruction,
   output [31:0] readData1,
   output [31:0] readData2,
	output [4:0] read_sel_a);

   wire [31:0] ALUout;
	wire [31:0] ALUin2;
   wire [31:0] memOut;
	wire [3:0] ALUControl;
	wire  [4:0] read_sel_a, read_sel_b, write_sel;
   wire write, mem_read, mem_write, ALUsrc, mem_to_reg;
	wire zero;
	wire [31:0] signExtend;

	
	assign ALUin2 = readData2 & ALUsrc | signExtend & ~ALUsrc;
	assign write_data = memOut & mem_to_reg | ALUout & (~mem_to_reg);
	
	assign signExtend = {16'h0000, instruction[15:0]} & instruction[15]
	| {16'hFFFF, instruction[15:0]} & instruction[15];
   assign OPcode = instruction[31:26];

   RegFile regFile(clk, write, read_sel_a, read_sel_b, 
        write_sel, write_data, readData1, readData2);
  	Memory memory(clk, mem_read, mem_write, ALUout, readData2, memOut);

   ALU M2(clk, ALUcontrol, readData1, ALUin2, ALUout, zero);
	Control_Unit M4(clk, instruction, ALUControl, read_sel_a,
    read_sel_b, write_sel, write, mem_read, mem_write, ALUsrc, mem_to_reg);
	 
endmodule