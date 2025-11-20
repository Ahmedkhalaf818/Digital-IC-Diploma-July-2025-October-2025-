puts "****Writing Verilog Block Interface****"
set modname "Up_Dn_Counter"
set in_ports [list  IN Load Up Down CLK]
set in_ports_width [list  4 1 1 1 1]
set out_ports [list High Counter Low]
set out_ports_width [list 1 4 1]
set hand_file [open "$modname.v" w+]
puts $hand_file "module $modname \(" 
foreach a $in_ports b $in_ports_width {
    if {$b == 1} {
        puts $hand_file "input          $a,"
    } else {
        puts $hand_file "input   \[[expr $b-1]:0\]  $a,"
    }
}
set len [llength $out_ports_width]
set counter 1
foreach a $out_ports b $out_ports_width {
    if {$b ==1 && $len != $counter} {
        puts $hand_file "output         $a," 
    } elseif {$len == $counter && $b ==1} {
        puts $hand_file "output         $a" 
    } elseif {$b != 1 && $len == $counter} {
        puts $hand_file "output  \[[expr $b-1]:0\]  $a" 
    } else {
        puts $hand_file "output  \[[expr $b-1]:0\]  $a," 
    }
   incr counter
}
puts $hand_file "\);"
close $hand_file
puts "****Ahmed Khalaf Mohamed ALi****"