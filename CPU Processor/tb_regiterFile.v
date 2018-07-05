`timescale 1ns / 1ns
/** @module : registerFile
 *  @author : Albert Bitdiddle
 *  Register File Testbed 
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */


module tb_registerFile (); 

reg clock; 
reg [4:0] read1_sel, read2_sel, write_sel; 
reg write; 
reg [31:0] write_data; 
wire [31:0] read_data1, read_data2; 

RegFile DUT (
        clock, write, 
        read1_sel, read2_sel,
		  write_sel, write_data, 
        read_data1, read_data2
);     

// Clock generator
always #1 clock = ~clock;

initial begin
  clock = 0;
  write = 0;
  $display (" --- Start --- ");
  repeat (1) @ (posedge clock);
  
  write_data <= 32'h0000_0000_0000_0002;
  write_sel  <= 5'b00001;  
  write      <= 1'b1;
  repeat (1) @ (posedge clock);
  
  write_data <= 32'h0000_0000_0000_0005;
  write_sel  <= 5'b00011;  
  write      <= 1'b1;
  repeat (1) @ (posedge clock);
  
  write_data <= 32'h0000_0000_0000_0009;
  write_sel  <= 5'b00111;  
  write      <= 1'b1;
  repeat (1) @ (posedge clock);
  
  write_data <= 32'h0000_0000_0000_0007;
  write_sel  <= 5'b00000;  
  write      <= 1'b1;
  repeat (1) @ (posedge clock);
  
  write_data <= 32'h0000_0000_0000_000A;
  write_sel  <= 5'b00101;  
  write      <= 1'b1;
  read1_sel  <= 5'b00101; 
  repeat (1) @ (posedge clock);

  write_data <= 32'h0000_0000_0000_000A;
  write_sel  <= 5'b00101;  
  write      <= 1'b0;
  read1_sel  <= 5'b00101; 
  repeat (1) @ (posedge clock);
 
  write_data <= 32'h0000_0000_0000_000A;
  write_sel  <= 5'b00101;  
  write      <= 1'b0;
  read1_sel  <= 5'b00101; 
  read2_sel  <= 5'b00101; 
  repeat (1) @ (posedge clock);
 
  read1_sel  <= 5'b00111; 
  read2_sel  <= 5'b00111; 
  repeat (1) @ (posedge clock);
  
  read1_sel  <= 5'b00011; 
  read2_sel  <= 5'b00001; 
  repeat (1) @ (posedge clock);
 
  read1_sel  <= 5'b00000; 
  read2_sel  <= 5'b00001; 
  repeat (1) @ (posedge clock);          
end
  
  
always @ (posedge clock) begin 
    	$display ("Read1 Sel [%d], Read1 Data [%h]",read1_sel, read_data1); 
    	$display ("Read2 Sel [%d], Read2 Data [%h]",read2_sel, read_data2); 
end

endmodule
