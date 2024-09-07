.data
number : .word 0x12345678
.text
main: 	lh $s0 , number + 2
	lh $s1, number
	lb $s2, number + 1