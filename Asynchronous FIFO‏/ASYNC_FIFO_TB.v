`timescale 1ns / 1ps
module ASYNC_FIFO_TB();
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;
    parameter NUM_STAGES = 2;
    
    reg wclk_TB;
    reg rclk_TB;
    reg wrst_n_TB;
    reg rrst_n_TB;
    reg W_INC_TB;
    reg R_INC_TB;
    reg [DATA_WIDTH-1:0] wr_data_TB;
    wire FULL_TB;
    wire EMPTY_TB;
    wire [DATA_WIDTH-1:0] rd_data_TB;

localparam CLK_PERIOD_W = 10;
localparam CLK_PERIOD_R = 25;
integer i_write;
integer i_read;
reg [DATA_WIDTH-1:0] data_reg;
reg flip;
// write process
initial begin
    $dumpfile("ASYNC_FIFO_Write.vcd");
    $dumpvars();
    initialize_write();
    reset_write();
    flip = 0;
    for(i_write = 0; i_write < 9; i_write = i_write + 1) begin
         //data_reg =$random;
        do_write_data(i_write, $random);
    end
    @(negedge wclk_TB);
    for(i_write = 0; i_write < 2**ADDR_WIDTH; i_write = i_write + 1) begin
         //data_reg =$random;
        do_write_data($random, 1'b1);
    end
    repeat(2) @(negedge wclk_TB );
    check_flag_full();
    for(i_write = 0; i_write < 2**ADDR_WIDTH; i_write = i_write + 1) begin
         //data_reg =$random;
        do_write_data($random, 1'b0);
    end
    repeat(5) @(negedge wclk_TB);
end
// read process
initial begin
    $dumpfile("ASYNC_FIFO_read.vcd");
    $dumpvars();
    initialize_read();
    reset_read();
    for(i_read = 0; i_read < 9; i_read = i_read + 1) begin
        do_read_data(1'b1);
    end
    @(negedge rclk_TB);
    for(i_read = 0; i_read < 2**ADDR_WIDTH; i_read = i_read + 1) begin
        do_read_data(1'b0);
       
    end
    @(negedge rclk_TB);
    for(i_read = 0; i_read < 2**ADDR_WIDTH; i_read = i_read + 1) begin
        do_read_data(1'b1);
        
    end
    @(negedge rclk_TB);
    check_flag_empty();
    repeat(5) @(negedge rclk_TB);
    $stop;
end

task initialize_write;
    begin
        wclk_TB = 0;
        W_INC_TB = 0;
        wr_data_TB = 0; 
    end
endtask
task initialize_read;
    begin
        rclk_TB = 0;
        R_INC_TB = 0;
    end
endtask
task reset_read;
    begin
        rrst_n_TB = 0;
        #(CLK_PERIOD_R);
        rrst_n_TB = 1;
    end
endtask
task reset_write;
    begin
        wrst_n_TB = 0;
        #(CLK_PERIOD_W * 2);
        wrst_n_TB = 1;
    end
endtask

task  do_write_data;
    input [DATA_WIDTH-1:0] data_in;
    input  W_enable;
    begin
        @(negedge wclk_TB);
        wr_data_TB = data_in;
        W_INC_TB = W_enable;
    end
endtask
task  do_read_data;
    input  R_enable;
begin
        @(negedge rclk_TB);
        R_INC_TB = R_enable;
        
end
endtask
task check_flag_full;
begin
        if (FULL_TB) begin 
            if (!EMPTY_TB) 
                 $display("success: FIFO is Full as expected");
             else 
                 $display ("error: FIFO is full as expected but EMPTY flag is also set");
        end
        else 
             $display ("error: FIFO is not full as expected");

end
endtask
task check_flag_empty;
begin  
            if (EMPTY_TB) begin
                if (!FULL_TB)
                     $display ("success: FIFO is empty as expected");
                else 
                     $display ("error: FIFO is empty as expected but FULL flag is also set");

            end
            else 
                $display("error: FIFO should be empty but EMPTY flag is not set");

end 
endtask
always #(CLK_PERIOD_W / 2.0) wclk_TB = ~wclk_TB;
always #(CLK_PERIOD_R / 2.0) rclk_TB = ~rclk_TB;
    ASYNC_FIFO #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .NUM_STAGES(NUM_STAGES)
    ) DUT (
        .wclk(wclk_TB),
        .rclk(rclk_TB),
        .wrst_n(wrst_n_TB),
        .rrst_n(rrst_n_TB),
        .W_INC(W_INC_TB),
        .R_INC(R_INC_TB),
        .wr_data(wr_data_TB),
        .FULL(FULL_TB),
        .EMPTY(EMPTY_TB),
        .rd_data(rd_data_TB)
    );
    /*
initial begin
$monitor("At time %t, W_CLK = %b, R_CLK = %b, W_RST_N = %b, R_RST_N = %b, W_INC = %b, R_INC = %b, WR_DATA = %h, FULL = %b, EMPTY = %b, RD_DATA = %h",
         $time, wclk_TB, rclk_TB, wrst_n_TB, rrst_n_TB, W_INC_TB, R_INC_TB, wr_data_TB, FULL_TB, EMPTY_TB, rd_data_TB);

*/
endmodule