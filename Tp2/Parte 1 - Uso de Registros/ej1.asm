.data 0x10000000 
	vectorInt: .word 10, 20, 25, 500, 3
.text
	#Carga valores del vector a los registros
	lw $s0, vectorInt
	lw $s1, vectorInt + 4
	lw $s2, vectorInt + 8
	lw $s3, vectorInt + 12
	lw $s4, vectorInt + 16
	
	#Almacena la direccion en la que quiero almacenar
	li $t0, 0x10010000
	
	#Guarda valores de los registros a la memoria
	sw $s0, ($t0)
	sw $s1, 4($t0)
	sw $s2, 8($t0)
	sw $s3, 12($t0)
	sw $s4, 16($t0)
	
	#Exit
	li $v0, 10
	syscall