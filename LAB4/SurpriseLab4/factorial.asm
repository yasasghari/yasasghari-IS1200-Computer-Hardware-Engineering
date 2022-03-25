
.text

	addi $a0 $a0 5  	#input value N
	addi $a1 $a0 -1 	#$a1 starts at N-1 
	add $a2 $a2 $a1 	#a2 is N-1
	addi $v0 $0 1

factorial: 
	beq $a0 $0 stop  	#check zero basecase
	add $0 $0 $0 		#NOP
	beq  $a1 $0 stop		#check if reached end of factorial sequence
	add $0 $0 $0 		#NOP
	add $v0 $0 $0 		#resetting sum to 0
	add $at $0 $a1
	
mul: 
	beq $at $0 continue 	#check number of iterations left in the loop
	add $0 $0 $0 		#NOP
	add $v0 $v0 $a0		#add current a0 to v0 
	addi $at $at -1 	#decrement by 1
	beq $0 $0 mul		#repeating iteration
	add $0 $0 $0 		#NOP
	
continue: 
	addi $a1 $a1 -1 	#decrement a1
	add $a0 $0 $v0		#change a0 to be the current return value
	beq $0 $0 factorial	#return to the factorial loop
	add $0 $0 $0 		#NOP

stop:
	beq $0, $0, stop		#infinitly iterating the end loop
	add $0 $0 $0 #NOP		
