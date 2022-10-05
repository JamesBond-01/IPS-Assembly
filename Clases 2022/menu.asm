.data
		option: .asciiz "Ingrese su nombre\nIngrese su apellido\nIngrese su DNI"
.text
		li $v0, 4
		la $a0, option
		syscall