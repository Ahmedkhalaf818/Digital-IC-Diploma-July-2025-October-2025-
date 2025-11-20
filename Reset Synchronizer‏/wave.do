onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {DUT INTERFACE} /RST_SYN_TB/CLK
add wave -noupdate -expand -group {DUT INTERFACE} -color {Medium Blue} /RST_SYN_TB/RST
add wave -noupdate -expand -group {DUT INTERFACE} /RST_SYN_TB/SYNC_RST
add wave -noupdate -expand -group {Design signal} -color {Medium Violet Red} /RST_SYN_TB/DUT/SYNC_RST
add wave -noupdate -expand -group {Design signal} /RST_SYN_TB/DUT/rst_shift_reg
add wave -noupdate -expand -group {Design signal} /RST_SYN_TB/DUT/RST
add wave -noupdate -expand -group {Design signal} /RST_SYN_TB/DUT/NUM_STAGE
add wave -noupdate -expand -group {Design signal} /RST_SYN_TB/DUT/CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {264452 ps} 0}
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
WaveRestoreZoom {246308 ps} {319559 ps}
