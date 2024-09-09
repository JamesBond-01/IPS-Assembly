.data
	list: .word 5,20,10,500,8,1		#Valor del contador = n-1 = 5
	#Luego del primer loop: 5,10,20,8,1,500	#Valor del contador = 4
	#Luego del segundo loop: 5,10,8,1,20,500	#Valor del contador = 3
	#Luego del tercer loop: 5,8,1,10,20,500	#Valor del contador = 2
	#Luego del cuarto loop: 5,1,8,10,20,500	#Valor del contador = 1
	#Luego del quinto loop: 1,5,8,10,20,500	#Valor del contador = 0
	size: .word 5	#Tamaño de la lista - 1
.text
	lw $t3, size	#Inicializa el contador1
	li $t4, 4		#Inicializa el contador2
loop1:	la $t0, list	#Direccion de memoria de la lista
loop2:	lw $t1, ($t0)	#Carga numero 1
	lw $t2, 4($t0)	#Carga numero 2
	bgt $t1, $t2, swap	#Si numero 1 > numero 2, realiza swap
	addi $t0, $t0, 4	#Apunta la direccion de memoria al siguiente numero
	addi $t3, $t3, -1	#Resta uno al contador
	bnez $t3, loop2	#Vuelve a ejecutar el loop
swap:	sw $t2, ($t0)	#Numero 2 se almacena en el lugar de numero 1
	sw $t1, 4($t0)	#Numero 1 se almacena en el lugar de numero 2
	addi $t0, $t0, 4	#Apunta la direccion de memoria al siguiente numero
	addi $t3, $t3, -1	#Resta uno al contador
	bnez $t3, loop2	#Mientras el contador1 no sea cero, se sigue ejecutando el loop para recorrer el array
	addi $t4, $t4, -1	#Resta 1 al contador 2
	bnez $t4, loop1	
exit:	li $v0, 10		#Exit
	syscall