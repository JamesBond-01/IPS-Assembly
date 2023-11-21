.data
	V: .word 1,2,2,3,3,3,4,4,4,4
	n: .word 10
.text
.globl	main
main:	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $a0, V
	lw $a1, n
	li $a2, 5
	jal countEquals
	move $t0, $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $v0, 10
	syscall
	jr $ra
countEquals:
	li $t0, 0	#Contador de numeros coincidentes
	move $t1, $a0	#Direc V
	move $t2, $a1	#Cantidad de elementos
	move $t3, $a2	#Numero a comparar
	li $t4, 1	#Contador de V
	loop:	beq $t4, $t2, endloop
		addi $t4, $t4, 1
		lw $t5, ($t1)
		addi $t1, $t1, 4
		bne $t5, $t3, loop
		addi $t0, $t0, 1
		j loop
	endloop:
	move $v0, $t0
	jr $ra
		