module analyze(
		done, 
		freq,
		fft_valid,
		fft_d1, 
		fft_d2, 
		fft_d3, 
		fft_d4, 
		fft_d5, 
		fft_d6, 
		fft_d7, 
		fft_d8,
		fft_d9,
		fft_d10, 
		fft_d11, 
		fft_d12, 
		fft_d13, 
		fft_d14, 
		fft_d15, 
		fft_d0
		);
		input fft_valid;
		input signed [31:0]fft_d1; 
		input signed [31:0]fft_d2; 
		input signed [31:0]fft_d3; 
		input signed [31:0]fft_d4; 
		input signed [31:0]fft_d5; 
		input signed [31:0]fft_d6; 
		input signed [31:0]fft_d7; 
		input signed [31:0]fft_d8;
		input signed [31:0]fft_d9;
		input signed [31:0]fft_d10; 
		input signed [31:0]fft_d11; 
		input signed [31:0]fft_d12; 
		input signed [31:0]fft_d13; 
		input signed [31:0]fft_d14; 
		input signed [31:0]fft_d15; 
		input signed [31:0]fft_d0;
		output [3:0] freq;
		output done;
		
		reg signed [31:0] local_reg_resigter_in [15:0];
		reg signed [31:0] local_reg_resigter_out [15:0];
		integer i ;
		
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			CS<=2'b00;
			for(i=0;i<16;i=i+1)
			begin
				local_reg_resigter_in[i]<=32'd0;
			end
		end
		else
		begin
			CS<=NS;
			for(i=0;i<16;i=i+1)
			begin
				local_reg_resigter_out[i]<=local_reg_resigter_in[i];
		end
	end
	always@(*)
		
		
		

endmodule		