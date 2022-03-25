
        # pointers.asm
# By David Broman, 2015-09-14
# This file is in the public domain


.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

.data


text1: 	  .asciiz "This is a string."
text2:	  .asciiz "Yet another thing."

.align 2
list1: 	.space 80
list2: 	.space 80
count:	.word  0

.text
main:
	jal	work
stop:	j	stop

# function work()
work:
	PUSH	($ra)
	la  	$a0,text1	#prep for copycodes which has 3 parameters 
	la	$a1,list1
	la	$a2,count
	jal	copycodes	#calling copycodes
	
	la 	$a0,text2
	la	$a1,list2
	la	$a2,count
	jal	copycodes
	POP	($ra)
	
	
# function copycodes()
copycodes:
loop:
	lb	$t0,0($a0) 	#sets t1 to be the same as a0 
	beq	$t0,$0,done
	sw	$t0 ,0($a1)	#then sends it back to the wrong address, a1, which represents the inlist

	addi	$a0,$a0,1	#a byte long 8 bits
	addi	$a1,$a1,4	#4 bites down, int 32 bits = 4*8 
	
	lw	$t1,0($a2)	#loads count from memory, an int count
	addi	$t1,$t1,1 	#adds 1 to count
	sw	$t1,0($a2)	#this is taking the now modified(+1) val of count and putting it back in a2
	j	loop
done:
	jr	$ra
		



