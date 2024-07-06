//D flip-flop
module d_ff #(parameter WIDTH=32)(
	input clk,
	input reset,
	input en,    //active low enable
	input [WIDTH-1:0] d,
	output reg [WIDTH-1:0] q
);

	always@(posedge clk) begin
		if(reset) q<=0;
		else if(en) q<=q;
		else q<=d;
	end
	
endmodule