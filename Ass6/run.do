vlib work
vlog -f sourcefile.txt
vsim -voptargs=+acc work.TOP_TX_TB
add wave *
add wave -position insertpoint  \
sim:/TOP_TX_TB/DUT/FSM1/ns \
sim:/TOP_TX_TB/DUT/FSM1/cs
add wave -position insertpoint  \
sim:/TOP_TX_TB/DUT/SER/ser_en \
sim:/TOP_TX_TB/DUT/SER/ser_done \
sim:/TOP_TX_TB/DUT/SER/counter
add wave -position insertpoint  \
sim:/TOP_TX_TB/DUT/mux/mux_sel_mux
add wave -position insertpoint  \
sim:/TOP_TX_TB/DUT/SER/ser_data
run -all
