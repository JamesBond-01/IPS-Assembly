.data
	V: .word 2,-4,-6
	.align 2
	VB: .space 3
	
.text
.globl main
main:	li $t0, 0	#Contador vector V
	li $t1, 3	#Limite del loop
	la $t2, V	#Direccion vector V
	la $t3, VB	#Direccion vector bool
	loop:	beq $t0, $t1, exit
		lw $a0, ($t2)
		jal comp
		sb $v0, ($t3)
		addi $t0, $t0, 1
		addi $t2, $t2, 4
		addi $t3, $t3, 1
		j loop
comp:	
	sge $v0, $a0, $0
	jr $ra
exit:
	li $v0, 10
	syscall