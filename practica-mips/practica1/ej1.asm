.data
		dato: .byte 3 #inicializo una posición de memoria a 3
.text
.globl main # debe ser global
main: 	lw $t0,dato($0)



#Directivas: .data	.text	.globl	.byte
#Comentarios:	"inicializo una posición de memoria a 3"	"debe ser global"
#Etiquetas:	dato	main