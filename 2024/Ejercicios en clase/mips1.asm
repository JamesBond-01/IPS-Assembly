.data
	l1: .word 4
	l2: .word 5
	l3: .space 4
	resultMessage: .asciiz "El resultado es "
.text
	#Carga l1 y l2 usando pseudoinstrucciones
	lw $t0, l1
	lw $t1, l2
	#Suma $t0 y $t1
	add $t2, $t0, $t1
	#Guarda el resultado de la suma en el espacio reservado por l3
	#usando pseudoinstrucciones
	sw $t2, l3
	#Muestro el resultado en la consola
	la $a0, resultMessage
	li $v0, 4
	syscall
	add $a0, $0, $t2
	li $v0, 1
	syscall
	#Exit
	li $v0, 10
	syscall