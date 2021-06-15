module tree_adder(
add1,
add2,
add3,
add4,
add5,
add6,
add7,
add8,
add9,
add10,
add11,
add12,
add13,
add14,
add15,
add16,
add17,
add18,
add19,
add20,
add21,
add22,
add23,
add24,
add25,
add26,
add27,
add28,
add29,
add30,
add31,
add32,

result

);
input signed [15:0] add1;
input signed [15:0] add2;
input signed [15:0] add3;
input signed [15:0] add4;
input signed [15:0] add5;
input signed [15:0] add6;
input signed [15:0] add7;
input signed [15:0] add8;
input signed [15:0] add9;
input signed [15:0] add10;
input signed [15:0] add11;
input signed [15:0] add12;
input signed [15:0] add13;
input signed [15:0] add14;
input signed [15:0] add15;
input signed [15:0] add16;
input signed [15:0] add17;
input signed [15:0] add18;
input signed [15:0] add19;
input signed [15:0] add20;
input signed [15:0] add21;
input signed [15:0] add22;
input signed [15:0] add23;
input signed [15:0] add24;
input signed [15:0] add25;
input signed [15:0] add26;
input signed [15:0] add27;
input signed [15:0] add28;
input signed [15:0] add29;
input signed [15:0] add30;
input signed [15:0] add31;
input signed [15:0] add32;
output reg signed [15:0]  result;

reg signed [15:0] stage2_add[15:0];


reg signed [15:0] stage3_add[7:0];


reg signed [15:0] stage4_add[3:0];


reg signed [15:0] stage5_add[1:0];

integer i;
always@(*)
begin
	stage2_add[0]=$signed(add1)+$signed(add2);
	stage2_add[1]=$signed(add3)+$signed(add4);
	stage2_add[2]=$signed(add5)+$signed(add6);
	stage2_add[3]=$signed(add7)+$signed(add8);
	stage2_add[4]=$signed(add9)+$signed(add10);
	
	stage2_add[5]=$signed(add11)+$signed(add12);
	stage2_add[6]=$signed(add13)+$signed(add14);
	stage2_add[7]=$signed(add15)+$signed(add16);
	stage2_add[8]=$signed(add17)+$signed(add18);
	stage2_add[9]=$signed(add19)+$signed(add20);
	
	stage2_add[10]=$signed(add21)+$signed(add22);
	stage2_add[11]=$signed(add23)+$signed(add24);
	stage2_add[12]=$signed(add25)+$signed(add26);
	stage2_add[13]=$signed(add27)+$signed(add28);
	stage2_add[14]=$signed(add29)+$signed(add30);
	
	stage2_add[15]=add30+add31;
	for (i=0;i<8;i=i+1)
	begin
		stage3_add[i]=$signed(stage2_add[i*2])+$signed( stage2_add[(i*2)+1] );
	end
	for (i=0;i<4;i=i+1)
	begin
		stage4_add[i]=$signed(stage3_add[i*2])+$signed( stage3_add[(i*2)+1] );
	end
	for (i=0;i<2;i=i+1)
	begin
		stage5_add[i]=$signed(stage4_add[i*2])+$signed( stage4_add[(i*2)+1] );
	end
	
end












endmodule











