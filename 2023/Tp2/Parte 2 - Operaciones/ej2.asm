.data 0x10000000
	num1: .word 18
	num2: .word -1215
.text
	#Carga valores en el registro
	lw $s0, num1
	lw $s1, num2
	
	#Carga la constante por la que deseo dividir ambos numeros
	li $t0, 5
	
	#Division de ambos numeros por la constante
	div $s0, $t0
	mflo $s2
	div $s1, $t0
	mflo $s3
	
	#Carga la direccion de memoria donde deseo almacenar los cocientes
	la $t1, 0x10010000
	
	#Guarda los cocientes en la memoria
	sw $s2, ($t1)
	sw $s3, 4($t1)
	
	#Exit
	li $v0, 10
	syscall
	