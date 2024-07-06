module execute(
	input clk,
	input reset,
	input mem_to_reg_wr,
	input reg_wr_en,
	input mem_wr_en,
	input alu_src_sel,
	input [1:0] forwardA_ex,
	input [1:0] forwardB_ex,
	input [4:0] id_ex_rs,
	input [4:0] id_ex_rt,
	input [2:0] alu_ctrl,
	input [4:0] reg_wr_addr,
	input [31:0] mem_alu_result,
	input [31:0] wb_reg_wr_data,
	input [31:0] reg_data1,
	input [31:0] reg_data2,
	input [31:0] sign_imm_ext,
	output ex_mem_mem_to_reg_wr,
	output ex_mem_mem_wr_en,
	output ex_mem_reg_wr_en,
	output ex_mem_to_reg_wr,
	output ex_reg_wr_en,
	output [31:0] ex_mem_wr_data,
	output [4:0] ex_reg_wr_addr,
	output [4:0] ex_mem_reg_wr_addr,
	output [4:0] ex_rs,
	output [4:0] ex_rt,
	output [31:0] ex_mem_alu_result,
	output [31:0] ex_mem_mem_wr_data
);

	wire zero_flag;
	wire [31:0] alu_src_a;
	wire [31:0] alu_src_b;
	wire [31:0] alu_result;
	wire [31:0] data1;
	wire [31:0] data2;
	
	assign alu_src_a = data1;
	assign ex_mem_wr_data = data2;
	assign ex_rs = id_ex_rs;
	assign ex_rt = id_ex_rt;
	assign ex_reg_wr_en = reg_wr_en;
	assign ex_mem_to_reg_wr = mem_to_reg_wr;
	assign ex_reg_wr_addr = reg_wr_addr;
	
	mux3 data1_mux_inst(
		.a(reg_data1),
		.b(wb_reg_wr_data),
		.c(mem_alu_result),
		.sel(forwardA_ex),
		.out(data1)
	);
	
	mux3 data2_mux_inst(
		.a(reg_data2),
		.b(wb_reg_wr_data),
		.c(mem_alu_result),
		.sel(forwardB_ex),
		.out(data2)
	);
	
	mux2 alu_src_b_mux_inst(
		.a(data2),
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
		.en(1'b0),
		.d(mem_wr_en),
		.q(ex_mem_mem_wr_en)
	); defparam ex_mem_mem_wr_en_inst.WIDTH=1;
	
	d_ff ex_mem_reg_wr_en_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(reg_wr_en),
		.q(ex_mem_reg_wr_en)
	); defparam ex_mem_reg_wr_en_inst.WIDTH=1;
	
	d_ff ex_mem_mem_to_reg_wr_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(mem_to_reg_wr),
		.q(ex_mem_mem_to_reg_wr)
	); defparam ex_mem_mem_to_reg_wr_inst.WIDTH=1;
	
	d_ff ex_mem_reg_wr_addr_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(reg_wr_addr),
		.q(ex_mem_reg_wr_addr)
	); defparam ex_mem_reg_wr_addr_inst.WIDTH=5;
	
	d_ff ex_mem_mem_wr_data_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(ex_mem_wr_data),
		.q(ex_mem_mem_wr_data)
	);
	
	d_ff ex_mem_alu_result_inst(
		.clk(clk),
		.reset(reset),
		.en(1'b0),
		.d(alu_result),
		.q(ex_mem_alu_result)
	);
	
endmodule