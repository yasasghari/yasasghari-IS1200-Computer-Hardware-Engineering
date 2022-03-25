  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro
###############EDVIN FROSTERUD
############### TIMER ASSIGMENT 
.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x0415
timstr:	.ascii "Timer Assignment 4\nStarting timer! EF\n\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,2
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  # you can write your code for subroutine "hexasc" below this line
  #
  hexasc: 
	PUSH $a0
	
	andi $a0, $a0, 15  	#answer to question 1. masking stops us from having anything but the last 4 digits
	sltiu $t0, $a0, 10  	#a0 is the branch variable. 
	beq $t0, $zero, false	
	addi $v0, $a0, 48
	j return
	nop
false:
	addi $v0, $a0, 55
	j return
	nop
delay: 
	#push and pop current values $s 
	addi $sp $sp 48
	PUSH $s0 	#int ms
	PUSH $s1	#int i
	PUSH $s2	#bool for both

	
	#we're pushing these for reset later at the end of while-loop
	
	add $s0 $zero $a0 #milliseconds is in t0 currently
	#and $a0 $zero $a0 #clearing argument for further use in main
	
while: 
	
	slt $s2, $zero, $s0 #inside while-loop check
	beqz $s2, end
	nop
	#ms = ms-1
	addi $s0 $s0 -1
	and $s1 $s1 $zero
for:
	slti $s2 $s1 4711
	#for(i = 0 ; i < 4711 ; i++) 
	beq $s2, $0, while
	nop
	addi $s1 $s1 1
	
	j for
	nop
end: 
	addi $sp $sp -48
	POP $s2
	POP $s1
	POP $s0
	jr $ra
	
return:  #the return function is just to return for both f-false and hexasc
	POP $a0
	jr $ra
	nop
time2string:

    la $a0 timstr

    andi $a1 $a1 0xFFFF 	#Masking away everything but the last 16 bits 
    andi $sp $sp 0x00	 	#Clearing $sp pointer
    or $sp $sp $a0	 	#Changing pointer to point at $a0, the address timestr 
    addi $sp $sp 24	 	#Adding 24 to the address. this is making space for our numbers. The program we got is saving 
    # currentTime at a0, pos 0. we're making space by shifting 24 bits. we could probably change our time2string to be
    # using a different variable, but that would require changes to our hexasc. 

    # position X0:00
    srl $a0 $a1 12 	# shift 3 nibbles which is 4*3 = 12. we've already masked this on L103
    jal hexasc		#our hexasc uses a0 as input and v0 as output 
    la $a0 timstr	#we're then resetting a0 to be their timestr that was in the original function
    sb $v0 0($a0)	#store byte in a0 at current pointer location

    # position 0X:00
    andi $a0 $a1 0x0F00	 #repeat previous steps
    srl $a0 $a0 8
    jal hexasc
    la $a0 timstr
    sb $v0 1($a0)

    # Colon ASCII
    andi $a2 $a2 0x0 #just pushes colon into the current pointer pos at a0, offset by 2 
    ori $a2 $a2 0x3A
    la $a0 timstr
    sb $a2 2($a0)

    # Seconds tens position
    andi $a0 $a1 0x00F0 #same thing as previous just masking away so we make sure we only have one number at a time
    srl $a0 $a0 4
    jal hexasc
    la $a0 timstr
    sb $v0 3($a0)

    # Seconds ones position
    andi $a0 $a1 0x000F # and same as previous
    jal hexasc
    la $a0 timstr
    sb $v0 4($a0)

    	# NewLine ASCII
    andi $a2 $a2 0x0	 #this is just adding a newline, similar to colon and null 
    ori $a2 $a2 0xA
    la $a0 timstr
    sb $a2 5($a0)

    	# Null ASCII
    andi $a2 $a2 0x0 	# null because it said so lol 
    ori $a2 $a2 0x00
    la $a0 timstr
    sb $a2 6($a0)

	#resetting to before subroutine, cause that was apart of hte assignment. 
    la $a0 timstr	
    andi $sp $sp 0x00
    or $sp $sp $a0

    j main
    nop
	
