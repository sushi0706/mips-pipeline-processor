module write_back(
	input reg_wr_en,
	input mem_to_reg_wr,
	input [31:0] alu_result,
	input [31:0] mem_rd_data,
	input [4:0] reg_wr_addr,
	output wb_reg_wr_en,
	output [4:0] wb_reg_wr_addr,
	output [31:0] wb_reg_wr_data
);
	
	mux2 reg_wr_data_mux_inst(
		.a(alu_result),
		.b(mem_rd_data),
		.sel(mem_to_reg_wr),
		.out(wb_reg_wr_data)
	);
	
	assign wb_reg_wr_addr = reg_wr_addr;
	assign wb_reg_wr_en = reg_wr_en;
	
endmodule