`timescale  1us/1ns
module ALU_TOP_TB #(parameter width =16 )();
    reg signed [width-1:0] A_TB;
    reg signed [width-1:0] B_TB;
    reg [3:0] ALU_FUN_TB;
    reg CLK_TB;
    reg RST_TB;

    wire signed [2*width-1 : 0] Arith_Out_TB;
    wire Arith_Flag_TB; 
    wire [width-1 : 0] Logic_Out_TB;
    wire Logic_Flag_TB;
    wire [width-1 : 0] CMP_Out_TB;
    wire CMP_Flag_TB;
    wire [width-1 : 0] SHIFT_Out_TB;
    wire SHIFT_Flag_TB;

ALU_TOP #( .width(width)) DUT(
    .A(A_TB),
    .B(B_TB),
    .ALU_FUN(ALU_FUN_TB),
    .CLK(CLK_TB),
    .RST(RST_TB),
    .Arith_Out(Arith_Out_TB),
    .Arith_Flag(Arith_Flag_TB),
    .Logic_Out(Logic_Out_TB),
    .Logic_Flag(Logic_Flag_TB),
    .CMP_Out(CMP_Out_TB),
    .CMP_Flag(CMP_Flag_TB),
    .SHIFT_Out(SHIFT_Out_TB),
    .SHIFT_Flag(SHIFT_Flag_TB)
);
localparam  CLK_TB_PERIOD= 10;
always begin
    CLK_TB =0;
    #(0.4 * CLK_TB_PERIOD);
    CLK_TB = ~CLK_TB;
    #(0.6 * CLK_TB_PERIOD);
end
wire [3*width +2 :0] out_test;
assign out_test ={Logic_Out_TB, Logic_Flag_TB, CMP_Out_TB, CMP_Flag_TB, SHIFT_Out_TB, SHIFT_Flag_TB};
initial begin
    $dumpfile("ALU.vcd");
    $dumpvars;
    RST_TB=0;
    A_TB ='shfff3; // -13
    B_TB ='shfff4; //-12
    ALU_FUN_TB = 4'b0000;
    #CLK_TB_PERIOD
    // test1
    $display ("test case 1 addition A_TB (neg) + B_TB (neg)");
    RST_TB=1;
    #7
    if ((Arith_Out_TB == -'d25 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("addition %0d + %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test case 1 failed");
    #3
    // test2
     $display ("test case 2 addition A_TB (pos) + B_TB (neg)");
    A_TB ='sh0003;
    B_TB ='shfff4;
    #7
    if ((Arith_Out_TB == -'d9 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("addition %0d + %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 2 failed");
    #3
    // test3
     $display ("test case 3 addition A_TB (neg) + B_TB (pos)");
    A_TB ='shfff3;
    B_TB ='sh0004;
    #7
    if ((Arith_Out_TB == -'d9 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("addition %0d + %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 3 failed");
    #3
    // test4
     $display ("test case 4 addition A_TB (pos) + B_TB (pos)");
    A_TB ='sh0003;
    B_TB ='sh0004;
    #7 
    if ((Arith_Out_TB == 'd7 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("addition %0d + %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 4 failed");
    #3
    // test5
     $display ("test case 5 Subtraction A_TB (neg) + B_TB (neg)");
    ALU_FUN_TB = 4'b0001;
    A_TB ='shfff3; // -13
    B_TB ='shfff4; // -12
    #7 
    if ((Arith_Out_TB == -'d1 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("Subtraction %0d - %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 5 failed");
    #3
    // test6
     $display ("test case 6 Subtraction A_TB (pos) + B_TB (neg)");
    A_TB ='sh0003;
    B_TB ='shfff4;
    #7 
    if ((Arith_Out_TB == 'd15 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("Subtraction %0d - %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 6 failed");
    #3
    // test7
     $display ("test case 7 Subtraction A_TB (neg) + B_TB (pos)");
    A_TB ='shfff3;
    B_TB ='sh0004;
    #7 
    if ((Arith_Out_TB == -'d17 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("Subtraction %0d - %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 7 failed");
    #3
    // test8
    $display ("test case 8 Subtraction A_TB (pos) + B_TB (pos)");
    A_TB ='sh0003;
    B_TB ='sh0004;
    #7 
    if ((Arith_Out_TB == -'d1 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("Subtraction %0d - %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 8 failed");
    #3
        // test9
    $display ("test case 9 MUlt A_TB (neg) + B_TB (neg)");
    ALU_FUN_TB = 4'b0010;
    A_TB ='shfff3; // -13
    B_TB ='shfff4; // -12
    #7 
    if ((Arith_Out_TB == 'd156 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("MUlt %0d * %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
        $display ("test 9 failed");
    #3
    // test10
    $display ("test case 10 MUlt A_TB (pos) + B_TB (neg)");
    A_TB ='sh0003; // 3
    B_TB ='shfff4; // -12
    #7 
    if ((Arith_Out_TB == -'d36 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("MUlt %0d * %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else 
        $display ("test 10 failed");
    #3
    // test11
    $display ("test case 11 MUlt A_TB (neg) + B_TB (pos)");
    A_TB ='shfff3; //-13
    B_TB ='sh0004; // 4
    #7 
    if ((Arith_Out_TB == -'d52 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
       $display ("MUlt %0d * %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 11 failed");
    #3
    // test12
    $display ("test case 12 MUlt A_TB (pos) + B_TB (pos)");
    A_TB ='sh0003;
    B_TB ='sh0004;
    #7 
    if ((Arith_Out_TB == 'd12 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("MUlt %0d * %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 12 failed");
    #3
    // test13
    $display ("test case 13 div A_TB (neg) + B_TB (neg)");
    ALU_FUN_TB = 4'b0011;
    A_TB ='shfff3; // -13
    B_TB ='shfff4; // -12
    #7 
    if ((Arith_Out_TB == 'd1 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("div %0d / %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 13 failed");
    #3
    // test14
    $display ("test case 14 div A_TB (pos) + B_TB (neg)");
    A_TB ='sh0003; // 3
    B_TB ='shfff4; // -12
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("div %0d / %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 14 failed");
    #3
    // test15
    $display ("test case 15 div A_TB (neg) + B_TB (pos)");
    A_TB ='shfff3; //-13
    B_TB ='sh0004; // 4
    #7 
    if ((Arith_Out_TB == -'d3 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("div %0d / %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 15 failed");
    #3
    // test16
    $display ("test case 16 div A_TB (pos) + B_TB (pos)");
    A_TB ='sd24;
    B_TB ='sh0004;
    #7 
    if ((Arith_Out_TB == 'd6 ) && ( Arith_Flag_TB == 1'b1 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
       $display ("div %0d / %0d is passed = %0d",A_TB,B_TB,Arith_Out_TB);
    else
        $display ("test 16 failed");
    #3
    // test17
    ALU_FUN_TB = 4'b0100;
    A_TB ='b1010_0011_0000_1111;
    B_TB ='b1110_0011_0110_1001;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b1010_0011_0000_1001_1_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("test 17 passed");
    else
        $display ("test 17 failed");
    #3
    // test18
    ALU_FUN_TB = 4'b0101;
    A_TB ='b1010_0011_0000_1111;
    B_TB ='b1110_0011_0110_1001;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b1110_0011_0110_1111_1_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("test 18 passed");
    else
        $display ("test 18 failed");
    #3
    // test19
    ALU_FUN_TB = 4'b0110;
    A_TB ='b1010_0011_0000_1111;
    B_TB ='b1110_0011_0110_1001;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0101_1100_1111_0110_1_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("test 19 passed");
    else
        $display ("test 19 failed");
    #3
    // test20
    ALU_FUN_TB = 4'b0111;
    A_TB ='b1010_0011_0000_1111;
    B_TB ='b1110_0011_0110_1001;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0001_1100_1001_0000_1_0000_0000_0000_0000_0_0000_0000_0000_0000_0 ))
        $display ("test 20 passed");
    else
        $display ("test 20 failed");
    #3
    // test21
    ALU_FUN_TB = 4'b1000;
    A_TB ='d156;
    B_TB ='d124;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_1_0000_0000_0000_0000_0 ))
        $display ("test 21 passed");
    else
        $display ("test 21 failed");
    #3
    // test22
    ALU_FUN_TB = 4'b1001;
    A_TB ='d124;
    B_TB ='d124;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0001_1_0000_0000_0000_0000_0 ))
        $display ("test 22 passed");
    else
        $display ("test 22 failed");
    #3
    // test23
    ALU_FUN_TB = 4'b1010;
    A_TB ='d156;
    B_TB ='d124;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0010_1_0000_0000_0000_0000_0 ))
        $display ("test 23 passed");
    else
        $display ("test 23 failed");
    #3
    // test24
    ALU_FUN_TB = 4'b1011;
    A_TB ='d156;
    B_TB ='d174;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0011_1_0000_0000_0000_0000_0 ))
        $display ("test 24 passed");
    else
        $display ("test 24 failed");
    #3
    // test25
    ALU_FUN_TB = 4'b1100;
    A_TB ='b0101_0001_1000_1000;
    B_TB ='b1110_0011_0110_1001;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_00000_0000_0000_0_0000_0000_0000_0000_0_0010_1000_1100_0100_1 ))
        $display ("test 25 passed");
    else
        $display ("test 25 failed");
    #3
    // test26
    ALU_FUN_TB = 4'b1101;
    A_TB ='b0101_0001_1000_1000;   
    B_TB ='b1110_0011_0110_1010; 
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_1010_0011_0001_0000_1 ))
        $display ("test 26 passed");
    else
        $display ("test 26 failed");
    #3
    // test27
    ALU_FUN_TB = 4'b1110;
    A_TB ='b1010_0011_0000_1111;
    B_TB ='b1110_0011_0110_1001;
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0111_0001_1011_0100_1 ))
        $display ("test 27 passed");
    else
        $display ("test 27 failed");
    #3
    // test28
    ALU_FUN_TB = 4'b1111;
    A_TB ='b1010_0011_0000_1111;
    B_TB ='b0010_0011_0110_1001; 
    #7 
    if ((Arith_Out_TB == 'd0 ) && ( Arith_Flag_TB == 1'b0 ) && (out_test=='b0000_0000_0000_0000_0_0000_0000_0000_0000_0_0100_0110_1101_0010_1 ))
        $display ("test 28 passed");
    else
        $display ("test 28 failed");
    #3
    // stop simulation
    #3
    $stop;
end
initial begin
    $monitor ("the arith out : %d   its flag : %0b , the logic out :%0h its flag : %0b ,  the CMP out :%0h its flag : %0b , the shift out :%0h its flag : %0b ",Arith_Out_TB,Arith_Flag_TB,Logic_Out_TB, Logic_Flag_TB, CMP_Out_TB, CMP_Flag_TB, SHIFT_Out_TB, SHIFT_Flag_TB);
end
endmodule