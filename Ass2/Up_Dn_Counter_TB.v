`timescale 1ns/1ps
module Up_Dn_Counter_Tb();
//signal declaration
reg [4:0] IN_TB;
reg CLK_TB;
reg Load_TB;
reg Up_TB;
reg Down_TB;
wire [4:0] Counter_TB;
wire High_TB;
wire Low_TB;
//insatntation
Up_Dn_Counter DUT(.IN(IN_TB),.CLK(CLK_TB),.Load(Load_TB),.Up(Up_TB),.Down(Down_TB),.Counter(Counter_TB),.High(High_TB),.Low(Low_TB));
// clock generation
always #5 CLK_TB=~CLK_TB;
// generate stimulis
initial begin
$dumpfile("counter.vcd");
$dumpvars;
CLK_TB=1'b0;
IN_TB=5'd16;
Load_TB=1'b1; //case 1 :loading value
Up_TB=0;
Down_TB=0;
#10  Up_TB=1'b1; Load_TB=1'b0;                 // case 2: UP sequence  
#50 Down_TB=1'b1; Up_TB=1'b1;                 // case3: down is high piriority and if reach to zero 
#240 Down_TB=1'b0; Up_TB=1'b0;               //case 4 : counter<= counter same value not changing
#40  IN_TB=5'd0; Down_TB=1'b1;Load_TB=1'b1; //case5 if loaded value is zero 
#40  IN_TB=5'd31; Down_TB=1'b0;            // case 6 if loaded value is 31
#40 $stop;
end
initial begin
$monitor ("at time : %0t the output is : 0x%0h and low signal :%0b and hogh signal :%0b ",$time ,Counter_TB,Low_TB,High_TB);
end
endmodule