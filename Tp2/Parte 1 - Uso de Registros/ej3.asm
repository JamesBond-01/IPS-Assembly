.data 0x10010002
	vectorBytes: .byte 0x10, 0x20, 0x30, 0x40
	.align 3		#0x10010008
	.space 2		#0x10010010
	myWord: .space 4	#Reserva espacio a partir de la direccion 0x10010010
.text
	#Almacena los 4 elementos en el registro
	lb $t0, vectorBytes
	lb $t1, vectorBytes+1
	lb $t2, vectorBytes+2
	lb $t3, vectorBytes+3
	
	#Almacena los bytes del registro en la nueva direccion de memoria
	sb $t0, myWord
	sb $t1, myWord+1
	sb $t2, myWord+2
	sb $t3, myWord+3
	
	#Exit
	li $v0, 10
	syscall