//data memory for MIPS32 CPU
module data_mem #(parameter DATA_WIDTH=32, ADDR_WIDTH=32, MEM_SIZE=128)(
	input clk,
	input wr_en,
	input [ADDR_WIDTH-1:0] addr,
	input [DATA_WIDTH-1:0] wr_data,
	output [DATA_WIDTH-1:0] rd_data_mem
);
	
	//128 32-bit words or data
	reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];
	
	//read logic
	assign rd_data_mem = data_ram[addr];
	
	//synchronous write logic
	always@(posedge clk) begin
		if(wr_en) data_ram[addr] <= wr_data;
	end
	
endmodule 