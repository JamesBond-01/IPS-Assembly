.data
	dato1: .word 2
	dato2: .word 10
	dato3: .word 50
	dato4: .word 70
	dato5: .word 34
	res: .space 4
.text
.globl main
main:	lw $t0, dato1
	lw $t1, dato2
	lw $t2, dato3
	lw $t3, dato4
	lw $t4, dato5
	li $t5, 1	#Resultado si se encuentra en uno de los intervalos
	#if((dato5 >= dato1) && (dato5 <= dato2))
	if: 	blt $t4, $t0, else
		bgt $t4, $t1, else
		sw $t5, res
		j exit
	#else if((dato5 >= dato3) && (dato5 <= dato4))
	else:	blt $t4, $t2, exit
		bgt $t4 $t3, exit
		sw $t5, res
exit:	li $v0, 10
	syscall
	
	
	
	
	