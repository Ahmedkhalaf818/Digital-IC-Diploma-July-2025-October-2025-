vlib work
vlog  DATA_SYNC.v DATA_SYNC_TB.v
vsim -voptargs=+acc work.DATA_SYNC_TB
do wave.do

run -all