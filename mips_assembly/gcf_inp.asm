.data
prompt:      .asciiz "Enter count: "
input1:      .asciiz "Enter first number: "
input2:      .asciiz "Enter second number: "
gcfMsg:      .asciiz "GCF calculated is = "
newline:     .asciiz "\n"
result_array: .word 16   

.text
.globl main
main:
    # Ask how many pairs
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t5, $v0       # $t5 = count

    la $t8, result_array 
    li $t0, 4             # word size

read_loop:
    beq $t5, $zero, HALT   # done when count=0
    addi $t5, $t5, -1

    # Ask first number
    li $v0, 4
    la $a0, input1
    syscall
    li $v0, 5
    syscall
    move $s0, $v0         # $s0 = first number

    # Ask second number
    li $v0, 4
    la $a0, input2
    syscall
    li $v0, 5
    syscall
    move $s1, $v0         # $s1 = second number

gcf_loop:
    beq $s1, $zero, gcf_done
    div $s0, $s1
    mfhi $t1              # remainder = s0 % s1
    move $s0, $s1
    move $s1, $t1
    j gcf_loop

gcf_done:
    move $t2, $s0        

    # store in result_array
    sw $t2, 0($t8)
    add $t8, $t8, $t0

    # print result
    li $v0, 4
    la $a0, gcfMsg
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    j read_loop

HALT:
    #stopp
    li $v0, 10
    syscall
