`include "fir.v"
`include "fft.v"
`include "analyze.v"

module  FAS (
		data_valid,// fir
		data, // fir
		clk, 
		rst, 
		fir_d,// fir out fft in
		fir_valid, // fir out fft in
		fft_valid, 
		done, 
		freq,
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
input clk, rst;
input data_valid;
input signed [15:0] data; 

output fir_valid, fft_valid;
output signed [15:0] fir_d;
output [31:0] fft_d1, fft_d2, fft_d3, fft_d4, fft_d5, fft_d6, fft_d7, fft_d8;
output [31:0] fft_d9, fft_d10, fft_d11, fft_d12, fft_d13, fft_d14, fft_d15, fft_d0;
output done;
output [3:0] freq;

fir FIR0(
		.clk(clk),
		.rst(rst),
		.data(data),
		.data_valid(data_valid),


		.fir_d(fir_d),
		.fir_valid(fir_valid)
);
fft FFT0(
.clk(clk),
		.rst(rst),
		.fir_valid(fir_valid), // fir out fft in
		.fir_d(fir_d),// fir out fft in
		.fft_valid(fft_valid), 
		//	done(), 
		//	freq(),
		.fft_d1(fft_d1), 
		.fft_d2(fft_d2), 
		.fft_d3(fft_d3), 
		.fft_d4(fft_d4), 
		.fft_d5(fft_d5), 
		.fft_d6(fft_d6), 
		.fft_d7(fft_d7), 
		.fft_d8(fft_d8),
		.fft_d9(fft_d9),
		.fft_d10(fft_d10), 
		.fft_d11(fft_d11), 
		.fft_d12(fft_d12), 
		.fft_d13(fft_d13), 
		.fft_d14(fft_d14), 
		.fft_d15(fft_d15), 
		.fft_d0(fft_d0)
);
analyze ANA0(
		.clk(clk),
		.rst(rst),
		.done(done), 
		.freq(freq),
		.fft_valid(fft_valid),
		.fft_d1(fft_d1), 
		.fft_d2(fft_d2), 
		.fft_d3(fft_d3), 
		.fft_d4(fft_d4), 
		.fft_d5(fft_d5), 
		.fft_d6(fft_d6), 
		.fft_d7(fft_d7), 
		.fft_d8(fft_d8),
		.fft_d9(fft_d9),
		.fft_d10(fft_d10), 
		.fft_d11(fft_d11), 
		.fft_d12(fft_d12), 
		.fft_d13(fft_d13), 
		.fft_d14(fft_d14), 
		.fft_d15(fft_d15), 
		.fft_d0(fft_d0)
		);
endmodule

