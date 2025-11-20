set top_module TOP_TX
define_design_lib  work -path ./work
puts "#####################################################"
puts "################## library defenation ###############"
puts "#####################################################"

lappend search_path /home/IC/Assignments/Ass_Syn_2.0/rtl
lappend search_path /home/IC/Assignments/Ass_Syn_2.0/std_cells
## Standard Cell libraries 
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"
set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set target_library [list $FFLIB $SSLIB $TTLIB]
## Standard Cell & Hard Macros libraries
set link_library [list * $FFLIB $SSLIB $TTLIB]

##read_file and link to be synthesize 
puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"
set file_format verilog
#read_file -format $file_format FSM_TX.v
#read_file -format $file_format MUX4x1.v
#read_file -format $file_format parity_calc.v
#read_file -format $file_format mux2X1.v
#read_file -format $file_format SERIALIZER.v
#read_file -format $file_format $top_module.v
analyze -format $file_format "FSM_TX.v MUX4x1.v mux2X1.v parity_calc.v SERIALIZER.v $top_module.v"
elaborate -lib work  $top_module

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"




source -echo ./cons.tcl

set_scan_configuration -clock_mixing no_mix -style multiplexed_flip_flop -replace true -max_length 100 
# Write out Design after initial compile
compile  -scan

#compile -ungroup_all map_effort high
#compile_ultra -no_auto_ungroup
#############################################################################
# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0
########################## Define DFT Signals ##########################

set_dft_signal -port [get_ports scan_clk] -type ScanClock -view existing_dft -timing {30 60}
set_dft_signal -port [get_ports scan_rst] -type Reset -view existing_dft -active_state 0
set_dft_signal -port [get_ports test_mode] -type Constant -view existing_dft -active_state 1
set_dft_signal -port [get_ports test_mode] -type TestMode -view spec -active_state 1
set_dft_signal -port [get_ports SE] -type ScanEnable -view spec -active_state 1 -usage scan
set_dft_signal -port [get_ports SI] -type ScanDataIn -view spec
set_dft_signal -port [get_ports SO] -type ScanDataOut -view spec
############################# Create Test Protocol #####################
                                           
create_test_protocol

###################### Pre-DFT Design Rule Checking ####################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary

############################# Insert DFT ###############################

insert_dft

######################## Optimize Logic post DFT #######################

compile_ultra -scan -incremental

###################### Design Rule Checking post DFT ###################

dft_drc -verbose -coverage_estimate



write_file -format $file_format -hierarchy -output DFT_UART_TX_netlist.v
write_file -format ddc -hierarchy -output UART_TX.ddc
write_sdc  -nosplit UART_TX.sdc
write_sdf           UART_TX.sdf

################# reporting #######################

report_area -hierarchy > area.rpt
report_power -hierarchy > power.rpt
report_timing -max_paths 100 -delay_type min > hold.rpt
report_timing -max_paths 100 -delay_type max > setup.rpt
report_clock -attributes > clocks.rpt
report_constraint -all_violators > constraints.rpt
report_port > ports.rpt
dft_drc -coverage > dft_drc_post_dft.rpt


#exit
exit

