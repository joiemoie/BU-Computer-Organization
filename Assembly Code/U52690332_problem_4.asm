.data

.text
.globl main

main:
  li $v0, 5
  syscall
  move $s0, $v0
  sll $s0, $s0, 2
  move $a0, $s0
  li $v0, 9
  syscall
  move $s1, $v0
  srl $s0, $s0, 2
  move $t0, $s0
  move $t1, $s1
  jal store
  move $a0, $s1
  move $a1, $s0
  jal sort
  move $t0, $0
  move $t1, $s1
  jal print
  j end

store:
  beq $t0, $0 done            # if (iterator == 0) finish storing
  li $v0, 5                   # store the value from the console
  syscall
  sw $v0, 0($t1)
  addi $t1, $t1, 4            # move the array pointer up
  addi $t0, $t0, -1           # i--
  j store                     # keep storing more
  
print:
  beq $t0, $s0, done         # if (iterator == n) finish storing
  li $v0, 1                  # print the values to the console
  lw $a0, 0($t1)
  syscall
  addi $t1, $t1, 4           # move the array pointer up
  addi $t0, $t0, 1           # i++
  j print                    # keep printing more

sort:                        # bubble sort
  addi $sp, $sp, -8          # move the stack pointer to store return addresses
  sw $ra, 0($sp)             # store the return addresses
  move $t0, $a0
  move $t1, $t0
  addi $t2, $a1, -1
  sll $t2, $t2, 2
  add $t2, $t2, $a0          # addresses of last element in the array
  jal beginningloop1
  lw $ra, 0($sp)             # return to main and move the stack pointer back
  addi $sp, $sp, 8
  jr $ra

beginningloop1:
  sw $ra, 4($sp)             # store a stack pointer
  j loop1

loop1:
  bge $t0, $t2, doneloop1    # if (i == end) end loop
  jal loop2                  # go to inner loop
  addi $t0, $t0, 4           # i++
  j loop1

loop2:
  bge $t1, $t2, done         # if (j == end) end loop
  addi $t3, $t1, 4
  lw $t4, 0($t1)
  lw $t5, 0($t3)
  bgt $t4, $t5, swap         # swap values if (array[j] <array[j+1]) 
  addi $t1, $t1, 4           # j++
  j loop2

swap:
  sw $t4, 0($t3)
  sw $t5, 0($t1)
  addi $t1, $t1, 4           # j++
  j loop2

done:
  jr $ra

doneloop1:
  lw $ra, 4($sp)             # loads the previously stored stack pointer
  jr $ra

end:
  li $v0, 10
  syscall