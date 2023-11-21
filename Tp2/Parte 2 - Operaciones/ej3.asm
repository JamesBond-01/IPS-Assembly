.data 0x10000000
	num1: .word 0xabcd12bd
.text
	lw $s0, num1			#1010 1011 1100 1101 0001 0010 1011 1101 = 0xabcd12bd
	andi $s1, $s0, 0xabcd1035	#1010 1011 1100 1101 0001 0000 0011 0101 = 0xabcd1035
	
	#Exit
	li $v0, 10
	syscall