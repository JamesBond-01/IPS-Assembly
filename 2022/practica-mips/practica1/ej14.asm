.data 0x10000000
	num: .word 0xabcd12bd
	result: .space 4
.text
	lw $t0, num					#10101011110011010001001010111101 = 0xabcd12bd
	andi $t1, $t0, 0xabcd1035	#10101011110011010001000000110101 = 0xabcd1035
	sw $t1, result				#10101011110011010001000000110101 = 0xabcd1035