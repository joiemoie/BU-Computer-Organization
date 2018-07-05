.data
my_array: .word 1, 4, 5, 7, 9, 12, 15, 17, 18, 20, 21, 30
array_size: .word 11

.text
.globl main

main:
  la $s0, my_array
  lw $s1, array_size
  li $s2, 15
  jal binary_search
  move $s3, $v0
  li $s2, 4
  jal binary_search
  move $s4, $v0
  li $s2, 30
  jal binary_search
  move $s5, $v0
  li $s2, 0
  jal binary_search
  move $s6, $v0
  j end 

binary_search:
  move $t0, $s1
  srl $t0, $t0, 1         # set middle number
  move $t1, $0            # set left marker
  move $t2, $s1           # set right marker
LOOP:
  sll $t6, $t0, 2         # multiply index by 4 and add it to address
  add $t3, $t6, $s0
  lw $t4, 0($t3)
  beq $t4, $s2, ENDLOOP   # if i found the value, end the loop
  beq $t2, $t1, NOTFOUND  # if the left and right marker are the same, i couldn't find the value
  slt $t5, $t4, $s2       # decide if the middle number is smaller or larger than the value
  bne $t5, $0, LEFT       # if its larger, move the left marker to the index
  move $t2, $t0           # if its smaller, move the right marker to the index
  add $t0, $t1, $t2       # update the new middle
  srl $t0, $t0, 1
  j LOOP
LEFT:
  move $t1, $t0          
  addi $t1, $t1, 1
  add $t0, $t2, $t1
  srl $t0, $t0, 1
  j LOOP
ENDLOOP:
  move $v0, $t0          # returns the index
  jr $ra
NOTFOUND:
  li $v0, -1             # return -1
  jr $ra

end:
  li $v0, 10
  syscall