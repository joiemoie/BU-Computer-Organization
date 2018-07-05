module ALU
  (input clk,
   input [3:0] ALUcontrol,
   input [31:0] A,
   input [31:0] B,
   output reg [31:0] C,
	output zero);
   assign zero = 0;
   always @(posedge clk) begin
      case (ALUcontrol)
	4'b0000: C <= A & B;
	4'b0001: C <= A | B;
	4'b0010: C <= A + B;
	4'b0110: C <= A - B;
	4'b0111: C <= A < B;
	4'b1100: C <= ~(A|B);
	default: C <= 0;
      endcase
   end // always @ (posedge clk)
endmodule