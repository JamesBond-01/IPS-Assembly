.data
	length: .word 0
	string: .asciiz "Hola"
.text
	la $t0, string
	lb $t1, ($t0)
	addi $t2, $t2, 0
check:	
	beqz $t1, equalsZero
	addi $t2, $t2, 1
	addi $t0, $t0, 1
	j check
equalsZero:
	sw $t2, length
	li $v0, 10
	syscall