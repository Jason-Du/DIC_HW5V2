/*`include "counter.v"
`include "tree_adder.v"
*/

module fir(
clk,
rst,
data,
data_valid,


fir_d,
fir_valid,
);
parameter signed [19:0] FIR_C00 = 20'hFFF9E ;     //The FIR_coefficient value 0: -1.495361e-003
parameter signed [19:0] FIR_C01 = 20'hFFF86 ;     //The FIR_coefficient value 1: -1.861572e-003
parameter signed [19:0] FIR_C02 = 20'hFFFA7 ;     //The FIR_coefficient value 2: -1.358032e-003
parameter signed [19:0] FIR_C03 = 20'h0003B ;    //The FIR_coefficient value 3: 9.002686e-004
parameter signed [19:0] FIR_C04 = 20'h0014B ;    //The FIR_coefficient value 4: 5.050659e-003
parameter signed [19:0] FIR_C05 = 20'h0024A ;    //The FIR_coefficient value 5: 8.941650e-003
parameter signed [19:0] FIR_C06 = 20'h00222 ;    //The FIR_coefficient value 6: 8.331299e-003
parameter signed [19:0] FIR_C07 = 20'hFFFE4 ;     //The FIR_coefficient value 7: -4.272461e-004
parameter signed [19:0] FIR_C08 = 20'hFFBC5 ;     //The FIR_coefficient value 8: -1.652527e-002
parameter signed [19:0] FIR_C09 = 20'hFF7CA ;     //The FIR_coefficient value 9: -3.207397e-002
parameter signed [19:0] FIR_C10 = 20'hFF74E ;     //The FIR_coefficient value 10: -3.396606e-002
parameter signed [19:0] FIR_C11 = 20'hFFD74 ;     //The FIR_coefficient value 11: -9.948730e-003
parameter signed [19:0] FIR_C12 = 20'h00B1A ;    //The FIR_coefficient value 12: 4.336548e-002
parameter signed [19:0] FIR_C13 = 20'h01DAC ;    //The FIR_coefficient value 13: 1.159058e-001
parameter signed [19:0] FIR_C14 = 20'h02F9E ;    //The FIR_coefficient value 14: 1.860046e-001
parameter signed [19:0] FIR_C15 = 20'h03AA9 ;    //The FIR_coefficient value 15: 2.291412e-001
parameter signed [19:0] FIR_C16 = 20'h03AA9 ;    //The FIR_coefficient value 16: 2.291412e-001
parameter signed [19:0] FIR_C17 = 20'h02F9E ;    //The FIR_coefficient value 17: 1.860046e-001
parameter signed [19:0] FIR_C18 = 20'h01DAC ;    //The FIR_coefficient value 18: 1.159058e-001
parameter signed [19:0] FIR_C19 = 20'h00B1A ;    //The FIR_coefficient value 19: 4.336548e-002
parameter signed [19:0] FIR_C20 = 20'hFFD74 ;     //The FIR_coefficient value 20: -9.948730e-003
parameter signed [19:0] FIR_C21 = 20'hFF74E ;     //The FIR_coefficient value 21: -3.396606e-002
parameter signed [19:0] FIR_C22 = 20'hFF7CA ;     //The FIR_coefficient value 22: -3.207397e-002
parameter signed [19:0] FIR_C23 = 20'hFFBC5 ;     //The FIR_coefficient value 23: -1.652527e-002
parameter signed [19:0] FIR_C24 = 20'hFFFE4 ;     //The FIR_coefficient value 24: -4.272461e-004
parameter signed [19:0] FIR_C25 = 20'h00222 ;    //The FIR_coefficient value 25: 8.331299e-003
parameter signed [19:0] FIR_C26 = 20'h0024A ;    //The FIR_coefficient value 26: 8.941650e-003
parameter signed [19:0] FIR_C27 = 20'h0014B ;    //The FIR_coefficient value 27: 5.050659e-003
parameter signed [19:0] FIR_C28 = 20'h0003B ;    //The FIR_coefficient value 28: 9.002686e-004
parameter signed [19:0] FIR_C29 = 20'hFFFA7 ;     //The FIR_coefficient value 29: -1.358032e-003
parameter signed [19:0] FIR_C30 = 20'hFFF86 ;     //The FIR_coefficient value 30: -1.861572e-003
parameter signed [19:0] FIR_C31 = 20'hFFF9E ;     //The FIR_coefficient value 31: -1.495361e-003


input clk;
input rst;
input data_valid;
input signed [15:0] data;

output signed  [15:0] fir_d;
output reg  fir_valid;

reg signed [15:0] dff_register    [30:0];
reg signed [15:0] dff_register_in [30:0];
//reg signed [27:0] mult_value      [31:0];
reg signed [35:0] mult_value      [31:0];
reg signed [15:0] data_stage2;
integer i;
localparam IDLE =2'b00;
localparam FILL =2'b01;
localparam START=2'b10;
localparam PAD  =2'b11;
reg [1:0] CS;
reg [1:0] NS;
reg  C0_clear;
reg  C0_keep;
wire [9:0] C0_count;

always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		for(i=0;i<31;i=i+1)
		begin
			dff_register[i]<=16'd0;
		end
	end
	else
	begin
		for(i=0;i<31;i=i+1)
		begin
			dff_register[i]<=dff_register_in[i];
		end
		
	end
end
always@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		CS<=FILL;
	end
	else
	begin
		CS<=NS;
	end
end
always@(*)
begin
	C0_keep=data_valid?1'b0:1'b1;
	C0_clear=(C0_count==10'd1023)?1'b1:1'b0;
	case(CS)
		FILL:
		begin
			NS=(C0_count==10'd30)?START:FILL;
			fir_valid=1'b0;
			data_stage2=data;
			
		end
		START:
		begin
			NS=(C0_count==10'd992)?PAD:START;
			fir_valid=1'b1;
			data_stage2=data;
		end
		PAD:
		begin
			NS=(C0_count==10'd1023)?PAD:FILL;
			fir_valid=1'b1;
			data_stage2=16'd0;
		end
		default:
		begin
			NS=FILL;
			fir_valid=1'b0;
			data_stage2=16'd0;
		end
	endcase
end

counter C0(
	.clk(clk),
	.rst(rst),
	.count(C0_count),
	
	.clear(C0_clear),
	.keep(C0_keep)
);

always@(*)
begin
	dff_register_in[0]=data_stage2;
	for(i=0;i<30;i=i+1)
	begin
		dff_register_in[i+1]=dff_register[i];
	end
end

always@(*)
begin
	mult_value[0]=$signed(dff_register_in[0])*$signed(FIR_C00);
	mult_value[1]=$signed(dff_register_in[1])*$signed(FIR_C01);
	mult_value[2]=$signed(dff_register_in[2])*$signed(FIR_C02);
	mult_value[3]=$signed(dff_register_in[3])*$signed(FIR_C03);
	mult_value[4]=$signed(dff_register_in[4])*$signed(FIR_C04);
	
	mult_value[5]=$signed(dff_register_in[5])*$signed(FIR_C05);
	mult_value[6]=$signed(dff_register_in[6])*$signed(FIR_C06);
	mult_value[7]=$signed(dff_register_in[7])*$signed(FIR_C07);
	mult_value[8]=$signed(dff_register_in[8])*$signed(FIR_C08);
	mult_value[9]=$signed(dff_register_in[9])*$signed(FIR_C09);
	
	mult_value[10]=$signed(dff_register_in[10])*$signed(FIR_C10);
	mult_value[11]=$signed(dff_register_in[11])*$signed(FIR_C11);
	mult_value[12]=$signed(dff_register_in[12])*$signed(FIR_C12);
	mult_value[13]=$signed(dff_register_in[13])*$signed(FIR_C13);
	mult_value[14]=$signed(dff_register_in[14])*$signed(FIR_C14);
	
	mult_value[15]=$signed(dff_register_in[15])*$signed(FIR_C15);
	mult_value[16]=$signed(dff_register_in[16])*$signed(FIR_C16);
	mult_value[17]=$signed(dff_register_in[17])*$signed(FIR_C17);
	mult_value[18]=$signed(dff_register_in[18])*$signed(FIR_C18);
	mult_value[19]=$signed(dff_register_in[19])*$signed(FIR_C19);
	
	mult_value[20]=$signed(dff_register_in[20])*$signed(FIR_C20);
	mult_value[21]=$signed(dff_register_in[21])*$signed(FIR_C21);
	mult_value[22]=$signed(dff_register_in[22])*$signed(FIR_C22);
	mult_value[23]=$signed(dff_register_in[23])*$signed(FIR_C23);
	mult_value[24]=$signed(dff_register_in[24])*$signed(FIR_C24);
	
	mult_value[25]=$signed(dff_register_in[25])*$signed(FIR_C25);
	mult_value[26]=$signed(dff_register_in[26])*$signed(FIR_C26);
	mult_value[27]=$signed(dff_register_in[27])*$signed(FIR_C27);
	mult_value[28]=$signed(dff_register_in[28])*$signed(FIR_C28);
	mult_value[29]=$signed(dff_register_in[29])*$signed(FIR_C29);
	
	mult_value[30]=$signed(dff_register_in[30])*$signed(FIR_C30);
	mult_value[31]=$signed(dff_register   [30])*$signed(FIR_C31);

end

tree_adder T0(
.add1(mult_value[0][35:0]),
.add2(mult_value[1][35:0]),
.add3(mult_value[2][35:0]),
.add4(mult_value[3][35:0]),
.add5(mult_value[4][35:0]),
.add6(mult_value[5][35:0]),
.add7(mult_value[6][35:0]),
.add8(mult_value[7][35:0]),
.add9(mult_value[8][35:0]),
.add10(mult_value[9][35:0]),
.add11(mult_value[10][35:0]),
.add12(mult_value[11][35:0]),
.add13(mult_value[12][35:0]),
.add14(mult_value[13][35:0]),
.add15(mult_value[14][35:0]),
.add16(mult_value[15][35:0]),
.add17(mult_value[16][35:0]),
.add18(mult_value[17][35:0]),
.add19(mult_value[18][35:0]),
.add20(mult_value[19][35:0]),
.add21(mult_value[20][35:0]),
.add22(mult_value[21][35:0]),
.add23(mult_value[22][35:0]),
.add24(mult_value[23][35:0]),
.add25(mult_value[24][35:0]),
.add26(mult_value[25][35:0]),
.add27(mult_value[26][35:0]),
.add28(mult_value[27][35:0]),
.add29(mult_value[28][35:0]),
.add30(mult_value[29][35:0]),
.add31(mult_value[30][35:0]),
.add32(mult_value[31][35:0]),

.result(fir_d)

);



endmodule

