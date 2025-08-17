.data
data_array:
.word 6, 24, 18, 49, 21, 51, 17, 31, 22, 15, 10, 7, 0

.text
	la $t7, data_array
	lw $t5, 0($t7)
	addi $t8, $zero, 0x04
	addi $s7, $zero, 0x02
	la $t9, data_array
	addi $t9, $t9, 0x200

	LOOP: add $t7, $t7, $t8
	lw $s0, 0($t7)
	add $t7, $t7, $t8
	lw $s1, 0($t7)
	addi $t5, $t5, -1
	blt $s0, $s1, SEC
	add $s2, $zero, $s1 # smaller of the two here.
	add $s3, $zero, $s0 # bigger number goes here.
	add $s4, $zero, $s2
	add $s6, $zero, $s3

	REM: beq $s2, $zero, RESULT
	sub $s3, $s3, $s2
	bge $s3, $s2, REM
	beq $s3, $zero, RESULT
	add $s2, $zero, $s3
	add $s3, $zero, $s4
	beq $zero, $zero, REM

	RESULT: beq $s2, $s7, CONSIDER # Fail safe mechanism for 2
	
	RECONSIDER: add $s5, $zero, $s2
	sw $s5, 0($t9)
	add $t9, $t9, $t8
	bne $zero, $t5, LOOP

	HALT: beq $zero, $zero, HALT

	SEC: add $s2, $zero, $s0
	add $s3, $zero, $s1
	beq $zero, $zero, REM

	CONSIDER: andi $v0, $s4, 0x01
	bne $v0, $zero, ONE
	andi $v0, $s6, 0x01
	bne $v0, $zero, ONE
	beq $zero, $zero, RECONSIDER

	ONE: addi $s2, $zero, 0x01
	beq $zero, $zero, RECONSIDER
