#Consigna:
#	Funcion recibe un puntero y deuvelve un word
#	Tomar un string y encontrar el numero de espacios
#	Buscar desde 0 hasta el length(String) => Largo de la cadena

#	funcion nspace {
#		funcion length(String)
#	}


.data
	myString: .asciiz "Esto es un string"
	resultMsg: .asciiz "\nTotal de espacios encontrados: "

.text
	main:
		la $a0, myString
		addiu $sp, $sp, -8
		jal nspace
		move $t0, $v0
		addiu $sp, $sp, 8
		
		#Muestra el string
		li $v0, 4
		syscall
		
		#Muestra el resultado
		la $a0, resultMsg
		li $v0, 4
		syscall
		move $a0, $t0
		li $v0, 1
		syscall

		li $v0, 10
		syscall
	nspace:
		sw $ra, 4($sp)
		jal length
		move $s0, $v0	#Almacena el resultado de length
		li $s1, 0	#Inicializa contador de letras en cero
		li $s2, 0	#Inicializa contador de espacios en cero
		add $s3, $a0, $0
		loop1:
			lb $s4, ($s3)
			beq $s0, $s1, endLoop1	#Termina el loop cuando el contador = length
			addi $s1, $s1, 1	#Suma 1 al contador de letras
			bne $s4, 32, endCountSpace #Si encuentra un espacio, le suma 1 al contador
			countSpace:
				addi $s2, $s2, 1
			endCountSpace:
			addi $s3, $s3, 1 #Pasa a la siguiente letra
			j loop1
		endLoop1:
		move $v0, $s2
		lw $ra, 4($sp)
		jr $ra

	length:
		sw $ra, ($sp)
		add $s0, $a0, $0
		loop2:
			lb $s2, ($s0) 
			beqz $s2, endLoop2
			addi $s1, $s1, 1 #Suma 1 al contador de caracteres
			addi $s0, $s0, 1 #Pasa a la siguiente letra
			j loop2
		endLoop2:
		move $v0, $s1
		lw $ra, ($sp)
		jr $ra