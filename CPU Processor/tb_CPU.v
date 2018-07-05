`timescale 1ns / 1ns
/** @module : CPU
 *  @author : Albert Bitdiddle
 *  CPU Module Testbed 
 *  Adaptive and Secure Computing Systems (ASCS) Laboratory
 */


module tb_CPU (); 
reg clock;
reg [31:0] instruction;
wire [31:0] readData1, readData2;
wire [4:0] read_sel_a;

Processor cpu (
   clock,
   instruction,
   readData1,
   readData2,
	read_sel_a
);     

    // In phase I, we are not implementing the instruction memory. Therefore, we manually the instruction, the register
    // in the CPU.v It is implemented as a register right now, but you will eventually want to change it to a wire and 
    // drive it from instruction memory.

    // Clock generator
    always #1 clock = ~clock;

    initial begin
        clock = 0;

        // Right now the regfile is empty. You can manually set the values in the regfile with something like:
        // cpu.registerFile.memory[10] = 100;
        // This will allow you to test your ALU and register file before the processor is complete. 

		  cpu.regFile.memory[1] = 100;
		  cpu.regFile.memory[2] = 50;
		  cpu.regFile.memory[3] = 75;
		  cpu.regFile.memory[4] = 25;

        // After 10 nanoseconds, lets set the regfile_read_sel_1 to 1, regfile_read_sel_2 to 2, AND those values,
        // and write the result to register 3.
        #10 instruction = 32'b00000000011000010001000000000000; // AND regs 1 and 2, put result in 3 
        #10 instruction = 32'b00000000100000010001100000000001; // OR regs 1 and 3, put result in 4 
        #10 instruction = 32'b00000000101000010010000000000001; // ADD regs 1 and 4, put result in 5


        // If you set the values of those  registers 1 and 2 to something other than 0, you should see some result in
        // register 3.

     end
     
endmodule
