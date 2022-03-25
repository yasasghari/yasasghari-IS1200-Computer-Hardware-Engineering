#1 miss, best
#worst, miss
foo:
addi $v0,$0,0
addi $t1,$0,0
outer:
addi $t2,$0,0
slt $t0,$t1,$a1
#2nd miss, best
#worst miss
beq $t0,$0,exit
inner:
slt $t0,$t2,$t1
beq $t0,$0,skip
body:
mul $t0,$t1,$a1
#worst miss 
add $t0,$t0,$t2
sll $t0,$t0,2
add $t0,$t0,$a0
lw $t3,0($t0)
#worst miss
add $v0,$v0,$t3
addi $t2,$t2,1
j inner
skip:
addi $t1,$t1,1
#3rd miss best
#worst miss
j outer
exit:
jr $ra
nop
nop

