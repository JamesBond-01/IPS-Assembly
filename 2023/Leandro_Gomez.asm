.data
	msgLadoA:	.asciiz "Introduzca A: "
	msgLadoB:	.asciiz "Introduzca B: "
	msgLadoC:	.asciiz "Introduzca C: "
	resMsg:		.asciiz "El area cuadrada es: "
.text
.globl	main
main:	
	#Input lado A
	la $a0, msgLadoA
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	beqz $t0, exit
	
	#Input lado B
	la $a0, msgLadoB
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	beqz $t1, exit
		
	#Input lado C
	la $a0, msgLadoC
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	beqz $t2, exit
		
	#Mueve todos los inputs para pasar como parametro
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
			
	#Llamada a la funcion areasq
	addi $sp, $sp, -4
	sw $ra, 0($sp)	
	jal areasq
	move $s1, $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	#Output resultado
	la $a0, resMsg
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall
	
	#Exit
exit:	li $v0, 10
	syscall
	jr $ra
	
areasq:
	#Llamada a la funcion semip
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	jal semip
	move $s0, $v0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	#Operaciones con el resultado S de semip
	sub $t3, $s0, $t0	#S-A
	sub $t4, $s0, $t1	#S-B
	sub $t5, $s0, $t2	#S-C
	mult $s0, $t3		#S*(S-A)
	mflo $t6
	mult $t6, $t4		#S*(S-A)*(S-B)
	mflo $t6
	mult $t6, $t5		#S*(S-A)*(S-B)*(S-C)
	mflo $v0
	jr $ra
	
semip:
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	add $t3, $t0, $t1	#A+B
	add $t4, $t2, $t3	#(A+B)+C
	li $t5, 2
	div $t4, $t5		#((A+B)+C)/2
	mflo $v0
	jr $ra