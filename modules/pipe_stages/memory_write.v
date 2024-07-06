module memory_write(
	input clk,
	input reset,
	input reg_wr_en,
	input mem_wr_en,
	input mem_to_reg_wr,
	input [4:0] reg_wr_addr,
	input [31:0] mem_wr_data,
	input [31:0] alu_result,
	output mem_wb_reg_wr_en,
	output mem_wb_mem_to_reg_wr,
	output mem_reg_wr_en,
	output mem_mem_to_reg_wr,
	output [4:0] mem_reg_wr_addr,
	output [4:0] mem_wb_reg_wr_addr,
	output [31:0] mem_wb_mem_rd_data,
	output [31:0] mem_alu_result,
	output [31:0] mem_wb_alu_result
);

	wire [31:0] mem_wr_addr;
	wire [31:0] mem_rd_data;
	
	assign mem_wr_addr = alu_result;
	assign mem_mem_to_reg_wr = mem_to_reg_wr;
	assign mem_reg_wr_en = reg_wr_en;
	assign mem_reg_wr_addr = reg_wr_addr;
	assign mem_alu_result = alu_result;
	
	data_mem data_mem_inst(
		.clk(clk),
		.wr_en(mem_wr_en),
		.addr(mem_wr_addr),
		.wr_data(mem_wr_data),
		.rd_data_mem(mem_rd_data)
	);
	
	d_ff mem_wb_mem_to_reg_wr_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(mem_to_reg_wr),
		.q(mem_wb_mem_to_reg_wr)
	); defparam mem_wb_mem_to_reg_wr_inst.WIDTH=1;
	
	d_ff mem_wb_reg_wr_en_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(reg_wr_en),
		.q(mem_wb_reg_wr_en)
	); defparam mem_wb_reg_wr_en_inst.WIDTH=1;
	
	d_ff mem_wb_reg_wr_addr_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(reg_wr_addr),
		.q(mem_wb_reg_wr_addr)
	); defparam mem_wb_reg_wr_addr_inst.WIDTH=5;
	
	d_ff mem_wb_alu_result_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(alu_result),
		.q(mem_wb_alu_result)
	);
	
	d_ff mem_wb_mem_rd_data_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(mem_rd_data),
		.q(mem_wb_mem_rd_data)
	);
	
endmodule