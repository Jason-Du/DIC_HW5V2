`include "counter_4.v"
module analyze(
		clk,
		rst,
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
		input clk;
		input rst;
		input fft_valid;
		input  [31:0]fft_d0;
		input  [31:0]fft_d1; 
		input  [31:0]fft_d2; 
		input  [31:0]fft_d3; 
		input  [31:0]fft_d4; 
		input  [31:0]fft_d5; 
		input  [31:0]fft_d6; 
		input  [31:0]fft_d7; 
		input  [31:0]fft_d8;
		input  [31:0]fft_d9;
		input  [31:0]fft_d10; 
		input  [31:0]fft_d11; 
		input  [31:0]fft_d12; 
		input  [31:0]fft_d13; 
		input  [31:0]fft_d14; 
		input  [31:0]fft_d15; 

		output reg [3:0] freq;
		output reg       done;
		
		reg  [31:0] local_reg_resigter_in [15:0];
		reg  [31:0] local_reg_resigter_out [15:0];
		reg signed [15:0] result_resigter_in;
		reg signed [15:0] result_resigter_out;
		reg        [ 3:0] freq_register_out;
		integer i ;
	
		wire [3:0] ANA_C0_count;
		reg ANA_C0_clear;
		reg ANA_C0_keep;
		reg [31:0] compare_V1;
		reg [31:0] compare_V2;
		reg signed [31:0] mult1_real;
		reg signed [31:0] mult1_img;
		reg signed [31:0] mult2_real;
		reg signed [31:0] mult2_img;
		reg signed [15:0] mult1_value;
		reg signed [15:0] mult2_value;
		
		reg CS;
		reg NS;
		localparam IDLE   =1'b0;
		localparam COMPARE=1'b1;
		
	counter_4 ANA_C0(
	.clk(clk),
	.rst(rst),
	.count(ANA_C0_count),
	.clear(ANA_C0_clear),
	.keep(ANA_C0_keep)
);
	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			CS<=2'b00;
			freq_register_out<=3'b00;
			for(i=0;i<16;i=i+1)
			begin
				local_reg_resigter_in[i]<=32'd0;
			end
			result_resigter_out<=16'd0;
		end
		else
		begin
			CS<=NS;
			freq_register_out<=freq;
			for(i=0;i<16;i=i+1)
			begin
				local_reg_resigter_out[i]<=local_reg_resigter_in[i];
			end
			result_resigter_out<=result_resigter_in;
		end
	end
	always@(*)
	begin
		case(CS)
			IDLE:
			begin
				NS=fft_valid?COMPARE:IDLE;
				done=1'b0;
				ANA_C0_clear=1'b1;
				compare_V1=fft_d0;
				compare_V2=fft_d1;
				freq=(mult1_value>mult2_value)?4'd0:4'd1;
				result_resigter_in=(mult1_value>mult2_value)?mult1_value:mult2_value;
				
				local_reg_resigter_in[0]=fft_d0;
				local_reg_resigter_in[1]=fft_d1;
				local_reg_resigter_in[2]=fft_d2;
				local_reg_resigter_in[3]=fft_d3;
				local_reg_resigter_in[4]=fft_d4;
				local_reg_resigter_in[5]=fft_d5;
				local_reg_resigter_in[6]=fft_d6;
				local_reg_resigter_in[7]=fft_d7;
				local_reg_resigter_in[8]=fft_d8;
				local_reg_resigter_in[9]=fft_d9;
				local_reg_resigter_in[10]=fft_d10;
				local_reg_resigter_in[11]=fft_d11;
				local_reg_resigter_in[12]=fft_d12;
				local_reg_resigter_in[13]=fft_d13;
				local_reg_resigter_in[14]=fft_d14;
				local_reg_resigter_in[15]=fft_d15;
			end
			COMPARE:
			begin
				NS=(ANA_C0_count==4'd14)?IDLE:COMPARE;
				done=(ANA_C0_count==10'd14)?1'b1:1'b0;
				ANA_C0_clear=(ANA_C0_count==10'd14)?1'b1:1'b0;
				compare_V1=local_reg_resigter_out[ANA_C0_count+4'd1];
				compare_V2=result_resigter_out;
				freq=(mult1_value>mult2_value)?ANA_C0_count+4'd1:freq_register_out;
				result_resigter_in=(mult1_value>mult2_value)?mult1_value:mult2_value;
				
				local_reg_resigter_in[0]=local_reg_resigter_out[15];
				for(i=0;i<14;i=i+1)
				begin
					local_reg_resigter_in[i+1]=local_reg_resigter_out[i];
				end
			end
		endcase
	end
	
	always@(*)
	begin
		mult1_real= $signed(compare_V1[31:16])*$signed(compare_V1[31:16]) ; 
		mult2_real= $signed(compare_V2[31:16])*$signed(compare_V2[31:16]) ;
		mult1_img= $signed(compare_V1[15:0])*$signed(compare_V1[15:0]) ;
		mult2_img= $signed(compare_V2[15:0])*$signed(compare_V2[15:0]) ;
		
		mult1_value=$signed (mult1_real[23:8])+$signed (mult1_img[23:8]);
		mult2_value=$signed (mult2_real[23:8])+$signed (mult2_img[23:8]);
		
	end
endmodule


