#  IMPORTANT NOTES:
#	Known issues:
#	1) When a non-empty category is deleted, the program does not remove all the objects inside of
#	   it automatically, they need to be taken away manually. It is known that this is not what
#	   the exercise requires.
		
		.macro read_int
		li $v0,5
		syscall
		.end_macro

		.macro print_label (%label)
		la $a0, %label
		li $v0, 4
		syscall
		.end_macro

		.macro done
		li $v0,10
		syscall
		.end_macro	

		.macro print_error (%errno)
		print_label(error)
		li $a0, %errno
		li $v0, 1
		syscall
		print_label(return)
		.end_macro

		.data
	slist: 	.word 0
	cclist: .word 0
	wclist: .word 0
	schedv: .space 32
	menu:	.ascii "Colecciones de objetos categorizados\n"
		.ascii "====================================\n"
		.ascii "1-Nueva categoria\n"
		.ascii "2-Siguiente categoria\n"
		.ascii "3-Categoria anterior\n"
		.ascii "4-Listar categorias\n"
		.ascii "5-Borrar categoria actual\n"
		.ascii "6-Anexar objeto a la categoria actual\n"
		.ascii "7-Listar objetos de la categoria\n"
		.ascii "8-Borrar objeto de la categoria\n"
		.ascii "0-Salir\n"
		.asciiz "Ingrese la opcion deseada: "
	error:	.asciiz "Error: "
	return:	.asciiz "\n"
	categoryName:.asciiz "\nIngrese el nombre de una categoria: "
	selCat:	.asciiz "\nSe ha seleccionado la categoria:"
	idObj:	.asciiz "\nIngrese el ID del objeto a eliminar: "
	objName:.asciiz "\nIngrese el nombre de un objeto: "
	success:.asciiz "La operación se realizo con exito\n\n"
	currentCatMsg: .asciiz "Estas en la categoria "	
	selectedCat: .asciiz "=> "
	separator: .asciiz " - "
	myError: .asciiz "La categoria no pudo ser eliminada porque no se encuentra vacia\n"
	notFound: .asciiz "El objeto no existe\n"
		.text
main:
	# initialization scheduler vector
	la $t0, schedv
	la $t1, newCategory
	sw $t1, 0($t0)
	la $t1, nextCategory
	sw $t1, 4($t0)
	la $t1, prevCategory
	sw $t1, 8($t0)
	la $t1, listCategories
	sw $t1, 12($t0)
	la $t1, delCategory
	sw $t1, 16($t0)
	la $t1, newObject
	sw $t1, 20($t0)
	la $t1, listObjects
	sw $t1, 24($t0)
	la $t1, delObject
	sw $t1, 28($t0)
main_loop:
	# show menu
	jal menu_display
	beqz $v0, main_end
	addi $v0, $v0, -1	# dec menu option
	sll $v0, $v0, 2         # multiply menu option by 4
	la $t0, schedv
	add $t0, $t0, $v0
	lw $t1, ($t0)
	la $ra, main_ret 	# save return address
    	jr $t1			# call menu subrutine
    	
main_ret:
    j main_loop		
main_end:
	done
	
menu_display:
	print_label(menu)
	read_int
	# test if invalid option go to L1
	bgt $v0, 8, menu_display_L1
	bltz $v0, menu_display_L1
	# else return
	jr $ra
	# print error 101 and try again
menu_display_L1:
	print_error(101)
	j menu_display
# --------------------------------- 1) Nueva categoria ---------------------------------
newCategory:
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	la $a0, categoryName	# input category name
	jal getBlock
	move $a2, $v0		# $a2 = *char to category name
	la $a0, cclist		# $a0 = list
	li $a1, 0		# $a1 = NULL
	jal addNode
	lw $t0, wclist
	bnez $t0, newCategory_end
	sw $v0, wclist		# update working list if was NULL
newCategory_end:
	li $v0, 0		# return success
	lw $ra, 4($sp)
	addiu $sp, $sp, 4
	jr $ra

# --------------------------------- 2) Siguiente categoria ---------------------------------
nextCategory:
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	la $a0, wclist
       	lw $t0, ($a0)
       	beqz $t0, noCategories
       	la $t1, 0($t0)		#Initialize the register that travels the list
	lw $t1, 12($t1)      	#puntero = puntero -> siguiente;
	sw $t1, wclist		#Update wclist with the next one
	beq $t1, $t0, singleCategory
	print_label(currentCatMsg)
       	lw $a0, 8($t1)       	#If it is not empty, store the name of the next category
       	li $v0, 4
       	syscall
	j prevNextCategory_end
noCategories:
       	print_error(201)
        syscall
        j prevNextCategory_end
        
singleCategory:
	print_label(currentCatMsg)
	lw  $a0, 8($t1)       	#If it is not empty, store the name of the current category
       	li $v0, 4
       	syscall
 	print_error(202)
 	j prevNextCategory_end
# --------------------------------- 3) Categoria anterior ---------------------------------
prevCategory:
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	la $a0, wclist
       	lw $t0, ($a0)	 	#Recover the Head from wclist and store it in $t0
       	beqz $t0, noCategories	#Check Error 201
       	la $t1, 0($t0)		#Initialize the register that travels the list
	lw $t1, 0($t1)      	#puntero = puntero -> anterior;
	sw $t1, wclist		#Update wclist with the previous one
	beq $t1, $t0, singleCategory
	print_label(currentCatMsg)
	lw $a0, 8($t1)       	#If it is not empty, store the name of the previous category
       	li $v0, 4
       	syscall
prevNextCategory_end:
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	jr $ra

# --------------------------------- 4) Listar categorias ---------------------------------
listCategories:
	la $a0, wclist		
       	lw $t0, ($a0)	 	#Recover the Head from wclist and store it in $t0
       	beqz $t0, listIsEmpty	#Check error 301  
       	la $t1, 0($t0)		#Initialize the register that travels the list
	print_label(selectedCat)
showCategory: 
	lw $a0, 8($t1)       	#If it is not empty, store the name of the current category
       	li $v0, 4
       	syscall
	lw $t1, 12($t1)      	#puntero = puntero -> siguiente;
	beq $t1, $t0, main_loop
       	bne $t1, $t0, showCategory
        jr $ra
listIsEmpty:
	print_error(301)
	jr $ra

# --------------------------------- 5) Borrar categoria actual ---------------------------------
delCategory:
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	la $a1, cclist
       	lw $t0, ($a1)	 	#Recover the Head from cclist and store it in $t0
       	beq $t0, $0, noCategoriesToDelete #Check error 401
	lw $a0, wclist		#a1: list address where node is deleted
       	lw $t0, 4($a0)	 	#Recover the address of wclist and store it in $t0
       	bne $t0, $0, categoryNotEmpty #Check if there are objects inside to print error message
       	lw $t7, ($a0)
       	sw $t7, wclist		#Change the wclist to the previous
	bne $a0, $t7, delNode	#Compare the address between the current and the previous
	sw $0, wclist	
	jal delNode
	print_label(success)
delCategory_end:
	lw $ra, 4($sp)
	addiu $sp, $sp, 4
	jr $ra

noCategoriesToDelete:
	print_error(401)
        j delCategory_end

categoryNotEmpty:
	print_label(myError)
        j delCategory_end
        
# --------------------------------- 6) Anexar objeto a la categoria actual ---------------------------------
newObject:
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	la $a0, cclist
       	lw $t0, ($a0)	 	#Recover the Head from cclist and store it in $t0
       	beq $t0, $0, noCategoryToAdd #Check error 501
	la $a0, objName
	jal getBlock
	move $a2, $v0 		#$a2 = *char to object name
	lw $t6, wclist
	la $a0, 4($t6)		#$a0 = Address of the node in the category
	jal addNode		#Adds content to the node
	la $a1, ($v0)		#$a1 = objectNode address
 	sw $a1, 4($t6)		#Updates Head
	bnez $t0, newObject_end
	print_label(success)
newObject_end:
	lw $ra, 4($sp)
	addiu $sp, $sp, 4
	jr $ra
	
noCategoryToAdd: 
    	print_error(501)
       	j newObject_end

# --------------------------------- 7) Listar objetos de la categoria ---------------------------------
listObjects:
	la $a0, cclist
       	lw $t0, ($a0)			#Recover the Head from cclist and store it in $t0
       	beq $t0, $0, noObjectsToShow	#Check error 602
	lw $a0, wclist			#Recover the Head from wclist and store it in $t0
       	lw $t0, 4($a0)
       	beq $t0, $0, noCategoriesCreated #Check error 601
       	move $t1, $t0
	li $t5, 0
printObject: 
	addi $t5, $t5, 1
	move $a0, $t5
	li $v0, 1
       	syscall
       	print_label(separator)
	lw $a0, 8($t1)       	#Store the name of the current category 
      	li $v0, 4
       	syscall
	lw $t1, 12($t1)      	# puntero = puntero -> anterior;
	beq $t1, $t0, main_loop
       	bne $t1, $t0, printObject
       	jr $ra
  	
noCategoriesCreated:
       	print_error(601)
       	jr $ra
       	
noObjectsToShow: 
	print_error(602)
       	jr $ra

# --------------------------------- 8) Borrar objeto de la categoria ---------------------------------
delObject:
	la $a0, cclist
       	lw $t0, ($a0)				#Recover the Head from cclist and store it in $t0
       	beq $t0, $0, noCategoriesExisting	#Check error 701
	lw $t7, wclist
       	#Take ID from input
       	print_label(idObj)
       	read_int
       	move $t3,$v0
       	move $a0, $a1
	li $t5, 1
	beq $t5, $t3, updateHead
	#If it is not the Head:
	lw $a0, 12($a0)		#Initialize the register that travels the list
	addi $t5, $t5, 1        #Adds 1 to the counter
findObject:
	beq $t5, $t3, delNode	#Compare the entered ID to the counter
	lw $a0, 12($a0)
	addi $t5, $t5, 1	#Adds 1 to the counter
	beq $a0, $a1, objNotFound #Check error notFound
	j findObject
	
updateHead: 	
	#If it is the Head:
	lw $t2, 12($a0)	
		
	sw $t2, 4($t7) 		#Update Head to the next
	#If the address that is being removed is the Head and it equals to the previous, it means that it is the only one.
	#Therefore, address will be 0 to indicate that the object list is empty
	bne $t2, $a0, delNode
	li $t0, 0	
	sw $t0, 4($t7)
	j delNode
	
objNotFound:
	print_label(notFound)
	jr $ra
	  
noCategoriesExisting:
	print_error(701)
        jr $ra

# a0: list address
# a1: NULL if category, node address if object
# v0: node address added
addNode:
	addi $sp, $sp, -8
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	jal smalloc
	sw $a1, 4($v0) # set node content
	sw $a2, 8($v0)
	lw $a0, 4($sp)
	lw $t0, ($a0) # first node address
	beqz $t0, addNode_empty_list
addNode_to_end:
	lw $t1, ($t0) # last node address
 	# update prev and next pointers of new node
	sw $t1, 0($v0)
	sw $t0, 12($v0)
	# update prev and first node to new node
	sw $v0, 12($t1)
	sw $v0, 0($t0)
	j addNode_exit
addNode_empty_list:
	sw $v0, ($a0)
	sw $v0, 0($v0)
	sw $v0, 12($v0)
addNode_exit:
	lw $ra, 8($sp)
	addi $sp, $sp, 8
	jr $ra

# a0: node address to delete
# a1: list address where node is deleted
delNode:
	addi $sp, $sp, -8
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	lw $a0, 8($a0) # get block address
	jal sfree # free block
	lw $a0, 4($sp) # restore argument a0
	lw $t0, 12($a0) # get address to next node of a0 node
	beq $a0, $t0, delNode_point_self
	lw $t1, 0($a0) # get address to prev node
	sw $t1, 0($t0)
	sw $t0, 12($t1)
	lw $t1, 0($a1) # get address to first node again
	bne $a0, $t1, delNode_exit
	sw $t0, ($a1) # list point to next node
	j delNode_exit
delNode_point_self:
	sw $zero, ($a1) # only one node
delNode_exit:
	jal sfree
	lw $ra, 8($sp)
	addi $sp, $sp, 8
	jr $ra

 # a0: msg to ask
 # v0: block address allocated with string
getBlock:
	addi $sp, $sp, -4
	sw $ra, 4($sp)
	li $v0, 4
	syscall
	jal smalloc
	move $a0, $v0
	li $a1, 16
	li $v0, 8
	syscall
	move $v0, $a0
	lw $ra, 4($sp)
	addi $sp, $sp, 4
	jr $ra

smalloc:
	lw $t0, slist
	beqz $t0, sbrk
	move $v0, $t0
	lw $t0, 12($t0)
	sw $t0, slist
	jr $ra
	
sbrk:
	li $a0, 16 # node size fixed 4 words
	li $v0, 9
	syscall # return node address in v0
	jr $ra

sfree:
	lw $t0, slist
	sw $t0, 12($a0)
	sw $a0, slist # $a0 node address in unused list
	jr $ra
