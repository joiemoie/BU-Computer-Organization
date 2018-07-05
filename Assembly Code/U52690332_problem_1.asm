.data
prev: .word 1
result: .word 1
n: .word 10

.text
.globl main

main:
  li $t0, 3            # (int i = 3)
  lw $t1, n
  addi $t1, $t1, 1
  lw $s0, prev
  lw $s1, result
  lw $s2, n
  jal LOOP
  j END
LOOP:
  bgt $t0, $t1, DONE   # (if iterator == n) return result
  add $s1, $s1, $s0    # current num is sum of prev 2 numbers
  sub $s0, $s1, $s0    # update previous numbers
  addi $t0, 1          # i++
  j LOOP
RESULT0: 
  li $s1, 0
  jr $ra
DONE:
  beq $s2, $0, RESULT0 # (if n == 0) return 0
END:
  li $v0, 10
  syscall