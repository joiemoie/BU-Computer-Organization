.data
my_array: .word 1, 4, 5, 7, 9, 12, 15, 17, 18, 20, 21, 30
array_size: .word 11

.text
.globl main

main:
  la $s0, my_array
  lw $s1, array_size
  li $s2, 15
  move $a0, $s0
  move $a1, $s2
  move $a2, $0
  move $a3, $s1
  jal binary_search
  move $s3, $v0
  li $s2, 4
  move $a0, $s0
  move $a1, $s2
  move $a2, $0
  move $a3, $s1
  jal binary_search
  move $s4, $v0
  li $s2, 30
  move $a0, $s0
  move $a1, $s2
  move $a2, $0
  move $a3, $s1
  jal binary_search
  move $s5, $v0
  li $s2, 0
  move $a0, $s0
  move $a1, $s2
  move $a2, $0
  move $a3, $s1
  jal binary_search
  move $s6, $v0
  j end

binary_search:
  addi $sp, $sp, -4            # move the stack pointer and add the return address
  sw $ra, 0($sp)
  add $t0, $a3, $a2            # find the middle
  srl $t0, $t0, 1
  sll $t2, $t0, 2
  add $t2, $t2, $a0
  lw $t1, 0($t2)               # load the middle value
  beq $t1, $a1, found          # check the middle value is the value
  beq $a2, $a3, fail           # if the left and right markers are the same, i failed to find the value
  slt $t2, $t1, $a1
  beq $t2, $0, greater         # check if the middle value is greater than the value
  addi $t0, $t0, 1             # if the middle value is less than the value, move the left marker to the middle
  move $a2, $t0
  jal binary_search
  j exitsearch
  
found:
  move $v0, $a2                # return the index
  j exitsearch 

fail:
  addi $v0, $0, -1             # return -1
  j exitsearch

greater:                       # move the right marker to the middle
  move $a3, $t0
  jal binary_search
  j exitsearch

exitsearch:                    # go back through the stack and return to the return addresses
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra

end:
  li $v0, 10
  syscall