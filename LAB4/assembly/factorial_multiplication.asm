main:
addi $a0, $zero, 4
factorial: 
addi $a1, $a0, -1
factorial_loop: 
#a0 is int
#s2 is total
	#add $a1, $zero, $a0
	add $v0 $zero, $zero
	beq $zero $zero multi_loop
	temp:
	nop
	add $a0, $0, $v0 #add result of multiplication to total
#at the end we remove one from the number
	beq $a1, $zero, end
	addi $a1, $a1, -1
	beq $zero $zero factorial_loop
multi_loop:
#x*y
#a0 is x
#a1 is y, the number to repeat x by
#s1 is i for loop
	add $v0, $v0, $a0
	addi $s1, $s1, 1
	beq $a1 $zero end
	nop
	beq $a1, $s1 mult_end
	nop
	beq $zero, $zero multi_loop
	nop
mult_end: 
	nop
	and $s1 $zero $zero
	and $s0 $zero $zero
	beq $zero $zero temp
	nop
end:
	j end
	
	
