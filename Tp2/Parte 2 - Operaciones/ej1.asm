.data 0x10000000
	vectorInt: .word 10, 20
	result: .space 4
.text
	#Carga los valores del vector en el registro
	lw $s0, vectorInt
	lw $s1, vectorInt+4
	
	#Suma ambos numeros y almaceno su resultado en memoria
	add $s2, $s1, $s0
	sw $s2, result
	
	#Exit
	li $v0, 10
	syscall