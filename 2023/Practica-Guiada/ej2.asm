.data
number : .word 0x12345678
num2: .word 0x567
.text #zona de i n s t r u c c i o n e s

main: 	lui $s0,0x8690
	lui $s1, 0x1234
	la $s2 , number
	lw $s3, 0($s2)
	li $t0, 4
	lw $s4, number($t0)