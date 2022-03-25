  # analyze.asm
  # This file written 2015 by F Lundevall
  # Copyright abandoned - this file is in the public domain.

	.text
main:
	li	$s0,0x30
loop:
	move	$a0,$s0		# copy from s0 to a0
	
	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window

	addi	$s0,$s0,3	# --- this line changes to change it to only print every third letter. 1 -> 3 
	
	li	$t0,0x5d       # --- originally was 0x5b = 91. 91 is not divisible by 3 therefore never hits it. 
				#changed this line ^ to be instead 5d, instead of 5b. which would change the number to 93 which is divisible by 3
	bne	$s0,$t0,loop 	#loop stops if s0 = 91, which never happens if it adds 3 every loop. 
	nop			# delay slot filler (just in case)

stop:	j	stop		# loop forever here
	nop			# delay slot filler (just in case)

