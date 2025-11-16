`timescale 1ns/1ps
module A_G_D_C_tb();
    reg  CLK_tb;
    reg  RST_tb;
    reg  Activate_tb;
    reg  UP_Max_tb;
    reg  DN_Max_tb;
    wire UP_M_tb;
    wire DN_M_tb;

    A_G_D_C DUT (
        .CLK(CLK_tb),
        .RST(RST_tb),
        .Activate(Activate_tb),
        .UP_Max(UP_Max_tb),
        .DN_Max(DN_Max_tb),
        .UP_M(UP_M_tb),
        .DN_M(DN_M_tb)
    );

parameter Clock_PERIOD = 20 ;
/////////////// Signals Initialization //////////////////
task initialize;
 begin
        CLK_tb ='b0;
        Activate_tb ='b0;
        UP_Max_tb ='b0;
        DN_Max_tb = 'b0; 
        
 end
endtask
///////////////////////// RESET /////////////////////////
task reset;
 begin
  RST_tb =  1'b0;
  #(Clock_PERIOD)
  RST_tb  = 1'b1;
 end
endtask
////////////////// Do  Operation ////////////////////
task do_oper ;
    input  Activate_task;
    input  UP_Max_task;
    input  DN_Max_task;
 begin
  Activate_tb =Activate_task;
  UP_Max_tb =UP_Max_task;
  DN_Max_tb =DN_Max_task; 
 end
endtask
////////////////// Check Out Response  ////////////////////

task check_out ;
 input  reg  expec_out1 ;
 input  reg  expec_out2 ;
 input  integer  Oper_Num ;
 reg     gener_out1 ;
 reg     gener_out2 ;
 begin
 #((Clock_PERIOD) *(2/3.0));
    gener_out1 =UP_M_tb;
    gener_out2 =DN_M_tb;
    
    if ((expec_out1 == gener_out1) && (expec_out2 == gener_out2) )
        begin
            $display("Test Case %d is succeeded",Oper_Num);
        end
    else
        begin
            $display("Test Case %d is failed",Oper_Num);
        end
     #((Clock_PERIOD) *(1/3.0));
 end
endtask

//////////////////////////////////////////////////////////
     always #(Clock_PERIOD / 2.0) CLK_tb = ~CLK_tb;
   
    initial begin
    // System Functions
    $dumpfile("A_G_D_C.vcd") ;       
    $dumpvars;
    initialize() ;
    reset();
    do_oper(1'b0,1'b0,1'b0) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b0,32'd1);           //UP_M_tb ,Dn_M_tb,Oper_Num
    

    do_oper(1'b1,1'b1,1'b0) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b1,32'd2);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b1,1'b1,1'b1) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b0,32'd3);           //UP_M_tb ,Dn_M_tb,Oper_Num

    
    do_oper('b1,'b0,'b1) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b1,1'b0,32'd4);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b1,1'b1,1'b1) ;             //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b0,32'd5);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b1,1'b0,1'b1) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b1,1'b0,32'd6);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b0,1'b0,1'b1) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b1,1'b0,32'd7);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b0,1'b1,1'b0) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b0,32'd8);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b1,1'b1,1'b0) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b1,32'd9);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b0,1'b0,1'b0) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b1,32'd10);           //UP_M_tb ,Dn_M_tb,Oper_Num

    do_oper(1'b0,1'b1,1'b1) ;              //Activate ,UP_Max,DN_Max
    check_out (1'b0,1'b0,32'd11);           //UP_M_tb ,Dn_M_tb,Oper_Num
    #((Clock_PERIOD)* 10);
    $stop;
    end

 initial begin
        $monitor("T=%0t | RST=%b | Activate=%b | UP_Max=%b | DN_Max=%b | UP_M=%b | DN_M=%b",
                 $time, RST_tb, Activate_tb, UP_Max_tb, DN_Max_tb, UP_M_tb, DN_M_tb);
    end
endmodule

