`timescale 1ns/1ns
module tb;

	reg clk;
	reg reset;
	
	mips_pipeline dut(
		.clk(clk),
		.reset(reset)
	);
	
	initial begin
		clk=0;
		reset=1;
		#22;
		reset=0;
	end
	
	always begin
		#5;
		clk = ~clk;
	end
	
endmodule