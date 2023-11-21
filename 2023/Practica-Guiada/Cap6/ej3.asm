.data
	V: .word 10,40,56,77,80
	rango1: .word 20
	rango2: .word 70
	cant: .word 5
	res: .word 4
.text
.globl	main
main:	la $t0, V
	li $t1, 0	#Contador vector V
	lw $t2, cant
	lw $t3, rango1
	lw $t4, rango2
	li $t5, 0	#Contador numeros dentro del rango
	loop:	beq $t1, $t2, exit
		addi $t1, $t1, 1
		lw $t6, ($t0)
		addi $t0, $t0, 4
		blt $t6, $t3, loop
		bgt $t6, $t4, loop
		addi $t5, $t5, 1
		j loop
	exit:
	sw $t5, res
	li $v0, 10
	syscall
		
		
		
		
		
		
		
		
	
	