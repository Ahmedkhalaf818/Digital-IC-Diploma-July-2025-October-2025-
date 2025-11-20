`timescale 1ns/1ps
module TOP_TX_TB();
  parameter DATA_LENGTH =8;
  reg RST_tb;
  reg CLK_tb;
  reg [DATA_LENGTH-1:0] P_DATA_tb;
  reg PAR_TYP_tb;
  reg PAR_EN_tb;
  reg DATA_VALID_tb;
  wire TX_OUT_tb;
  wire BUSY_tb;

    TOP_TX #(.DATA_LENGTH(DATA_LENGTH)) DUT (
    .RST(RST_tb),
    .CLK(CLK_tb),
    .P_DATA(P_DATA_tb),
    .PAR_TYP(PAR_TYP_tb),
    .PAR_EN(PAR_EN_tb),
    .DATA_VALID(DATA_VALID_tb),
    .TX_OUT(TX_OUT_tb),
    .BUSY(BUSY_tb)
  );
localparam  Clk_period = 5;
always #(Clk_period /2.0) CLK_tb =~CLK_tb; 

task initialize;
begin
CLK_tb =1'b0;
P_DATA_tb = 8'hAD;
PAR_TYP_tb = 1'b0;
PAR_EN_tb = 1'b0;
DATA_VALID_tb = 1'b0;
end
endtask

task reset;
begin
RST_tb = 1'b0;
# (Clk_period);
RST_tb = 1'b1;
end
endtask


task do_oper;
input [DATA_LENGTH-1:0] P_DATA_task;
input PAR_TYP_task;
input PAR_EN_task;
input DATA_VALID_task;
begin
P_DATA_tb = P_DATA_task;
PAR_TYP_tb = PAR_TYP_task;
PAR_EN_tb = PAR_EN_task;
DATA_VALID_tb = DATA_VALID_task;
end
endtask


task check_out ;
 input  reg  [DATA_LENGTH+2:0] expec_out1 ;
 input  integer  Oper_Num ;
 reg    [DATA_LENGTH+2:0] gener_out1 ;
 reg     gener_out2 ;
  integer i;
 begin

for (i = 0; i < DATA_LENGTH+3; i = i+1) begin
    gener_out1[i] = TX_OUT_tb;
    #(Clk_period);
  end

    
    if ((expec_out1 == gener_out1) )
        begin
            $display("Test Case %d is succeeded",Oper_Num);
        end
    else
        begin
            $display("Test Case %d is failed",Oper_Num);
        end
 end
endtask
reg PAR_TYP_test;
reg PAR_EN_test;
reg DATA_VALID_test;
reg [DATA_LENGTH-1:0] P_DATA_test;
integer x;
initial begin
    $dumpfile("FSM_TX.vcd");
    $dumpvars;
    initialize();
    reset();

    // direct test - Test Case 1
    do_oper(8'h7D, 1'b0, 1'b0, 1'b1); //P_DATA_task PAR_TYP_task PAR_EN_task DATA_VALID_task
    #(Clk_period); 
    do_oper(8'hAD, 1'b0, 1'b0, 1'b0);
    check_out(11'b11_0111_1101_0,1);
 

    // direct test - Test Case 2 
    do_oper(8'hAD, 1'b0, 1'b1, 1'b1);
    #(Clk_period); 
    do_oper(8'hAD, 1'b0, 1'b1, 1'b0);
    check_out(11'b11_1010_1101_0,2);
  

    // direct test - Test Case 3
    do_oper(8'h59, 1'b1, 1'b1, 1'b1);
    #(Clk_period); 
    do_oper(8'hAD, 1'b1, 1'b1, 1'b0);
    check_out(11'b11_0101_1001_0,3);

    // direct test - Test Case 4
    do_oper(8'h57, 1'b1, 1'b1, 1'b1);
    #(Clk_period); 
    do_oper(8'hAD, 1'b1, 1'b1, 1'b0);
    check_out(11'b10_0101_0111_0,4);

    // direct test - Test Case 5
    do_oper(8'hBB, 1'b1, 1'b1, 1'b1);
    #(Clk_period); 
    do_oper(8'hAD, 1'b1, 1'b1, 1'b0);
    check_out(11'b11_1011_1011_0,5);

    // direct test - Test Case 6
    do_oper(8'hBA, 1'b0, 1'b0, 1'b1);
    #(Clk_period); 
    do_oper(8'hAA, 1'b0, 1'b0, 1'b0);
    check_out(11'b11_1011_1010_0,6);

    // direct test - Test Case 7 - invalid transmission
    do_oper(8'hAD, 1'b1, 1'b1, 1'b0);
    check_out(11'b11_1111_1111_1,6);
  
    // random test - odd parity
    PAR_TYP_test=1;
    PAR_EN_test=1;
    DATA_VALID_test=1;
    x=7;
    repeat (50) begin
      P_DATA_test=$random;
      do_oper(P_DATA_test, PAR_TYP_test, PAR_EN_test, DATA_VALID_test);
      #(Clk_period);
      do_oper(P_DATA_test, PAR_TYP_test, PAR_EN_test, !DATA_VALID_test);
      check_out({1'b1,~^P_DATA_test,P_DATA_test,1'b0},x);
      x=x+1;
    end

    // random test - even parity
    PAR_TYP_test=0;
    PAR_EN_test=1;
    DATA_VALID_test=1;
    repeat (50) begin
      P_DATA_test=$random;
      do_oper(P_DATA_test, PAR_TYP_test, PAR_EN_test, DATA_VALID_test);
      #(Clk_period);
      do_oper(P_DATA_test, PAR_TYP_test, PAR_EN_test, !DATA_VALID_test);
      check_out({1'b1,^P_DATA_test,P_DATA_test,1'b0},x);
      x=x+1;
    end
    // random test -invalid transmission
    PAR_TYP_test=0;
    PAR_EN_test=1;
    DATA_VALID_test=0;
    repeat (10) begin
      P_DATA_test=$random;
      do_oper(P_DATA_test, PAR_TYP_test, PAR_EN_test, DATA_VALID_test);
      #(Clk_period);
      check_out(11'b11_1111_1111_1,x);
      x=x+1;
    end
    $stop;
end

/*
 initial begin
        $monitor("T=%0t | RST=%b  | P_DATA_tb=%h | PAR_TYP_tb=%b | PAR_EN_tb=%b | DATA_VALID_tb=%b | TX_OUT_tb=%b | BUSY_tb=%b",
                 $time, RST_tb,  P_DATA_tb, PAR_TYP_tb, PAR_EN_tb, DATA_VALID_tb,TX_OUT_tb,BUSY_tb);
    end
*/
endmodule