.data
	myHalf: .half 0x1020
	placeHalf: .space 2
	myByte: .byte 0x10
	placeByte: .space 1
.text	
main: 	lh $s0, myHalf
	sh $s0, placeHalf
	lb $s1, myByte
	sb $s1, placeByte
	
	