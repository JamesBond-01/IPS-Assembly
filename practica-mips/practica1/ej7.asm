.data 0x10000000
		V: .word 10,20,25,500,3
.text
main:	lw $s0, V
		lw $s1, V + 4
		lw $s2, V + 8
		lw $s3, V + 12
		lw $s4, V + 16