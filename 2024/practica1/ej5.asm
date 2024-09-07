.data
	matrizA_Filas: .word 1,2,3,4,5,6,7,8,9
	matrizA_Columnas: .space 40 # 1,4,7,2,5,8,3,6,9
.text
	lui $1, 0x00001000
	lw $8, ($1)			#1
	lw $9, 4($1)			#2
	lw $10, 8($1)			#3
	lw $11, 12($1)			#4
	lw $12, 16($1)			#5
	lw $13, 20($1)			#6
	lw $14, 24($1)			#7
	lw $15, 28($1)			#8
	lw $24, 32($1)			#9
	sw $8, matrizA_Columnas		#Guarda 1
	sw $11, matrizA_Columnas + 4	#Guarda 4
	sw $13, matrizA_Columnas + 8	#Guarda 7
	sw $9, matrizA_Columnas	+ 12	#Guarda 2
	sw $12, matrizA_Columnas + 16	#Guarda 5
	sw $15, matrizA_Columnas + 20	#Guarda 8
	sw $10, matrizA_Columnas + 24	#Guarda 3
	sw $13, matrizA_Columnas + 28	#Guarda 6
	sw $24, matrizA_Columnas + 32	#Guarda 9