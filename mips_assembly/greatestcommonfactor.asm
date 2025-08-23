.data
data_array:
.word 6, 24, 18, 49, 21, 51, 17, 31, 22, 4, 2, 7, 0    # First element is count, followed by pairs of numbers

.text
	la $t7, data_array          # Load address of data array
	lw $t5, 0($t7)              # Load count of pairs (6)
	addi $t6, $zero, 0x0A       # Load constant 10 (unused in current implementation)
	addi $t8, $zero, 0x04       # Word size constant (4 bytes)
	addi $s7, $zero, 0x02       # Constant 2 for special case checking
	la $t9, data_array          # Load base address for result storage
	addi $t9, $t9, 0x200        # Set result storage location (offset 0x200 from data_array)

	LOOP: 
	add $t7, $t7, $t8           # Move to next element in array
	lw $s0, 0($t7)              # Load first number of pair
	add $t7, $t7, $t8           # Move to next element
	lw $s1, 0($t7)              # Load second number of pair
	addi $t5, $t5, -1           # Decrement pair counter
	blt $s0, $s1, SEC           # If first number < second number, go to SEC
	
	# First number >= second number
	add $s2, $zero, $s1         # s2 = smaller number (second)
	add $s3, $zero, $s0         # s3 = larger number (first)
	add $s4, $zero, $s2         # s4 = backup of smaller number
	add $s6, $zero, $s3         # s6 = backup of larger number
	
	REM: 
	beq $s2, $zero, RESULT      # If smaller number is 0, GCD found
	sub $s3, $s3, $s2           # Subtract smaller from larger
	bge $s3, $s2, REM           # If result >= smaller, continue subtracting
	beq $s3, $zero, RESULT      # If remainder is 0, GCD found
	
	# Swap for next iteration (Euclidean algorithm)
	add $s2, $zero, $s3         # New smaller = old remainder
	add $s3, $zero, $s4         # New larger = old smaller
	beq $zero, $zero, REM       # Continue algorithm
	
	RESULT: 
	beq $s2, $s7, CONSIDER      # If GCD = 2, check special case
	
	RECONSIDER: 
	add $s5, $zero, $s2         # Copy GCD result
	sw $s5, 0($t9)              # Store GCD in result array
	add $t9, $t9, $t8           # Move result pointer to next position
	bne $zero, $t5, LOOP        # If more pairs to process, continue loop
	
	HALT: 
	beq $zero, $zero, HALT      # Infinite loop to halt program
	
	SEC: 
	# First number < second number
	add $s2, $zero, $s0         # s2 = smaller number (first)
	add $s3, $zero, $s1         # s3 = larger number (second)
	beq $zero, $zero, REM       # Start GCD algorithm
	
	CONSIDER: 
	# Special case: when GCD = 2, verify both numbers are even
	andi $v0, $s4, 0x01         # Check if first original number is odd (LSB = 1)
	bne $v0, $zero, ONE         # If odd, GCD cannot be 2
	andi $v0, $s6, 0x01         # Check if second original number is odd (LSB = 1)
	bne $v0, $zero, ONE         # If odd, GCD cannot be 2
	beq $zero, $zero, RECONSIDER # Both are even, keep GCD = 2
	
	ONE: 
	addi $s2, $zero, 0x01       # Set GCD = 1 (since 2 cannot divide an odd number)
	beq $zero, $zero, RECONSIDER # Store the corrected result