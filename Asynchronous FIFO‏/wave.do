onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/wrst_n_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/rrst_n_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/wclk_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/rclk_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/W_INC_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/R_INC_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/wr_data_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL /ASYNC_FIFO_TB/rd_data_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL -color {Cornflower Blue} /ASYNC_FIFO_TB/FULL_TB
add wave -noupdate -expand -group TOP_TB_SIGNAL -color {Cornflower Blue} /ASYNC_FIFO_TB/EMPTY_TB
add wave -noupdate -expand -group TOP_SIGNALS -color {Cornflower Blue} /ASYNC_FIFO_TB/DUT/wptr_async
add wave -noupdate -expand -group TOP_SIGNALS -color {Medium Orchid} /ASYNC_FIFO_TB/DUT/rq2_wptr_sync
add wave -noupdate -expand -group TOP_SIGNALS -color {Medium Orchid} /ASYNC_FIFO_TB/DUT/rptr_async
add wave -noupdate -expand -group TOP_SIGNALS -color {Cornflower Blue} /ASYNC_FIFO_TB/DUT/wq2_rptr_sync
add wave -noupdate -expand -group TOP_SIGNALS -color {Medium Violet Red} /ASYNC_FIFO_TB/DUT/waddr
add wave -noupdate -expand -group TOP_SIGNALS -color Blue /ASYNC_FIFO_TB/DUT/raddr
add wave -noupdate -expand -group TOP_SIGNALS /ASYNC_FIFO_TB/DUT/wr_data
add wave -noupdate -expand -group TOP_SIGNALS /ASYNC_FIFO_TB/DUT/rd_data
add wave -noupdate -expand -group memory -expand /ASYNC_FIFO_TB/DUT/fifo_mem_cntrl/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44792 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {288075 ps}
