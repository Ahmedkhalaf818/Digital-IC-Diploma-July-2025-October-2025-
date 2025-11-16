# Digital-IC-Diploma-July-2025-October-2025-
The Diploma enhanced my skills in RTL design, Functional Verification, Tcl, Synthesis, Clock Domain Crossing (CDC), power reduction techniques, Static Timing Analysis (STA), Design for Testability (DFT), Formal Verification, Place and Route (PNR), and Gate-Level Simulation (GLS).

Over the past three months (July 2025 – October 2025), I’ve been fully dedicated to expanding my knowledge and skills — and I’m excited to share that I’ve officially completed the Digital IC Design Diploma under the supervision of Eng.Ali M. Eltemsah, achieving an Excellent grade! 🎖️

The diploma was very helpful. It was divided into interactive sessions and highly valuable assignments with detailed feedback. After correcting the mistakes in each assignment, we moved on to the final project.

As shown in the repo, there are 20 assignments. Let’s go in depth for each assignment and explain how I created them.

# Assignment 1:
This is just basic training for Verilog and digital circuits. It contains sequential logic and combinational logic in always statements, and uses a modular hierarchy with each logic type in a separate always block.

it is shown in Digital-IC-Diploma-July-2025-October-2025-/tree/main/Ass1/DigCt.v

# Assignment 2:

this is UP_down_counter ,the code functionality cover all senarios 
when get down and sounter is zero
when get up and counter is max value 
when get load and up or down or both in same time what doing 

it is shown in Digital-IC-Diploma-July-2025-October-2025-/tree/main/Ass2/Up_Dn_Counter.v

# Assignment 3:

This is ALU 16 bits , the code functionality cover all scenarios no there latches 
4'b0000 => sum
4'b0001 => subtraction
4'b0010 => Multiplication
4'b0011 => Division
4'b0100 => logic And
4'b0101 => logic or
4'b0110 => logic nAnd
4'b0111 => logic nor
4'b1000 => logic xor
4'b1001 => logic xnor
4'b1010 => equal comparator 
4'b1011 => greater than comparator
4'b1100 => less than comparator 
4'b1101 => shift right
4'b1110 => shift left
default: no logic just out zero

there are flags to each block there are 4 blocks with 4 flags 
Arith_flag : contain (4'b0000 , 4'b0001 , 4'b0010 , 4'b0011)
Logic_flag : contain (4'b0100 , 4'b0101 , 4'b0110 , 4'b0111 , 4'b1000 , 4'b1001 , )
CMP_flag   : contain (4'b1010 , 4'b1011 , 4'b1100)
Shift_flag : contain (4'b1101 , 4'b1110)

it is shown in Digital-IC-Diploma-July-2025-October-2025-/tree/main/Ass3/ALU_16B.v

# Assignment 4: