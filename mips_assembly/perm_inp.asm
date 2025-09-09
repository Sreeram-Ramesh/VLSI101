.data
prompt:      .asciiz "Enter count: "
inputMsg:    .asciiz "Enter a number: "
factMsg:     .asciiz "! = "
newline:     .asciiz "\n"
result_array: .word 0:16   


.text
.globl main
main:
    # Ask for how many numbers
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5      
    syscall
    move $t5, $v0    # $t5 = count

    la $t8, result_array   # result pointer
    li $t0, 4              # word size

read_loop:
    beq $t5, $zero, HALT   # done if count = 0

    # Ask for a number
    li $v0, 4
    la $a0, inputMsg
    syscall

    li $v0, 5
    syscall
    move $t1, $v0          # current number

    addi $t5, $t5, -1     

    blez $t1, store_zero  

    # factorial calculation
    move $s0, $t1          # copy number
    li $s1, 1              # result = 1

fact_loop:
    beq $s0, $zero, store_result
    mul $s1, $s1, $s0
    addi $s0, $s0, -1
    j fact_loop

store_result:
    sw $s1, 0($t8)         # store in result_array
    add $t8, $t8, $t0

    # print "n! = result"
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, factMsg
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    j read_loop

store_zero:
    sw $zero, 0($t8)
    add $t8, $t8, $t0

    # print "n! = 0"
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, factMsg
    syscall
    li $v0, 1
    move $a0, $zero
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    j read_loop

HALT:
    li $v0, 10
    syscall