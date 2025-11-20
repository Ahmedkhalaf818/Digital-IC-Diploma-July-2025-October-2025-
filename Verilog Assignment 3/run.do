vlib work
vlog ALU_16B_TB.v ALU_16B.v
vsim -voptargs=+acc work.ALU_16B_TB.v
add wave *
run -all
#quit -sim