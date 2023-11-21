.data
	V: .byte 0,1,1,1,0
	.align 2
	res: .space 3
.text
.globl main
main:
	lb $t0, V	#Carga V[1]
	lb $t1, V+1	#Carga V[2]
	lb $t2, V+2	#Carga V[3]
	lb $t3, V+3	#Carga V[4]
	lb $t4, V+4	#Carga V[5]
	
	#res[1]= (V[1] and V[5])
	and $t5, $t0, $t4
	sb $t5, res
	
	#res[2]=(V[2] or V[4])
	or $t6, $t1, $t3
	sb $t6, res+1
	
	#res[3]=((V[1] or V[2]) and V[3])
	or $t7 $t0, $t1
	and $t8, $t7, $t2
	sb $t8, res+2