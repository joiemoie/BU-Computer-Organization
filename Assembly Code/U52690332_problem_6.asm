.data
matrix1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
matrix2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0
matrix3: .word 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main

main:
  la $s0, matrix1
  la $s1, matrix2
  la $s2, matrix3

  li $t0, 0
  li $t1, 72
  li $t2, 32
loadmatrices: 
  beq $t0, $t1, loadedmatrices
  li $v0, 5                    # load n
  syscall
  bgt $t0, $t2, loadmatrix2
loadmatrix1:
  add $t3, $t0, $s0
  j endofloop
loadmatrix2:
  add $t3, $t0, $s1
endofloop:
  sw $v0, 0($t3)
  addi $t0, $t0, 4
  j loadmatrices

loadedmatrices:
  li $t0, 0
  li $t1, 9
  li $t3, 3
  move $t2, $s2
multiply:
  beq $t0, $t1, endofmult
  div $t0, $t3
  mflo $t9
  mult $t9, $t3
  srl $t9, $t9, 2
  add $t4, $s0, $t9
  lw $t6, 0($t4) #matrix1[i*3]
  div $t0, $t3
  mfhi $t9
  srl $t9, $t9, 2
  add $t5, $s1, $t9
  lw $t6, 0($t5) #matrix2[2] 
  mult $t6, $t7
  mflo $t8
  addi $t4, $t4, 4
  addi $t5, $t5, 12
  lw $t6, 0($t4)
  lw $t7, 0($t5)
  mult $t6, $t7
  mflo $t9
  add $t8, $t8, $t9
  addi $t4, $t4, 4
  addi $t5, $t5, 12
  lw $t6, 0($t4)
  lw $t7, 0($t5)
  mult $t6, $t7
  mflo $t9
  add $t8, $t8, $t9
  sw $t8, 0($t2)
  addi $t0, $t0, 1
  addi $t2, $t2, 4
  j multiply

endofmult:
  li $v0, 10
  syscall