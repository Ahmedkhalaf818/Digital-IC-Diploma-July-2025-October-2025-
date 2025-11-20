vlib work
vlog  DATA_SYNC.v RST_SYN_TB.v
vsim -voptargs=+acc work.RST_SYN_TB
run -all