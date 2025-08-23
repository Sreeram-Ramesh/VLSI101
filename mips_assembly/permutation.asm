.data
data_array:
.word 3, 2, 4, -9  # First element is count, rest are values
result_array:
.space 64          # Space for results

.text
	la $t7, data_array
	lw $t5, 0($t7)      # Load count
	addi $t0, $zero, 0x04   # Word size
	la $t8, result_array    # Result array pointer
	
MAIN:
	beq $t5, $zero, HALT    # If count is zero, halt
	addi $t5, $t5, -1       # Decrement count
	add $t7, $t7, $t0       # Move to next element
	lw $t1, 0($t7)          # Load current number
	
	# Check if number is negative or zero
	blez $t1, SKIP_FACTORIAL
	
	# Calculate factorial (permutation of n things taken n at a time = n!)
	add $s0, $zero, $t1     # Copy number to $s0
	addi $s1, $zero, 1      # Initialize result to 1
	
FACTORIAL_LOOP:
	beq $s0, $zero, STORE_RESULT
	mult $s1, $s0           # Multiply result by current number
	mflo $s1                # Get result from LO register
	addi $s0, $s0, -1       # Decrement counter
	j FACTORIAL_LOOP
	
STORE_RESULT:
	sw $s1, 0($t8)          # Store factorial result
	add $t8, $t8, $t0       # Move result pointer
	j MAIN
	
SKIP_FACTORIAL:
	addi $s1, $zero, 0      # Set result to 0 for invalid inputs
	j STORE_RESULT
	
HALT:
	# Infinite loop to halt execution
	j HALT