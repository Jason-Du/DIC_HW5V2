module counter_4(
	clk,
	rst,
	count,
	clear,
	keep
);
	input               clk;
	input               rst;
	input               keep;
	input               clear;
	output reg        [3:0]   count;
	reg        [3:0]   count_in;
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		
		begin
			count<=4'd0;
		end
		else
		begin
			count<=count_in;
		end

	end
	always@(*)
	begin
		if(clear)
		begin
			count_in=4'd0;
		end
		else if(keep)
		begin
			count_in=count;
		end
		else
		begin
			count_in=count+4'd1;
		end
	end
endmodule