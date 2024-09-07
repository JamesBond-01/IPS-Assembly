.data
	num: .word 0x10203040
	numBytesInv: .space 4
	numHalfInv: .space 4
.text
	#Descompone en bytes la palabra y almacena
	#los bytes en registros
	lb $t0, num
	lb $t1, num+1
	lb $t2, num+2
	lb $t3, num+3
	
	#Almacena en memoria los bytes invertidos
	sb $t3, numBytesInv
	sb $t2, numBytesInv+1
	sb $t1, numBytesInv+2
	sb $t0, numBytesInv+3
	
	#Descompone en half la palabra y almacena
	#sus mitades en dos registros
	lh $t0, num
	lh $t1, num+2
	
	#Almacena en memoria los half invertidos
	sh $t1, numHalfInv
	sh $t0, numHalfInv+2
	
	#Exit
	li $v0, 10
	syscall