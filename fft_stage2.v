module fft_stage2(
		stage2_data0_in,
		stage2_data1_in,
		stage2_data2_in,
		stage2_data3_in,
		stage2_data4_in,
		stage2_data5_in,
		stage2_data6_in,
		stage2_data7_in,
		stage2_data8_in,
		stage2_data9_in,
		stage2_data10_in,
		stage2_data11_in,
		stage2_data12_in,
		stage2_data13_in,
		stage2_data14_in,
		stage2_data15_in,

		stage2_data0_out,
		stage2_data1_out,
		stage2_data2_out,
		stage2_data3_out,
		stage2_data4_out,
		stage2_data5_out,
		stage2_data6_out,
		stage2_data7_out,
		stage2_data8_out,
		stage2_data9_out,
		stage2_data10_out,
		stage2_data11_out,
		stage2_data12_out,
		stage2_data13_out,
		stage2_data14_out,
		stage2_data15_out
);

	input  [31:0] stage2_data1_in;
	input  [31:0] stage2_data2_in;
	input  [31:0] stage2_data3_in;
	input  [31:0] stage2_data4_in;
	input  [31:0] stage2_data5_in;
	input  [31:0] stage2_data6_in;
	input  [31:0] stage2_data7_in;
	input  [31:0] stage2_data8_in;
	input  [31:0] stage2_data9_in;
	input  [31:0] stage2_data10_in;
	input  [31:0] stage2_data11_in;
	input  [31:0] stage2_data12_in;
	input  [31:0] stage2_data13_in;
	input  [31:0] stage2_data14_in;
	input  [31:0] stage2_data15_in;
	input  [31:0] stage2_data0_in;
	
	
	
	output reg  [31:0] stage2_data0_out;
	output reg  [31:0] stage2_data1_out;
	output reg  [31:0] stage2_data2_out;
	output reg  [31:0] stage2_data3_out;
	output reg  [31:0] stage2_data4_out;
	output reg  [31:0] stage2_data5_out;
	output reg  [31:0] stage2_data6_out;
	output reg  [31:0] stage2_data7_out;
	output reg  [31:0] stage2_data8_out;
	output reg  [31:0] stage2_data9_out;
	output reg  [31:0] stage2_data10_out;
	output reg  [31:0] stage2_data11_out;
	output reg  [31:0] stage2_data12_out;
	output reg  [31:0] stage2_data13_out;
	output reg  [31:0] stage2_data14_out;
	output reg  [31:0] stage2_data15_out;
	
	reg signed [15:0] stage2_data0_out_real;
	reg signed [15:0] stage2_data1_out_real;
	reg signed [15:0] stage2_data2_out_real;
	reg signed [15:0] stage2_data3_out_real;
	
	reg signed [15:0] stage2_data4_out_real;
	reg signed [47:0] stage2_data5_out_real;
	reg signed [15:0] stage2_data6_out_real;
	reg signed [47:0] stage2_data7_out_real;
	
	reg signed [15:0] stage2_data8_out_real;
	reg signed [15:0] stage2_data9_out_real;
	reg signed [15:0] stage2_data10_out_real;
	reg signed [15:0] stage2_data11_out_real;
	
	reg signed [15:0] stage2_data12_out_real;
	reg signed [47:0] stage2_data13_out_real;
	reg signed [15:0] stage2_data14_out_real;
	reg signed [47:0] stage2_data15_out_real;
	
	reg signed [15:0] stage2_data0_out_img;	
	reg signed [15:0] stage2_data1_out_img;
	reg signed [15:0] stage2_data2_out_img;
	reg signed [15:0] stage2_data3_out_img;
	
	reg signed [15:0] stage2_data4_out_img;
	reg signed [47:0] stage2_data5_out_img;
	reg signed [15:0] stage2_data6_out_img;
	reg signed [47:0] stage2_data7_out_img;
	
	reg signed [15:0] stage2_data8_out_img;
	reg signed [15:0] stage2_data9_out_img;
	reg signed [15:0] stage2_data10_out_img;
	reg signed [15:0] stage2_data11_out_img;
	
	reg signed [15:0] stage2_data12_out_img;
	reg signed [47:0] stage2_data13_out_img;
	reg signed [15:0] stage2_data14_out_img;
	reg signed [47:0] stage2_data15_out_img;
	
	reg signed [15:0] stage2_data14_out_img_;
	reg signed [15:0] 	stage2_data6_out_img_;
	localparam W0_img = 32'h00000000 ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 0: 000
	localparam W1_img = 32'hFFFF9E09 ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 1: -3.826752e-001
	localparam W2_img = 32'hFFFF4AFC ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 2: -7.070923e-001
	localparam W3_img = 32'hFFFF137D ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 3: -9.238739e-001
	localparam W4_img = 32'hFFFF0000 ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 4: -01
	localparam W5_img = 32'hFFFF137D ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 5: -9.238739e-001
	localparam W6_img = 32'hFFFF4AFC ;     //The imag part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
	localparam W7_img = 32'hFFFF9E09 ;    //The imag part of the reference table about COS(x)+i*SIN(x) value , 7: -3.826752e-001

	localparam W0_real = 32'h00010000 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 0: 001
	localparam W1_real = 32'h0000EC83 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 1: 9.238739e-001
	localparam W2_real = 32'h0000B504 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 2: 7.070923e-001
	localparam W3_real = 32'h000061F7 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 3: 3.826752e-001
	localparam W4_real = 32'h00000000 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 4: 000
	localparam W5_real = 32'hFFFF9E09 ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 5: -3.826752e-001
	localparam W6_real = 32'hFFFF4AFC ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 6: -7.070923e-001
	localparam W7_real = 32'hFFFF137D ;     //The real part of the reference table about COS(x)+i*SIN(x) value , 7: -9.238739e-001


	always@(*)
	begin
	
		 stage2_data0_out_real  = $signed(stage2_data0_in[31:16]) + $signed(stage2_data4_in[31:16]);/////////////////成法器etension bug cofficient extension bug
		 stage2_data1_out_real  = $signed(stage2_data1_in[31:16]) + $signed(stage2_data5_in[31:16]);
		 stage2_data2_out_real  = $signed(stage2_data2_in[31:16]) + $signed(stage2_data6_in[31:16]);
		 stage2_data3_out_real  = $signed(stage2_data3_in[31:16]) + $signed(stage2_data7_in[31:16]);
		 
		 stage2_data4_out_real  =   $signed(stage2_data0_in[31:16]) - $signed(stage2_data4_in[31:16]);
		 stage2_data5_out_real  = ( $signed(W2_real)*( $signed(stage2_data1_in[31:16]) - $signed(stage2_data5_in[31:16]) ) ) - ( $signed(W2_img)*( $signed(stage2_data1_in[15:0]) - $signed(stage2_data5_in[15:0]) ) );
		 stage2_data6_out_real  = ( $signed(stage2_data2_in[15:0]) - $signed(stage2_data6_in[15:0]) );
		 stage2_data7_out_real  = ( $signed(W6_real)*( $signed(stage2_data3_in[31:16]) - $signed(stage2_data7_in[31:16]) ) ) - ( $signed(W6_img)*( $signed(stage2_data3_in[15:0]) - $signed(stage2_data7_in[15:0]) ) );
		 
		 stage2_data8_out_real  = $signed(stage2_data8_in[31:16])  + $signed(stage2_data12_in[31:16]);
		 stage2_data9_out_real  = $signed(stage2_data9_in[31:16])  + $signed(stage2_data13_in[31:16]);
		 stage2_data10_out_real = $signed(stage2_data10_in[31:16]) + $signed(stage2_data14_in[31:16]);
		 stage2_data11_out_real = $signed(stage2_data11_in[31:16]) + $signed(stage2_data15_in[31:16]);
		 
		 stage2_data12_out_real = $signed(stage2_data8_in[31:16]) - $signed(stage2_data12_in[31:16]);
		 stage2_data13_out_real = ( $signed(W2_real) * ( $signed(stage2_data9_in[31:16]) - $signed(stage2_data13_in[31:16])  ) ) - ( $signed(W2_img)*( $signed(stage2_data9_in[15:0]) - $signed(stage2_data13_in[15:0]) ) );
		 stage2_data14_out_real = ( $signed(stage2_data10_in[15:0]) - $signed(stage2_data14_in[15:0]) );
		 stage2_data15_out_real = ( $signed(W6_real) * ( $signed(stage2_data11_in[31:16]) - $signed(stage2_data15_in[31:16]) ) ) - ( $signed(W6_img)*( $signed(stage2_data11_in[15:0]) - $signed(stage2_data15_in[15:0]) ) );
		
		
		 stage2_data0_out_img  = $signed(stage2_data0_in[15:0]) + $signed(stage2_data4_in[15:0]);
		 stage2_data1_out_img  = $signed(stage2_data1_in[15:0]) + $signed(stage2_data5_in[15:0]);
		 stage2_data2_out_img  = $signed(stage2_data2_in[15:0]) + $signed(stage2_data6_in[15:0]);
		 stage2_data3_out_img  = $signed(stage2_data3_in[15:0]) + $signed(stage2_data7_in[15:0]);
		 
		 stage2_data4_out_img  = $signed(stage2_data0_in[15:0]) - $signed(stage2_data4_in[15:0]);
		 stage2_data5_out_img  = ( $signed(W2_real) * ( $signed(stage2_data1_in[15:0]) - $signed(stage2_data5_in[15:0]) ) ) + ( $signed(W2_img) * ( $signed(stage2_data1_in[31:16]) - $signed(stage2_data5_in[31:16]) ) );
		 stage2_data6_out_img_ = $signed(stage2_data2_in[31:16]) - $signed(stage2_data6_in[31:16]);
		 stage2_data6_out_img  = $signed(~stage2_data6_out_img_)+$signed(48'h0000_0100_0000);
		 stage2_data7_out_img  = ( $signed(W6_real) * ( $signed(stage2_data3_in[15:0]) - $signed(stage2_data7_in[15:0]) ) ) + ( $signed(W6_img) * ( $signed(stage2_data3_in[31:16]) - $signed(stage2_data7_in[31:16]) ) );
		 
		 stage2_data8_out_img  = $signed(stage2_data8_in[15:0])  + $signed(stage2_data12_in[15:0]);
		 stage2_data9_out_img  = $signed(stage2_data9_in[15:0])  + $signed(stage2_data13_in[15:0]);
		 stage2_data10_out_img = $signed(stage2_data10_in[15:0]) + $signed(stage2_data14_in[15:0]);
		 stage2_data11_out_img = $signed(stage2_data11_in[15:0]) + $signed(stage2_data15_in[15:0]);
		 
		 stage2_data12_out_img = $signed(stage2_data8_in[15:0]) - $signed(stage2_data12_in[15:0]);
		 stage2_data13_out_img = ( $signed(W2_real) * ( $signed(stage2_data9_in[15:0]) - $signed(stage2_data13_in[15:0]) ) ) + ( $signed(W2_img) * ( $signed(stage2_data9_in[31:16]) - $signed(stage2_data13_in[31:16]) ) );
		 stage2_data14_out_img_=$signed(stage2_data10_in[31:16]) - $signed(stage2_data14_in[31:16]);
		 stage2_data14_out_img =$signed(~stage2_data14_out_img_)+$signed(48'h0000_0100_0000);
		 stage2_data15_out_img = ( $signed(W6_real) * ( $signed(stage2_data11_in[15:0]) - $signed(stage2_data15_in[15:0]) ) ) + ( $signed(W6_img) * ( $signed(stage2_data11_in[31:16]) - $signed(stage2_data15_in[31:16]) ) );
		 
		 
		 
		 
		 stage2_data0_out={stage2_data0_out_real,stage2_data0_out_img};
		 stage2_data1_out={stage2_data1_out_real,stage2_data1_out_img};
		 stage2_data2_out={stage2_data2_out_real,stage2_data2_out_img};
		 stage2_data3_out={stage2_data3_out_real,stage2_data3_out_img};
		 
		 stage2_data4_out={stage2_data4_out_real,stage2_data4_out_img};
		 stage2_data5_out={stage2_data5_out_real[31:16],stage2_data5_out_img[31:16]};
		 stage2_data6_out={stage2_data6_out_real,stage2_data6_out_img};
		 stage2_data7_out={stage2_data7_out_real[31:16],stage2_data7_out_img[31:16]};
		 
		 stage2_data8_out={stage2_data8_out_real,stage2_data8_out_img};
		 stage2_data9_out={stage2_data9_out_real,stage2_data9_out_img};
		 stage2_data10_out={stage2_data10_out_real,stage2_data10_out_img};
		 stage2_data11_out={stage2_data11_out_real,stage2_data11_out_img};
		 
		 stage2_data12_out={stage2_data12_out_real,stage2_data12_out_img};
		 stage2_data13_out={stage2_data13_out_real[31:16],stage2_data13_out_img[31:16]};
		 stage2_data14_out={stage2_data14_out_real,stage2_data14_out_img};
		 stage2_data15_out={stage2_data15_out_real[31:16],stage2_data15_out_img[31:16]};
		
	
	end
	endmodule
	
	
	
	
	
	
	
	
	
	
	
	