`timescale 1ns/1ps
module CRC_tb();
    reg   CLK_tb;
    reg   RST_tb;
    reg   ACTIVE_tb;
    reg   DATA_tb;
    wire  CRC_tb;
    wire  Valid_tb;
parameter Clock_PERIOD = 100 ;
parameter Test_Cases = 10 ;

reg [7:0] Test_Data [Test_Cases -1 :0];
reg [7:0] Expec_Outs [Test_Cases -1 :0];
integer   Operation;
integer   bit;
task do_oper;
input  DATA_task;
input ACTIVE_task;
begin
    DATA_tb= DATA_task;
    ACTIVE_tb = ACTIVE_task;
    #(Clock_PERIOD);
end
endtask
task check_out ;
 input  reg [7:0] outputs_task;
 input  [4:0]  Oper_Num ; 

 integer i ;
 reg [7:0] gener_out ;

 begin
     for(i=0; i<8; i=i+1)
         begin
              gener_out[i] = CRC_tb ;
               #(Clock_PERIOD);
        end
   if(gener_out == outputs_task) 
    begin
     $display("Test Case %d is succeeded",Oper_Num+1);
    end
   else
    begin
     $display("Test Case %d is failed", Oper_Num+1);
    end
   ACTIVE_tb = 1'b1;
 end
endtask

task  initialize;
begin
CLK_tb = 1'b0;
ACTIVE_tb =1'b0;
DATA_tb = 1'b0;
end
endtask

task reset ;
begin
  RST_tb  = 'b0;
  #(Clock_PERIOD)
  RST_tb  = 'b1;
end
endtask
always #(Clock_PERIOD/2)  CLK_tb = ~CLK_tb ;
initial 
 begin
 
 // System Functions
 $dumpfile("CRC.vcd") ;       
 $dumpvars; 

 // Read Input Files
 $readmemh("DATA_h.txt", Test_Data);
 $readmemh("Expec_Out_h.txt", Expec_Outs);

 // initialization
 initialize() ;
 reset();
 // Test Cases
 for (Operation=0;Operation<Test_Cases;Operation=Operation+1)
  begin
    for (bit=0;bit<8;bit=bit+1)
        begin
            do_oper(Test_Data[Operation][bit],1'b1) ;
        end    
    ACTIVE_tb = 1'b0;  
    #(Clock_PERIOD)
    check_out(Expec_Outs[Operation],Operation);
    reset();
  end

 #100
 $stop ;
 end
 CRC DUT
(
.CLK(CLK_tb),
.RST(RST_tb),
.ACTIVE(ACTIVE_tb),
.DATA(DATA_tb),
.CRC(CRC_tb),
.Valid(Valid_tb)
);
endmodule