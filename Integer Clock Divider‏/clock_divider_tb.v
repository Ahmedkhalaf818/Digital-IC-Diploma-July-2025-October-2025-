`timescale 1ns/1ps

module clock_divider_tb;
  reg         i_ref_clk_tb;
  reg         i_rst_n_tb;
  reg         i_clk_en_tb;
  reg  [7:0]  i_div_ratio_tb;
  wire        o_div_clk_tb;

  clock_divider CD (
    .i_ref_clk(i_ref_clk_tb),
    .i_rst_n(i_rst_n_tb),
    .i_clk_en(i_clk_en_tb),
    .i_div_ratio(i_div_ratio_tb),
    .o_div_clk(o_div_clk_tb)
  );
parameter clcok_period = 10;

    always #(clcok_period/2.0) i_ref_clk_tb = ~i_ref_clk_tb;

  initial begin
    $dumpfile("clock_divider.vcd");
    $dumpvars;
    initialize();
    reset();
    do_operation(8'd4, 1'b1); //clk divide by 4 then enable
    do_operation(8'd10, 1'b1); //clk divide by 10 then enable
    do_operation(8'd5, 1'b1); //clk divide by 5 then enable
    do_operation(8'd15, 1'b1); //clk divide by 15 then enable
    do_operation(8'd4, 1'b1); //clk divide by 4 then enable
    do_operation(8'd15, 1'b1); //clk divide by 15 then enable
    do_operation(8'd15, 1'b0); //clk divide by 15 then not enable
    do_operation(8'd0, 1'b1); //clk divide by 0 then enable
    do_operation(8'd1, 1'b1); //clk divide by 1 then enable
    do_operation(8'd15, 1'b1); //clk divide by 15 then enable
    do_operation(8'd4, 1'b1); //clk divide by 4 then enable
    do_operation(8'd1, 1'b1); //clk divide by 1 then enable
    
    $stop;
  end

task reset;
  begin
    i_rst_n_tb = 0;
    # (2.0*clcok_period);
    i_rst_n_tb = 1;
  end
endtask
task initialize;
  begin
    i_ref_clk_tb = 0;
    i_div_ratio_tb = 8'd5;
    i_clk_en_tb = 1'b0;

  end
endtask
task do_operation;
input [7:0] div_ratio;
input clk_en;
  begin
    i_div_ratio_tb = div_ratio;
    i_clk_en_tb = clk_en;
    # (20.0*clcok_period);
  end
endtask
endmodule
