.data
	number : .word 0xffffff41
	.space 4
.text
	main : lw $s0 , number	#1111 1111 1111 1111 1111 1111 0100 0001 = 0xffffff41
	sll $s1, $s0 , 4	#
	sw $s1, number+4	