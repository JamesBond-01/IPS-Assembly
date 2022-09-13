.data
		numero: .word 0x3ff41	# 00111111111101000001
.space 4
.text
		main: lw $t0,numero($0)		#	00111111111101000001	= 0x3ff41
		andi $t1,$t0,0x3ff47		# 	00111111111101000111	= 0x3ff47
		sw $t1,numero+4($0)			#	00111111111101000001	= 0x3ff41