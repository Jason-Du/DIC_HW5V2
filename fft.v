`include "fft_stage1.v"
`include "fft_stage2.v"
`include "fft_stage3.v"
`include "fft_stage4.v"

module fft(
		clk,
		rst,
		fir_valid, // fir out fft in
		fir_d,// fir out fft in
		fft_valid, 
	//	done, 
	//	freq,
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
		
	input		  clk;
	input         rst;
	input         fir_valid; // fir out signed fft in
	input  signed [15:0] fir_d; // fir out signed fft in
	output reg      fft_valid; 
	//output        done; 
	//output        freq;
	output reg signed [31:0] fft_d1; 
	output reg signed [31:0] fft_d2; 
	output reg signed [31:0] fft_d3; 
	output reg signed [31:0] fft_d4; 
	output reg signed [31:0] fft_d5; 
	output reg signed [31:0] fft_d6; 
	output reg signed [31:0] fft_d7; 
	output reg signed [31:0] fft_d8;
	output reg signed [31:0] fft_d9;
	output reg signed [31:0] fft_d10; 
	output reg signed [31:0] fft_d11; 
	output reg signed [31:0] fft_d12; 
	output reg signed [31:0] fft_d13; 
	output reg signed [31:0] fft_d14; 
	output reg signed [31:0] fft_d15; 
	output reg signed [31:0] fft_d0;
	reg signed [31:0] stage0_register_out [15:0];	
	reg signed [31:0] stage1_register_out [15:0];
	reg signed [31:0] stage2_register_out [15:0];
	reg signed [31:0] stage3_register_out [15:0];
	reg signed [31:0] stage4_register_out [15:0];
	
	reg signed [31:0] stage0_register_in [15:0];	
	wire signed [31:0] stage1_register_in [15:0];
	wire signed [31:0] stage2_register_in [15:0];
	wire signed [31:0] stage3_register_in [15:0];
	wire signed [31:0] stage4_register_in [15:0];
	
	integer i;
	
	wire [9:0] FFT_C0_count;
	reg FFT_C0_keep;
	reg FFT_C0_clear;
	reg [1:0] CS;
	reg [1:0] NS;
	localparam IDLE       =2'b00;
	localparam FIRST_DATA =2'b01;
	localparam END        =2'b10;
    counter FFT_C0(
	.clk(clk),
	.rst(rst),
	.count(FFT_C0_count),
	.clear(FFT_C0_clear),
	.keep(FFT_C0_keep)
);
    fft_stage1 FFt_S1(
		.stage1_data0_in(stage0_register_in[15]),
		.stage1_data1_in(stage0_register_in[14]),
		.stage1_data2_in(stage0_register_in[13]),
		.stage1_data3_in(stage0_register_in[12]),
		.stage1_data4_in(stage0_register_in[11]),
		.stage1_data5_in(stage0_register_in[10]),
		.stage1_data6_in(stage0_register_in[9]),
		.stage1_data7_in(stage0_register_in[8]),
		.stage1_data8_in(stage0_register_in[7]),
		.stage1_data9_in(stage0_register_in[6]),
		.stage1_data10_in(stage0_register_in[5]),
		.stage1_data11_in(stage0_register_in[4]),
		.stage1_data12_in(stage0_register_in[3]),
		.stage1_data13_in(stage0_register_in[2]),
		.stage1_data14_in(stage0_register_in[1]),
		.stage1_data15_in(stage0_register_in[0]),

		.stage1_data0_out(stage1_register_in[0]),
		.stage1_data1_out(stage1_register_in[1]),
		.stage1_data2_out(stage1_register_in[2]),
		.stage1_data3_out(stage1_register_in[3]),
		.stage1_data4_out(stage1_register_in[4]),
		.stage1_data5_out(stage1_register_in[5]),
		.stage1_data6_out(stage1_register_in[6]),
		.stage1_data7_out(stage1_register_in[7]),
		.stage1_data8_out(stage1_register_in[8]),
		.stage1_data9_out(stage1_register_in[9]),
		.stage1_data10_out(stage1_register_in[10]),
		.stage1_data11_out(stage1_register_in[11]),
		.stage1_data12_out(stage1_register_in[12]),
		.stage1_data13_out(stage1_register_in[13]),
		.stage1_data14_out(stage1_register_in[14]),
		.stage1_data15_out(stage1_register_in[15])
);
    fft_stage2 FFt_S2(
		.stage2_data0_in(stage1_register_out[0]),
		.stage2_data1_in(stage1_register_out[1]),
		.stage2_data2_in(stage1_register_out[2]),
		.stage2_data3_in(stage1_register_out[3]),
		.stage2_data4_in(stage1_register_out[4]),
		.stage2_data5_in(stage1_register_out[5]),
		.stage2_data6_in(stage1_register_out[6]),
		.stage2_data7_in(stage1_register_out[7]),
		.stage2_data8_in(stage1_register_out[8]),
		.stage2_data9_in(stage1_register_out[9]),
		.stage2_data10_in(stage1_register_out[10]),
		.stage2_data11_in(stage1_register_out[11]),
		.stage2_data12_in(stage1_register_out[12]),
		.stage2_data13_in(stage1_register_out[13]),
		.stage2_data14_in(stage1_register_out[14]),
		.stage2_data15_in(stage1_register_out[15]),

		.stage2_data0_out(stage2_register_in[0]),
		.stage2_data1_out(stage2_register_in[1]),
		.stage2_data2_out(stage2_register_in[2]),
		.stage2_data3_out(stage2_register_in[3]),
		.stage2_data4_out(stage2_register_in[4]),
		.stage2_data5_out(stage2_register_in[5]),
		.stage2_data6_out(stage2_register_in[6]),
		.stage2_data7_out(stage2_register_in[7]),
		.stage2_data8_out(stage2_register_in[8]),
		.stage2_data9_out(stage2_register_in[9]),
		.stage2_data10_out(stage2_register_in[10]),
		.stage2_data11_out(stage2_register_in[11]),
		.stage2_data12_out(stage2_register_in[12]),
		.stage2_data13_out(stage2_register_in[13]),
		.stage2_data14_out(stage2_register_in[14]),
		.stage2_data15_out(stage2_register_in[15])
);
    fft_stage3 FFt_S3(
		.stage3_data0_in(stage2_register_out[0]),
		.stage3_data1_in(stage2_register_out[1]),
		.stage3_data2_in(stage2_register_out[2]),
		.stage3_data3_in(stage2_register_out[3]),
		.stage3_data4_in(stage2_register_out[4]),
		.stage3_data5_in(stage2_register_out[5]),
		.stage3_data6_in(stage2_register_out[6]),
		.stage3_data7_in(stage2_register_out[7]),
		.stage3_data8_in(stage2_register_out[8]),
		.stage3_data9_in(stage2_register_out[9]),
		.stage3_data10_in(stage2_register_out[10]),
		.stage3_data11_in(stage2_register_out[11]),
		.stage3_data12_in(stage2_register_out[12]),
		.stage3_data13_in(stage2_register_out[13]),
		.stage3_data14_in(stage2_register_out[14]),
		.stage3_data15_in(stage2_register_out[15]),

		.stage3_data0_out(stage3_register_in[0]),
		.stage3_data1_out(stage3_register_in[1]),
		.stage3_data2_out(stage3_register_in[2]),
		.stage3_data3_out(stage3_register_in[3]),
		.stage3_data4_out(stage3_register_in[4]),
		.stage3_data5_out(stage3_register_in[5]),
		.stage3_data6_out(stage3_register_in[6]),
		.stage3_data7_out(stage3_register_in[7]),
		.stage3_data8_out(stage3_register_in[8]),
		.stage3_data9_out(stage3_register_in[9]),
		.stage3_data10_out(stage3_register_in[10]),
		.stage3_data11_out(stage3_register_in[11]),
		.stage3_data12_out(stage3_register_in[12]),
		.stage3_data13_out(stage3_register_in[13]),
		.stage3_data14_out(stage3_register_in[14]),
		.stage3_data15_out(stage3_register_in[15])
);
    fft_stage4 FFt_S4(
		.stage4_data0_in(stage3_register_out[0]),
		.stage4_data1_in(stage3_register_out[1]),
		.stage4_data2_in(stage3_register_out[2]),
		.stage4_data3_in(stage3_register_out[3]),
		.stage4_data4_in(stage3_register_out[4]),
		.stage4_data5_in(stage3_register_out[5]),
		.stage4_data6_in(stage3_register_out[6]),
		.stage4_data7_in(stage3_register_out[7]),
		.stage4_data8_in(stage3_register_out[8]),
		.stage4_data9_in(stage3_register_out[9]),
		.stage4_data10_in(stage3_register_out[10]),
		.stage4_data11_in(stage3_register_out[11]),
		.stage4_data12_in(stage3_register_out[12]),
		.stage4_data13_in(stage3_register_out[13]),
		.stage4_data14_in(stage3_register_out[14]),
		.stage4_data15_in(stage3_register_out[15]),

		.stage4_data0_out(stage4_register_in[0]),
		.stage4_data1_out(stage4_register_in[1]),
		.stage4_data2_out(stage4_register_in[2]),
		.stage4_data3_out(stage4_register_in[3]),
		.stage4_data4_out(stage4_register_in[4]),
		.stage4_data5_out(stage4_register_in[5]),
		.stage4_data6_out(stage4_register_in[6]),
		.stage4_data7_out(stage4_register_in[7]),
		.stage4_data8_out(stage4_register_in[8]),
		.stage4_data9_out(stage4_register_in[9]),
		.stage4_data10_out(stage4_register_in[10]),
		.stage4_data11_out(stage4_register_in[11]),
		.stage4_data12_out(stage4_register_in[12]),
		.stage4_data13_out(stage4_register_in[13]),
		.stage4_data14_out(stage4_register_in[14]),
		.stage4_data15_out(stage4_register_in[15])
);

	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			CS<=2'b00;
			for(i=0;i<16;i=i+1)
			begin
				stage0_register_out[i]<=32'd0;
				stage1_register_out[i]<=32'd0;
				stage2_register_out[i]<=32'd0;
				stage3_register_out[i]<=32'd0;
				stage4_register_out[i]<=32'd0;
			end
		end
		else
		begin
			CS<=NS;
			for(i=0;i<16;i=i+1)
			begin
				stage0_register_out[i]<=stage0_register_in[i];
				stage1_register_out[i]<=stage1_register_in[i];
				stage2_register_out[i]<=stage2_register_in[i];
				stage3_register_out[i]<=stage3_register_in[i];
				stage4_register_out[i]<=stage4_register_in[i];
			end
			
		end
	end
	always@(*)
	begin
		stage0_register_in[0]={fir_d,16'd0};
		for(i=0;i<15;i=i+1)
		begin
			stage0_register_in[i+1]=stage0_register_out[i];
		end
		/////////////////////////////////////////////////////
		/*
		for(i=0;i<16;i=i+1)
		begin
			stage1_register_in[i]=stage0_register_in[i];
		end
		for(i=0;i<16;i=i+1)
		begin
			stage2_register_in[i]=stage1_register_out[i];
			stage3_register_in[i]=stage2_register_out[i];
			stage4_register_in[i]=stage3_register_out[i];
		end
		*/
		////////////////////////////////////////////////
		 fft_d0=stage4_register_out[0];
		 fft_d1=stage4_register_out[1]; 
		 fft_d2=stage4_register_out[2]; 
		 fft_d3=stage4_register_out[3]; 
		 fft_d4=stage4_register_out[4]; 
		 fft_d5=stage4_register_out[5]; 
		 fft_d6=stage4_register_out[6]; 
		 fft_d7=stage4_register_out[7]; 
		 fft_d8=stage4_register_out[8];
		 fft_d9=stage4_register_out[9];
		 fft_d10=stage4_register_out[10]; 
		 fft_d11=stage4_register_out[11]; 
		 fft_d12=stage4_register_out[12]; 
		 fft_d13=stage4_register_out[13]; 
		 fft_d14=stage4_register_out[14]; 
		 fft_d15=stage4_register_out[15]; 

	end
	always@(*)
	begin
		FFT_C0_keep=fir_valid?1'b0:1'b1;
		case(CS)
			IDLE:
			begin
				NS=fir_valid?FIRST_DATA:IDLE;
				FFT_C0_clear=fir_valid?1'b1:1'b0;
				fft_valid=1'b0;
			end
			FIRST_DATA:
			begin
				NS=(FFT_C0_count==10'd18)?END:FIRST_DATA;
				FFT_C0_clear=(FFT_C0_count==10'd18)?1'b1:1'b0;
				fft_valid=(FFT_C0_count==10'd18)?1'b1:1'b0;
			end
			END:
			begin
				NS=(FFT_C0_count==10'd1007)?IDLE:END;
				fft_valid=((FFT_C0_count[3:0]+4'd1)==4'b0000&&FFT_C0_count!=10'd0)?1'b1:1'b0;
				FFT_C0_clear=(FFT_C0_count==10'd1007)?1'b1:1'b0;
			end
			default:
			begin
				NS=IDLE;
				fft_valid=1'b0;
				FFT_C0_clear=1'b0;
			end
		endcase
		
	end
	endmodule 
	
	