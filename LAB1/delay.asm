
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
main:

delay: 
	#push and pop current values $s 
	PUSH $s0 	#int ms
	PUSH $s1	#int i
	PUSH $s2	#bool for both
	
	#we're pushing these for reset later at the end of while-loop
	
	add $s0 $zero $a0 #milliseconds is in t0 currently
	and $a0 $zero $a0 #clearing argument for further use in main
	
while: 
	slt $s2, $zero, $s0 #inside while-loop check
	beqz $s2, end
	nop
	#ms = ms-1
	addi $s0 $s0 -1
for:
	and $s1 $s1 $zero
	slti $s2 $s1 4711
	#for(i = 0 ; i < 4711 ; i++) 
	beq $s2, $0, while
	nop
	addi $s1 $s1 1
	
	j for
end: 
	POP $s2
	POP $s1
	POP $s0
	
	
