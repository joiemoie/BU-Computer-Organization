module Memory
  (input clk,
   input memRead,
   input memWrite,
   input [31:0] address,
   input [31:0] writeData,
   output reg [31:0] readData);

   reg [31:0] mem[0:255];


   always @(posedge clk) begin
      if (memWrite)
	begin
	mem[address[7:0]] = writeData;
	end
      if (memRead)
        begin
        readData = mem[address[7:0]];
        end
   end // always @ (posedge clk)
endmodule