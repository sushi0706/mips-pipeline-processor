//shift left by 2
module shl_2 #(parameter WIDTH=32)(
	input [WIDTH-1:0] shl_in,
	output [WIDTH-1:0] shl_out
);

	assign shl_out = (shl_in<<2);
	
endmodule