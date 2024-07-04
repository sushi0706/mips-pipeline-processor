//register file for MIPS32 CPU
module reg_file #(parameter DATA_WIDTH=32)(
	input clk,
	input wr_en,
	input [4:0] rd_addr1, rd_addr2, wr_addr,
	input [DATA_WIDTH-1:0] wr_data,
	output [DATA_WIDTH-1:0] rd_data1, rd_data2
);
	
	//32 32-bit registers
	reg [DATA_WIDTH-1:0] reg_bank [0:31];
	integer i;
	
	//initialize registers
	initial begin
		for(i=0;i<32;i=i+1) reg_bank[i]=i;
	end
	
	//synchronous write logic
	always@(posedge clk) begin
		if(wr_en) reg_bank[wr_addr]<=wr_data;
	end
	
	//read logic
	assign rd_data1 = reg_bank[rd_addr1];
	assign rd_data2 = reg_bank[rd_addr2];
	
endmodule 