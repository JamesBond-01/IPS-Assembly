.data
	V: .word 1,0,2,3,0,4,0,0
	cant: .word 8
	total: .space 4
.text
.globl	main
main:	la $t0, V
	li $t1, 0	#Contador de elementos del vector
	lw $t2, cant
	li $t3, 0	#Contador de ceros
	loop:	beq $t1, $t2, exit
		addi $t1, $t1, 1
		lw $t4, ($t0)
		addi $t0, $t0, 4
		bnez $t4, loop
		addi $t3, $t3, 1
		j loop
	exit:
	sw $t3, total
	li $v0, 10
	syscall