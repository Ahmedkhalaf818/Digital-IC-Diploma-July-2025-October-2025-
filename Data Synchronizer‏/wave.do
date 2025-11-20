onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TEST SIGNAL} /DATA_SYNC_TB/clk_TB
add wave -noupdate -expand -group {TEST SIGNAL} /DATA_SYNC_TB/rst_n_TB
add wave -noupdate -expand -group {TEST SIGNAL} /DATA_SYNC_TB/NUM_STAGE
add wave -noupdate -expand -group {TEST SIGNAL} /DATA_SYNC_TB/stimulus_task/delay_time
add wave -noupdate -expand -group {Design signal} /DATA_SYNC_TB/DUT/unsync_bus
add wave -noupdate -expand -group {Design signal} -color {Violet Red} /DATA_SYNC_TB/DUT/sync_bus
add wave -noupdate -expand -group {Design signal} -color {Blue Violet} /DATA_SYNC_TB/DUT/bus_enable
add wave -noupdate -expand -group {Design signal} -color Blue /DATA_SYNC_TB/DUT/enable_pulse
add wave -noupdate -expand -group {Design signal} /DATA_SYNC_TB/DUT/sync_reg
add wave -noupdate -expand -group {Design signal} /DATA_SYNC_TB/DUT/enable_pulse_reg
add wave -noupdate -expand -group {Design signal} /DATA_SYNC_TB/DUT/enable_pulse_gen_reg
add wave -noupdate -expand -group {Design signal} /DATA_SYNC_TB/DUT/enable_pulse_gen
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {170886 ps} 0}
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
WaveRestoreZoom {0 ps} {210 ns}
