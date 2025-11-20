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
#read_file -format $file_format SERIALIZER.v
#read_file -format $file_format $top_module.v
analyze -format $file_format "FSM_TX.v MUX4x1.v parity_calc.v SERIALIZER.v $top_module.v"
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

# Write out Design after initial compile
compile -map_effort medium

#compile -ungroup_all map_effort high
#compile_ultra -no_auto_ungroup
#############################################################################


write_file -format $file_format -hierarchy -output UART_TX_netlist.v
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


#exit
exit

