puts "****Bitwise Operations****"
# 010100
set a 20 
# 000101
set b 5
# 001001
set c 9
# 000000 = 'd0
set var0 [expr $a & $c]
# 010101 = 'd21
set var1 [expr $a | $b]
# 000000 = 'd0
set var2 [expr $a ^ $a]

puts "var0 : $var0"

puts "var1 : $var1"

puts "var2 : $var2"