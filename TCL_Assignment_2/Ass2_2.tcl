puts "****I/O file and RTL****"
set file_hand [open rtl.txt r+]
set file_data [read $file_hand]
puts "$file_data"
set designs {}
regsub -all "\n" $file_data " " designs 
puts "$designs"
close $file_hand
puts "****Ahmed Khalaf Mohamed ALi****"