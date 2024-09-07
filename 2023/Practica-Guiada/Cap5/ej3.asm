.data
	V: .word 1,-4,-5,2
	.align 2
	res: .space 1
.text
.globl 	main
main:
	li $t0,0	#Contador vector V
	li $t1,4	#Limite contador vector V
	la $t2,V	#Direccion contador V
	la $t3,res	#Direccion variable booleana
	loop:	beq $t0,$t1,exitLoop
		lw $t4,($t2)
		bgtz $t4,greaterThanZero
		addi $t0,$t0,1
		addi $t2,$t2,4
		j loop
	exitLoop:
	addi $t4,$0,1
	sw $t4,($t3)
	j exit
greaterThanZero:
	sw $0,($t3)
	j exit
exit:
	li $v0, 10
	syscall