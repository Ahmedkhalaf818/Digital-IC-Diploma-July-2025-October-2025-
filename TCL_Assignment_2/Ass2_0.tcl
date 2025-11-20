puts "****Assignment 2.0****"
set cities [list cairo alexandria damietta dakahlia faiyum sohag aswan]
set Cities_New {}
foreach x $cities {
    set first [string toupper [string range $x 0 0]]
    set rest [string tolower [string range $x 1 end]]
    lappend  Cities_New $first$rest
}
foreach y $Cities_New {
    puts "$y"
}
puts "****Ahmed Khalaf Mohamed ALi****"