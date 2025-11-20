`timescale 1us/1ps
module ALU_16B_TB ();
reg [15:0] A_TB;
reg [15:0] B_TB;
reg [3:0] ALU_FUN_TB;
reg CLK_TB;
wire Carry_Flag_TB;
wire Arith_flag_TB;
wire Logic_flag_TB;
wire CMP_flag_TB;
wire Shift_flag_TB;
wire[15:0] ALU_OUT_TB;
//instantation

ALU_16B DUT(
	.A(A_TB),
	.B(B_TB),
	.CLK(CLK_TB),
	.ALU_FUN(ALU_FUN_TB),
	.Carry_Flag(Carry_Flag_TB),
	.Arith_flag(Arith_flag_TB),
	.Logic_flag(Logic_flag_TB),
	.CMP_flag(CMP_flag_TB),
	.Shift_flag(Shift_flag_TB),
	.ALU_OUT(ALU_OUT_TB));

//clk generation

always #5 CLK_TB=~CLK_TB;
initial begin
$dumpfile("ALU_16B_TB.vcd");
$dumpvars;
CLK_TB=1'b0;
// test 1
A_TB=16'b0000_0000_0000_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b0000;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_1001) && (Carry_Flag_TB == 1'b0) && (Arith_flag_TB ==1'b1) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 1 is passed");
	else
		$display ("the test 1 is failed ");
#4;
//test2
ALU_FUN_TB=4'b0001;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_0001) && (Carry_Flag_TB == 1'b0) && (Arith_flag_TB ==1'b1) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 2 is passed");
	else
		$display ("the test 2 is failed ");
#4;
//test3
A_TB=16'b0000_0000_0000_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b0010;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0001_0100) && (Arith_flag_TB ==1'b1) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 3 is passed");
	else
		$display ("the test 3 is failed ");
#4;
//test4
A_TB=16'b0000_0000_0000_0110;
B_TB=16'b0000_0000_0000_0010;
ALU_FUN_TB=4'b0011;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_0011) && (Arith_flag_TB ==1'b1) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 4 is passed");
	else
		$display ("the test 4 is failed ");
#4;
//test5
A_TB=16'b0010_0110_1010_0101;
B_TB=16'b0010_0110_0101_0100;
ALU_FUN_TB=4'b0100;
#6;
	if ((ALU_OUT_TB == 16'b0010_0110_0000_0100) && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b1) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 5 is passed");
	else
		$display ("the test 5 is failed ");
#4;
//test6
A_TB=16'b0010_0110_1010_0101;
B_TB=16'b0010_0110_0101_0100;
ALU_FUN_TB=4'b0101;
#6;
	if ((ALU_OUT_TB == 16'b0010_0110_1111_0101)  && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b1) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 6 is passed");
	else
		$display ("the test 6 is failed ");
#4;
//test7
A_TB=16'b0010_0110_1010_0101;
B_TB=16'b0010_0110_0101_0100;
ALU_FUN_TB=4'b0110;
#6;
	if ((ALU_OUT_TB == 16'b1101_1001_1111_1011)  && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b1) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 7 is passed");
	else
		$display ("the test 7 is failed ");
#4;
//test8
A_TB=16'b0010_0110_1010_0101;
B_TB=16'b0010_0110_0101_0100;
ALU_FUN_TB=4'b0111;
#6;
	if ((ALU_OUT_TB == 16'b1101_1001_0000_1010)  && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b1) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 8 is passed");
	else
		$display ("the test 8 is failed ");
#4;
//test9
A_TB=16'b0010_0110_1010_0101;
B_TB=16'b0010_0110_0101_0100;
ALU_FUN_TB=4'b1000;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_1111_0001) && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b1) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 9 is passed");
	else
		$display ("the test 9 is failed ");
#4;
//test10
A_TB=16'b0010_0110_1010_0101;
B_TB=16'b0010_0110_0101_0100;
ALU_FUN_TB=4'b1001;
#6;
	if ((ALU_OUT_TB == 16'b1111_1111_0000_1110)  && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b1) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 10 is passed");
	else
		$display ("the test 10 is failed ");
#4;
//test11
A_TB=16'b0000_0000_0000_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b1010;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_0000)  && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b1) && (Shift_flag_TB ==1'b0))
		$display ("the test 11 is passed");
	else
		$display ("the test 11 is failed ");
#4;
//test12
A_TB=16'b0000_0000_0000_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b1011;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_0010) && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b1) && (Shift_flag_TB ==1'b0))
		$display ("the test 12 is passed");
	else
		$display ("the test 12 is failed ");
#4;
//test13
A_TB=16'b0000_0000_0000_0101;
B_TB=16'b0000_0000_0000_0110;
ALU_FUN_TB=4'b1100;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_0011) && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b1) && (Shift_flag_TB ==1'b0))
		$display ("the test 13 is passed");
	else
		$display ("the test 13 is failed ");
#4;
//test14
A_TB=16'b1010_1010_1100_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b1101;
#6;
	if ((ALU_OUT_TB == 16'b0101_0101_0110_0010)  && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b1))
		$display ("the test 14 is passed");
	else
		$display ("the test 14 is failed ");
#4;
//test15
A_TB=16'b1010_1010_1100_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b1110;
#6;
	if ((ALU_OUT_TB == 16'b0101_0101_1000_1010) && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b1))
		$display ("the test 15 is passed");
	else
		$display ("the test 15 is failed ");
#4;
//test16
A_TB=16'b0000_0000_0000_0101;
B_TB=16'b0000_0000_0000_0100;
ALU_FUN_TB=4'b1111;
#6;
	if ((ALU_OUT_TB == 16'b0000_0000_0000_0000) && (Arith_flag_TB ==1'b0) && (Logic_flag_TB ==1'b0) && (CMP_flag_TB ==1'b0) && (Shift_flag_TB ==1'b0))
		$display ("the test 16 is passed");
	else
		$display ("the test 16 is failed ");
#4;
$stop;
end
initial begin 
	$monitor ("at time %0t the value of {ALU_OUT_TB= %0b, Carry_Flag_TB= %0b, Arith_flag_TB= %0b, Logic_flag_TB= %0b, CMP_flag_TB= %0b, Shift_flag_TB= %0b}",$time,ALU_OUT_TB, Carry_Flag_TB, Arith_flag_TB, Logic_flag_TB, CMP_flag_TB, Shift_flag_TB);
end 
endmodule