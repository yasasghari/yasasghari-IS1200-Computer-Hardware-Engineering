  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp, $sp, -4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #

.global delay
.global time2string
################hexasc function
#
hexasc: 
	andi $a0, $a0, 15  	#answer to question 1. masking 
	slti $t0, $a0, 10  	#t0 is the branch variable. 
	beq $zero, $t0, true
	addi $v0, $a0, 48
	jr $ra
	nop
true:
	addi $v0, $a0, 55
	jr $ra
	nop

##########################################DELAY() FUNCTION
delay: 
#a0 = ms 
#t0 = i
#t3 = truthiness 
  while: 
    beq $a0, $zero, endOfLoop
    nop
    addi $a0, $a0, -1 #ms = ms -1
    and $t0, $t0, $zero #i = 0; 
    li $t1, 4630

    for:
      beq $t0, $t1, while
      nop
      addi $t0, $t0, 1
      j for
      nop

endOfLoop: 
	jr $ra
  nop
	



###########################################time2string function
time2string: #uses a1, a0
    PUSH $ra    #pushing returnaddress for use in the end of t2string. because we're using jr we're otherwise gonna overwrite it 
    PUSH $s0
    PUSH $s1

    add $s0, $zero, $a0 
    add $s1, $zero, $a1
    andi $s1, $s1, 0xFFFF 	#Masking away everything but the last 16 bits

    # position X0:00
    srl $a0, $s1, 12 	# shift 3 nibbles which is 4*3 = 12. we've already masked this on L103
    jal hexasc
    nop #our hexasc uses a0 as input and v0 as output 
    sb $v0, 0($s0)	#store byte in s0 at current pointer location

    # position 0X:00
    #andi $a0, $s1, 0x0F00	 #repeat previous steps
    srl $a0, $s1, 8
    jal hexasc
    nop
    sb $v0, 1($s0)

    # Colon ASCII
    ori $a0, $zero, 0x3A
    sb $a0, 2($s0)
    

    # ones position position
    #andi $s0, $s1, 0x00F0 #same thing as previous just masking away so we make sure we only have one number at a time
    srl $a0, $s1, 4
    jal hexasc
    nop
    sb $v0, 3($s0)

    # Seconds ones position
    #andi $a0, $s1, 0x000F # and same as previous
    or $a0, $s1, $zero
    jal hexasc
    nop
    sb $v0, 4($s0)

    ## NewLine ASCII
    #addi $a0, $zero, 0xA
    #sb $v0, 5($s0)

    	# Null ASCII
    sb $0, 5($s0)


	#resetting to before subroutine, cause that was apart of hte assignment. 
    POP $s1
    POP $s0
    POP $ra

    j $ra
    nop
	
