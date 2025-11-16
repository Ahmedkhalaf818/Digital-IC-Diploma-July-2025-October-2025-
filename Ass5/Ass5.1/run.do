vlib work
vlog A_G_D_C.v A_G_D_C_tb.v   +cover -covercells
vsim -voptargs=+acc work.A_G_D_C_tb -cover
add wave *
add wave -position insertpoint  \
sim:/A_G_D_C_tb/DUT/ns \
sim:/A_G_D_C_tb/DUT/cs
run -all



