  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,9	# change this to test different values
	

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register v0->a0

	li	$v0,11		# syscall with v0 = 11 will print out
	
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
  #
hexasc: 

	andi $a0, $a0, 15  	#answer to question 1. masking stops us from having anything but the last 4 digits
	sltiu $t0, $a0, 10  	#a0 is the branch variable. 
	beq $t0, $zero, false	
	addi $v0, $a0, 48
	jr $ra 		
false:
	addi $v0, $a0, 55
	jr $ra
		# jump to return address 
	
	
	
	
	

