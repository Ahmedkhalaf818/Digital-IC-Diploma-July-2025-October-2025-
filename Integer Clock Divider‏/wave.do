onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {design signal} -color {Violet Red} /clock_divider_tb/CD/i_rst_n
add wave -noupdate -expand -group {design signal} /clock_divider_tb/CD/i_ref_clk
add wave -noupdate -expand -group {design signal} -color Magenta /clock_divider_tb/CD/o_div_clk
add wave -noupdate -expand -group {design signal} /clock_divider_tb/CD/i_div_ratio
add wave -noupdate -expand -group {design signal} -color Gold /clock_divider_tb/CD/clk_div_en
add wave -noupdate -expand -group {internal signal} /clock_divider_tb/CD/o_div_clk_reg
add wave -noupdate -expand -group {internal signal} /clock_divider_tb/CD/half_toggle_p1
add wave -noupdate -expand -group {internal signal} /clock_divider_tb/CD/half_toggle
add wave -noupdate -expand -group {internal signal} /clock_divider_tb/CD/flag
add wave -noupdate -expand -group {internal signal} /clock_divider_tb/CD/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {661006 ps}
