//ALU module
module alu #(parameter DATA_WIDTH=32)(
	input [DATA_WIDTH-1:0] a,b,	//operands
	input [2:0] alu_ctrl,
	output reg [DATA_WIDTH-1:0] alu_out,
	output zero_flag
);
	
	always@(*) begin
		case(alu_ctrl)
			3'b010: alu_out = a+b;
			3'b110: alu_out = a-b;
			3'b000: alu_out = a&b;
			3'b001: alu_out = a|b;
			3'b111: begin
				if (a[31]!=b[31]) alu_out = a[31]?0:1;
            		        else alu_out = a<b?1:0;
			end
			default: alu_out = 0;
		endcase
	end
	
	assign zero_flag = (alu_out==0);

endmodule 
