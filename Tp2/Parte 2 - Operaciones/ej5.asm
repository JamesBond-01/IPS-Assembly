.data 0x10000000
	num: .word 0x1237
.text
	main: 	
		lw $t0, num
		sll $t1, $t0, 5	#Multiplica el numero por 32	
		
		#Exit
		li $v0, 10
		syscall
		
