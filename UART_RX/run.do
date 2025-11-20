vlib work
vlog -f sourcefile.txt
vsim -voptargs=+acc work.RX_TOP_TB
add wave *
add wave -position insertpoint  \
sim:/RX_TOP_TB/RX_TOP_DUT/FSM_RX1/deser_en_FSM

add wave -position insertpoint  \
sim:/RX_TOP_TB/RX_TOP_DUT/edge_bit_counter_RX1/edge_cnt_edge \
sim:/RX_TOP_TB/RX_TOP_DUT/edge_bit_counter_RX1/bit_cnt_edge 
add wave -position insertpoint  \
sim:/RX_TOP_TB/RX_TOP_DUT/FSM_RX1/ns \
sim:/RX_TOP_TB/RX_TOP_DUT/FSM_RX1/cs 
add wave -position insertpoint  \
sim:/RX_TOP_TB/RX_TOP_DUT/data_sampling_RX1/sample_bit_samp \
sim:/RX_TOP_TB/RX_TOP_DUT/stop_check_RX1/stp_chk_en \
sim:/RX_TOP_TB/RX_TOP_DUT/parity_check_RX1/par_chk_en \
sim:/RX_TOP_TB/RX_TOP_DUT/strt_check_RX1/strt_chk_en \
sim:/RX_TOP_TB/RX_TOP_DUT/data_samp_en_wire \
sim:/RX_TOP_TB/RX_TOP_DUT/enable_wire \
sim:/RX_TOP_TB/RX_TOP_DUT/FSM_RX1/strt_glitch_FSM \
sim:/RX_TOP_TB/RX_TOP_DUT/FSM_RX1/data_valid_FSM
add wave -position insertpoint  \
sim:/RX_TOP_TB/RX_TOP_DUT/FSM_RX1/par_err_reg
run -all

