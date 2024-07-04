module instr_decode(
	input clk,
	input reset,
	input [31:0] instr,
	input [31:0] pc_plus_4,
	input [31:0] reg_wr_data,
	input [4:0] reg_wr_addr,
	input reg_wr_en,
	output id_ex_jump,
	output id_ex_mem_to_reg_wr,
	output id_ex_mem_wr_en,
	output id_ex_alu_src_sel,
	output id_ex_reg_wr_en,
	output id_ex_branch,
	output [2:0] id_ex_alu_ctrl,
	output [4:0] id_ex_reg_wr_addr,
	output [31:0] id_ex_reg_rd_data1,
	output [31:0] id_ex_reg_rd_data2,
	output [31:0] id_ex_sign_imm_ext,
	output [31:0] id_ex_pc_branch,
	output [31:0] id_ex_pc_jump
);
	
	wire mem_to_reg_wr;
	wire mem_wr_en;
	wire alu_src_sel;
	wire reg_file_dst_sel;
	wire reg_wr_en_temp;
	wire branch;
	wire jump;
	wire [2:0] alu_ctrl;
	wire [31:0] shl_jump_addr;
	wire [4:0] reg_wr_addr_temp;
	wire [31:0] sign_imm_ext;
	wire [31:0] sign_imm_ext_shl;
	wire [31:0] reg_rd_data1;
	wire [31:0] reg_rd_data2;
	wire [31:0] pc_jump;
	wire [31:0] pc_branch;
	
	assign pc_jump = {pc_plus_4[31:28], shl_jump_addr};
	
	control_unit control_unit_inst(
		.funct(instr[5:0]),
		.opcode(instr[31:26]),
		.mem_to_reg_wr(mem_to_reg_wr),
		.branch(branch),
		.mem_wr_en(mem_wr_en),
		.jump(jump),
		.alu_src_sel(alu_src_sel),
		.reg_file_dst_sel(reg_file_dst_sel),
		.reg_wr_en(reg_wr_en_temp),
		.alu_ctrl(alu_ctrl)
	);
		
	reg_file reg_file_inst(
		.clk(clk),
		.wr_en(reg_wr_en),
		.rd_addr1(instr[25:21]),
		.rd_addr2(instr[20:16]),
		.wr_data(reg_wr_data),
		.wr_addr(reg_wr_addr),
		.rd_data1(reg_rd_data1),
		.rd_data2(reg_rd_data2)
	);
	
	sign_ext sign_imm_ext_inst(
		.a(instr[15:0]),
		.y(sign_imm_ext)
	);
	
	shl_2 sign_imm_ext_shl_inst(
		.shl_in(sign_imm_ext),
		.shl_out(sign_imm_ext_shl)
	);
	
	adder pc_branch_inst(
		.a(pc_plus_4),
		.b(sign_imm_ext_shl),
		.sum(pc_branch)
	);
	
	shl_2 jump_trgt_addr_shl_inst(
		.shl_in(instr[25:0]),
		.shl_out(shl_jump_addr)
	); defparam jump_trgt_addr_shl_inst.WIDTH=28;
	
	mux2 reg_file_dst_mux_inst(
		.a(instr[20:16]),
		.b(instr[15:11]),
		.sel(reg_file_dst_sel),
		.out(reg_wr_addr_temp)
	);
	
	d_ff id_ex_mem_wr_en_inst(
		.clk(clk),
		.reset(reset),
		.d(mem_wr_en),
		.q(id_ex_mem_wr_en)
	); defparam id_ex_mem_wr_en_inst.WIDTH=1;
	
	d_ff id_ex_mem_to_reg_wr_inst(
		.clk(clk),
		.reset(reset),
		.d(mem_to_reg_wr),
		.q(id_ex_mem_to_reg_wr)
	); defparam id_ex_mem_to_reg_wr_inst.WIDTH=1;
	
	d_ff id_ex_reg_wr_en_inst(
		.clk(clk),
		.reset(reset),
		.d(reg_wr_en_temp),
		.q(id_ex_reg_wr_en)
	); defparam id_ex_reg_wr_en_inst.WIDTH=1;
	
	d_ff id_ex_alu_src_sel_inst(
		.clk(clk),
		.reset(reset),
		.d(alu_src_sel),
		.q(id_ex_alu_src_sel)
	); defparam id_ex_alu_src_sel_inst.WIDTH=1;
	
	d_ff id_ex_jump_inst(
		.clk(clk),
		.reset(reset),
		.d(jump),
		.q(id_ex_jump)
	); defparam id_ex_jump_inst.WIDTH=1;
	
	d_ff id_ex_branch_inst(
		.clk(clk),
		.reset(reset),
		.d(branch),
		.q(id_ex_branch)
	); defparam id_ex_branch_inst.WIDTH=1;
	
	d_ff id_ex_alu_ctrl_inst(
		.clk(clk),
		.reset(reset),
		.d(alu_ctrl),
		.q(id_ex_alu_ctrl)
	); defparam id_ex_alu_ctrl_inst.WIDTH=3;
	
	d_ff id_ex_reg_wr_addr_inst(
		.clk(clk),
		.reset(reset),
		.d(reg_wr_addr_temp),
		.q(id_ex_reg_wr_addr)
	); defparam id_ex_reg_wr_addr_inst.WIDTH=6;
	
	d_ff id_ex_reg_rd_data1_inst(
		.clk(clk),
		.reset(reset),
		.d(reg_rd_data1),
		.q(id_ex_reg_rd_data1)
	);
	
	d_ff id_ex_reg_rd_data2_inst(
		.clk(clk),
		.reset(reset),
		.d(reg_rd_data2),
		.q(id_ex_reg_rd_data2)
	);
	
	d_ff id_ex_sign_imm_ext_inst(
		.clk(clk),
		.reset(reset),
		.d(sign_imm_ext),
		.q(id_ex_sign_imm_ext)
	);
	
	d_ff id_ex_pc_branch_inst(
		.clk(clk),
		.reset(reset),
		.d(pc_branch),
		.q(id_ex_pc_branch)
	);
	
	d_ff id_ex_pc_jump_inst(
		.clk(clk),
		.reset(reset),
		.d(pc_jump),
		.q(id_ex_pc_jump)
	);
	
endmodule