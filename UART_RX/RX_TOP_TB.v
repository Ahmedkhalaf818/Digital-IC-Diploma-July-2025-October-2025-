`timescale 1us/1ps
module RX_TOP_TB(); 
parameter DATA_LENGTH=8;
   reg       CLK_RX_TB;
   reg       RST_RX_TB;
   reg       RX_IN_RX_TB;
   reg       PAR_EN_RX_TB;
   reg       PAR_TYP_RX_TB;
   reg [5:0] prescale_RX_TB;

  wire [DATA_LENGTH-1:0] P_DATA_RX_TB;
  wire                   data_valid_RX_TB;
  wire                   parity_error_RX_TB;
  wire                   stop_error_RX_TB;

RX_TOP #(.DATA_LENGTH(DATA_LENGTH)) RX_TOP_DUT (
.CLK_RX(CLK_RX_TB),
.RST_RX(RST_RX_TB),
.RX_IN_RX(RX_IN_RX_TB),
.PAR_EN_RX(PAR_EN_RX_TB),
.PAR_TYP_RX(PAR_TYP_RX_TB),
.prescale_RX(prescale_RX_TB),

.P_DATA_RX(P_DATA_RX_TB),
.data_valid_RX(data_valid_RX_TB),
.parity_error_RX(parity_error_RX_TB),
.stop_error_RX(stop_error_RX_TB)
);
parameter Test_Cases = 200 ;
reg [DATA_LENGTH+2:0] Test_Data [Test_Cases -1 :0];
reg [DATA_LENGTH+2:0] Expec_Outs [Test_Cases -1 :0];
localparam TX_CLK = 115.2 * 1000;
reg TX_CLK_I;
localparam period_TX =  1000000/TX_CLK;
integer j=0;
initial begin
    $dumpfile("UART_RX.vcd");
    $dumpvars;
    $readmemb("DATA_h.txt", Test_Data);
    $readmemb("Expec_Out_h.txt", Expec_Outs);
    initialize();   
    reset();

    //Test Case 1
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[j],1'b1 ,1'b1 , 'b01000);
        check_out(Expec_Outs[j],1'b1,j);
    end
    //Test Case 2
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[11+j],1'b0 ,1'b1 , 'b01000);
        check_out(Expec_Outs[11+j],1'b1,11+j);
    end
    //Test Case 3
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[22+j],1'b1 ,1'b0 , 'b01000);
        check_out(Expec_Outs[22+j],1'b0,22+j);
    end
    //Test Case 4
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[33+j],1'b0 ,1'b0 , 'b01000);
        check_out(Expec_Outs[33+j],1'b1,33+j);
    end
    //Test Case 5
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[44+j],1'b1 ,1'b1 , 'b10000);
        check_out(Expec_Outs[44+j],1'b1,44+j);
    end
    //Test Case 6
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[55+j],1'b0 ,1'b1 , 'b10000);
        check_out(Expec_Outs[55+j],1'b1,55+j);
    end
    //Test Case 7
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[66+j],1'b1 ,1'b0 , 'b10000);
        check_out(Expec_Outs[66+j],1'b0,66+j);
    end
    //Test Case 8
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[77+j],1'b0 ,1'b0 , 'b10000);
        check_out(Expec_Outs[77+j],1'b1,77+j);
    end
        //Test Case 9
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[88+j],1'b1 ,1'b1 , 'b100000);
        check_out(Expec_Outs[88+j],1'b1,88+j);
    end
    //Test Case 10
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[99+j],1'b0 ,1'b1 , 'b100000);
        check_out(Expec_Outs[99+j],1'b1,99+j);
    end
    //Test Case 11
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[110+j],1'b1 ,1'b0 , 'b100000);
        check_out(Expec_Outs[110+j],1'b0,110+j);
    end
    //Test Case 12
    for (j = 0 ; j < 11 ; j = j + 1) begin
        do_oper (Test_Data[121+j],1'b0 ,1'b0 , 'b100000);
        check_out(Expec_Outs[121+j],1'b1,121+j);
    end
    // test glitch
    PAR_EN_RX_TB =1'b1; PAR_TYP_RX_TB =1'b1;  prescale_RX_TB ='b001000;
 
    for (j = 0 ; j < 60 ; j = j + 1) begin
        do_glitch($random);

    end

#(period_TX*2);
$stop;

end
    task do_glitch;
       input  RX_IN_RX_task;
     begin
         RX_IN_RX_TB=RX_IN_RX_task;
         #(period_TX /5); 
        if ((RX_TOP_DUT.FSM_RX1.cs == 3'b001) && (RX_TOP_DUT.FSM_RX1.edge_cnt_FSM ==(prescale_RX_TB-1))) begin 
            if ((RX_TOP_DUT.FSM_RX1.strt_glitch_FSM ==1) ) begin
            $display("Test Case of glitch is succeeded");
            end
            else begin
            $display("Test Case of glitch is not succeeded");
            end
        end
        
     end
    endtask
task initialize;
begin
TX_CLK_I=0;
CLK_RX_TB=0;
RX_IN_RX_TB=1'b1;
PAR_EN_RX_TB = 1'b1;
PAR_TYP_RX_TB = 1'b1;
prescale_RX_TB = 'b01000;
end
endtask
task reset;
begin
RST_RX_TB=1'b0;
# (period_TX);
RST_RX_TB=1'b1;
end
endtask
task do_oper;
input [DATA_LENGTH+2 : 0]Test_Data_test;
input PAR_EN_RX_task;
input PAR_TYP_RX_task;
input [5:0] prescale_RX_task;
integer i;
begin
for (i = 0 ; i < 11 ; i = i + 1) begin
        RX_IN_RX_TB = Test_Data_test[i];
        PAR_EN_RX_TB = PAR_EN_RX_task;
        PAR_TYP_RX_TB = PAR_TYP_RX_task;
        prescale_RX_TB = prescale_RX_task;
        #(period_TX);
end
end
endtask

task check_out ;
 input  reg  [DATA_LENGTH-1:0] expec_out1 ;
 input  reg  validation;
 input  integer  Oper_Num ;

 integer i;

 begin 
    @(negedge CLK_RX_TB);
    if ((P_DATA_RX_TB == expec_out1) || (data_valid_RX_TB==validation))
        begin
            $display("Test Case %d is succeeded",Oper_Num);
        end
    else
        begin
            $display("Test Case %d is failed",Oper_Num);
        end
 end
endtask



always #(1000000/(TX_CLK*2*prescale_RX_TB)) CLK_RX_TB = ~CLK_RX_TB;
always #(1000000/(TX_CLK*2)) TX_CLK_I = ~TX_CLK_I;
/*always begin
    if (prescale_RX_TB == 8)
        #(0.5425347222) CLK_RX_TB = ~CLK_RX_TB;
    if (prescale_RX_TB == 16)
        #(0.2712673611) CLK_RX_TB = ~CLK_RX_TB;
    if (prescale_RX_TB == 32)
        #(0.1356336806) CLK_RX_TB = ~CLK_RX_TB;
end*/
endmodule