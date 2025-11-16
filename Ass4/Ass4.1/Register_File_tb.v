module Register_File_tb #(parameter reg_WIDTH = 16)();
  reg CLK;
  reg RST;
  reg WrEn;
  reg RdEn;
  reg [reg_WIDTH-1:0] WrData;
  reg [2:0] Address;
  wire [reg_WIDTH-1:0] RdData;

    Register_File #(.reg_WIDTH(reg_WIDTH)) uut (
    .CLK(CLK),
    .RST(RST),
    .WrEn(WrEn),
    .RdEn(RdEn),
    .WrData(WrData),
    .Address(Address),
    .RdData(RdData)
  );

always #5 CLK = ~CLK;

initial begin
    $dumpfile("Register_File.vcd");
    $dumpvars;
    CLK= 1'b0;
    RST= 1'b0;
    WrEn= 1'b0;
    RdEn= 1'b1;
    Address= 'd7;
    WrData= 'd6000;
    #10
    RST= 1'b1;
    #7
    // test1 there fill register by zero
    if(RdData =='d0)
      $display ("test 1 passed  Address= 'd7 : RdData =='d0");
    else
      $display ("test 1 failed");
    #3
    //test2 write in all register 
    WrEn= 1'b1;
    RdEn= 1'b0;
    #10
    Address= 'd6;
    WrData= 'd840;
    #10
    Address= 'd5;
    WrData= 'd900;
    #10
    Address= 'd4;
    WrData= 'd720;
    #10
    Address= 'd3;
    WrData= 'd210;
    #10
    Address= 'd2;
    WrData= 'd1150;
    #10
    Address= 'd1;
    WrData= 'd620;
    #10
    Address= 'd0;
    WrData= 'd310;
    #10
    //test3
    RdEn= 1'b1;
    WrEn= 1'b0;
    Address= 'd5;
    #7
    if(RdData =='d900)
      $display ("test 2 passed  Address= 'd5 : RdData =='d900");
    else
      $display ("test 2 failed");
    #3
    //test4
    Address= 'd1;
    #7
    if(RdData =='d620)
      $display ("test 3 passed  Address= 'd1 : RdData =='d620");
    else
      $display ("test 3 failed");
    #3
    //test5 if two signal high 
    RdEn= 1'b1;
    WrEn= 1'b1;
    Address= 'd5;
    WrData= 'd900; 
    if(RdData =='d620)
    $display ("test 4 passed  Address= 'd1 : RdData =='d620");
    else
      $display ("test 4 failed");

    #20
    $stop;
end

initial begin
    $monitor("Time = %0t | RST=%b | WrEn=%b | RdEn=%b | Addr=%0d | WrData=0x%0d | RdData=0x%0d",$time, RST, WrEn, RdEn, Address, WrData, RdData);
end

endmodule