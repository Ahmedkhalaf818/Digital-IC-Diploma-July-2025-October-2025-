`timescale 1ns / 1ps
module DATA_SYNC_TB ();
    parameter NUM_STAGE = 2; 
    parameter BUS_WIDTH = 8;
    reg                  clk_TB;
    reg                  rst_n_TB;
    reg  [BUS_WIDTH-1:0] unsync_bus_TB;
    reg                  bus_enable_TB;
    wire [BUS_WIDTH-1:0] sync_bus_TB;
    wire                 enable_pulse_TB;
DATA_SYNC #(.NUM_STAGE(NUM_STAGE),.BUS_WIDTH(BUS_WIDTH)) DUT (
.clk(clk_TB),
.rst_n(rst_n_TB),
.unsync_bus(unsync_bus_TB),
.bus_enable(bus_enable_TB),
.sync_bus(sync_bus_TB),
.enable_pulse(enable_pulse_TB)
);
localparam period =10 ;
localparam delay_time_width = 10;
initial begin
    $dumpfile("DATA_SYNC_TB.vcd");
    $dumpvars;
    init_task();
    reset_task();
    stimulus_task('hA5,1'b1,2);
    stimulus_task('h5A,1'b0,4);
    stimulus_task('hFF,1'b1,5);
    stimulus_task('hBA,1'b0,6);
    stimulus_task('h3C,1'b1,2);
    #(period * 5);
    $stop;

end
task reset_task;
    begin
        rst_n_TB = 1'b0;
        #(period);
        rst_n_TB = 1'b1;
    end
endtask

task init_task;
    begin
        clk_TB = 1'b0;
        unsync_bus_TB = 'hFF;
        bus_enable_TB = 1'b0;
    end
endtask
task stimulus_task;
input [BUS_WIDTH-1:0] unsync_bus_data;
input enable;
input [delay_time_width-1:0] delay_time;
    begin
        unsync_bus_TB = unsync_bus_data;
        bus_enable_TB = enable;
        #(period * delay_time);
    end
endtask
always #(period / 2.0 ) clk_TB = ~clk_TB;



endmodule
