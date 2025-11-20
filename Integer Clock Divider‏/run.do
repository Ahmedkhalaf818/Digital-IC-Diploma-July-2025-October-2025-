vlib work
vlog clock_divider.v clock_divider_tb.v
vsim -voptargs="+acc" work.clock_divider_tb
do wave.do
run -all 