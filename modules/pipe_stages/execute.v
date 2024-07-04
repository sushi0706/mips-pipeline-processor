module execute(
	input clk,
	input reset,
	input mem_to_reg_wr,
	input reg_wr_en,
	input mem_wr_en,
	input alu_src_sel,
	input branch,
	input jump,
	input [2:0] alu_ctrl,
	input [4:0] reg_wr_addr,
	input [31:0] pc_branch,
	input [31:0] pc_jump,
	input [31:0] reg_rd_data1,
	input [31:0] reg_rd_data2,
	input [31:0] sign_imm_ext,
	output ex_pc_src,
	output ex_jump,
	output ex_mem_mem_to_reg_wr,
	output ex_mem_mem_wr_en,
	output ex_mem_reg_wr_en,
	output [4:0] ex_mem_reg_wr_addr,
	output [31:0] ex_pc_jump,
	output [31:0] ex_pc_branch,
	output [31:0] ex_mem_alu_result,
	output [31:0] ex_mem_mem_wr_data
);

	wire zero_flag;
	wire [31:0] alu_src_a;
	wire [31:0] alu_src_b;
	wire [31:0] alu_result;
	wire [31:0] mem_wr_data;
	
	assign alu_src_a = reg_rd_data1;
	assign mem_wr_data = reg_rd_data2;
	assign ex_pc_branch = pc_branch;
	assign ex_pc_jump = pc_jump;
	assign ex_jump = jump;
	assign ex_pc_src = branch & zero_flag;
	
	mux2 alu_src_b_mux_inst(
		.a(reg_rd_data2),
		.b(sign_imm_ext),
		.sel(alu_src_sel),
		.out(alu_src_b)
	);
	
	alu alu_inst(
		.a(alu_src_a),
		.b(alu_src_b),
		.alu_ctrl(alu_ctrl),
		.alu_out(alu_result),
		.zero_flag(zero_flag)
	);
	
	d_ff ex_mem_mem_wr_en_inst(
		.clk(clk),
		.reset(reset),
		.d(mem_wr_en),
		.q(ex_mem_mem_wr_en)
	); defparam ex_mem_mem_wr_en_inst.WIDTH=1;
	
	d_ff ex_mem_reg_wr_en_inst(
		.clk(clk),
		.reset(reset),
		.d(reg_wr_en),
		.q(ex_mem_reg_wr_en)
	); defparam ex_mem_reg_wr_en_inst.WIDTH=1;
	
	d_ff ex_mem_mem_to_reg_wr_inst(
		.clk(clk),
		.reset(reset),
		.d(mem_to_reg_wr),
		.q(ex_mem_mem_to_reg_wr)
	); defparam ex_mem_mem_to_reg_wr_inst.WIDTH=1;
	
	d_ff ex_mem_reg_wr_addr_inst(
		.clk(clk),
		.reset(reset),
		.d(reg_wr_addr),
		.q(ex_mem_reg_wr_addr)
	); defparam ex_mem_reg_wr_addr_inst.WIDTH=5;
	
	d_ff ex_mem_mem_wr_data_inst(
		.clk(clk),
		.reset(reset),
		.d(mem_wr_data),
		.q(ex_mem_mem_wr_data)
	);
	
	d_ff ex_mem_alu_result_inst(
		.clk(clk),
		.reset(reset),
		.d(alu_result),
		.q(ex_mem_alu_result)
	);
	
endmodule