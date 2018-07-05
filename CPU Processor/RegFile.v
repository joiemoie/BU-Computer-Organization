module RegFile
  (input clk,
   input write,
   input [4:0] readReg1,
	input [4:0] readReg2,
	input [4:0] writeReg,
	input [31:0] writeData,
	output reg [31:0] readData1,
	output reg [31:0] readData2);

	reg [31:0] memory[0:31];


   always @(posedge clk) begin
      if (write)
	begin
	memory[writeReg] = writeData;
	end
      readData1 = memory[readReg1];
      readData2 = memory[readReg2];
   end // always @ (posedge clk)
endmodule