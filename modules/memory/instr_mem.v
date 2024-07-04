//instruction memory for MIPS32 CPU
module instr_mem #(parameter DATA_WIDTH=32, ADDR_WIDTH=6, MEM_SIZE=64)(
   input [ADDR_WIDTH-1:0] instr_addr,
	output [DATA_WIDTH-1:0] instr
);
	
	//64 32-bit instructions
	reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];

	initial begin
		$readmemh("instr_dump.txt", instr_ram);
	end
	
	//word-aligned memory access
	assign instr = instr_ram[instr_addr];
	
endmodule 