  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #

  .global hexasc
  .global delay
  .global time2string
  .global enable_interrupt
  .data
  .align 2
  .text

hexasc:
  # push registers that will be used
  andi $t0, $a0, 15 # Masking a with 1111 to get the 4lsb, thus 17 (10001) and is masked to 0001
  and $a0, $a0, $zero

  sltiu  $t1, $t0, 10 #$t0 is our input value and thus is our taken branch
  beq $t1, $zero, false
  nop
  addi $v0, $t0, 48
  jr $ra
  nop
false:
  addi $v0, $t0, 55
  jr $ra
  nop

delay:
  #addi $sp $sp 48    # Making space for were the tick program saves the current time (shift $sp 24 bits)
  PUSH $s0    # int ms
  PUSH $s1    # int i

  and $s0, $s0, $zero # clear $s0
  and $s1, $s1, $zero # clear $s1

  add $s0, $s0, $a0   # ms is stored in $t0
  and $a0, $a0, $zero # clear $a0
while_loop:
  slt $t0, $zero, $s0
  beq $t0, $zero, end_loop
  nop
  addi $s0, $s0, -1
  and $s1, $s1, $zero
for_loop:
  slti $t0, $s1, 4711
  beq $t0, $zero, while_loop
  nop
  addi $s1, $s1, 1
  nop
  j for_loop
  nop
end_loop:
  POP $s1
  POP $s0
  #addi $sp $sp -48   # Making space for were the tick program saves the current time (shift $sp 24 bits)
  jr $ra
  nop
 
time2string:
  
  PUSH $s0
  PUSH $s1

  and $s0, $s0, $zero # clear $a0
  and $s1, $s1, $zero # clear $a1
  or $s0, $s0, $a0   # store $a0 in $s0
  andi $s1, $a1, 0xFFFF # mask $a1 into $s1
  and $a0, $a0, $zero # clear $a0
  and $a1, $a1, $zero # clear $a1

  # Minute tens position
  srl $a0, $s1, 12    # Shift by 3 nibbles to the right (3*4=12 bits)
  
  PUSH $ra
  jal hexasc
  nop
  POP $ra
  
  sb $v0, 0($s0)    # Store the ASCII byte that represents minute tens into memory
  
  # Minute ones position
  andi $a0, $s1, 0x0F00
  srl $a0, $a0, 8
  
  PUSH $ra
  jal hexasc
  nop
  POP $ra
  
  sb $v0, 1($s0)

  # Colon ASCII
  and $t0, $t0, $zero
  ori $t0, $t0, 0x3A  # Stores ASCII code for colon
  sb $t0, 2($s0)
  
  # Seconds tens position
  andi $a0, $s1, 0x00F0
  srl $a0, $a0, 4
  
  PUSH $ra
  jal hexasc
  nop
  POP $ra
  
  sb $v0, 3($s0)
  
  # Seconds ones position
  andi $a0, $s1, 0x000F
  
  PUSH $ra
  jal hexasc
  nop
  POP $ra
  
  sb $v0, 4($s0)
  
  # Null ASCII
  and $t0, $t0, $zero
  ori $t0, $t0, 0x00
  sb $t0, 5($s0)

  POP $s1
  POP $s0
  
  jr $ra
  nop
enable_interrupt:
  ei
  jr $ra