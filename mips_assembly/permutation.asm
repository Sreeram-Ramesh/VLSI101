.data
data_array:
.word 3, 2, 4, -9

.text
	la $t7, data_array
	lw $t5, 0($t7)
	addi $t0, $zero, 0x04
	la $t8, data_array
	addi $t8, $t8, 0x100
	
MAIN:
	beq $t5, $zero, HALT
	addi $t5, $t5, -1
	add $t7, $t7, $t0
	lw $t1, 0($t7)
	blez $t1, SKIP_FACTORIAL
	add $s0, $zero, $t1
	addi $s1, $zero, 1
	
FACTORIAL_LOOP:
	beq $s0, $zero, STORE_RESULT
	mult $s1, $s0
	mflo $s1
	addi $s0, $s0, -1
	j FACTORIAL_LOOP
	
STORE_RESULT:
	sw $s1, 0($t8)
	add $t8, $t8, $t0
	j MAIN
	
SKIP_FACTORIAL:
	addi $s1, $zero, 0
	j STORE_RESULT
	
HALT:
	addi $v0, $zero, 10
	syscall
