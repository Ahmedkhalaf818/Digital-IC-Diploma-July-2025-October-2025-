vlib work
vlog CRC.v CRC_tb.v   +cover -covercells
vsim -voptargs=+acc work.CRC_tb -cover
add wave *
add wave -position insertpoint  \
sim:/CRC_tb/check_out/gener_out
add wave -position insertpoint  \
sim:/CRC_tb/do_oper/DATA_task
add wave -position insertpoint  \
sim:/CRC_tb/Expec_Outs
add wave -position insertpoint  \
sim:/CRC_tb/Test_Data
run -all



