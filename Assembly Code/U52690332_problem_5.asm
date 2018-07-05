.data

.text
.globl main

main:
  li $v0, 5                    # load n
  syscall
  move $s0, $v0
  jal printsequence
  j end

printsequence:
  li $s1, 1
  li $t2, 3
  move $t1, $s0
  move $a0, $t1
  li $v0, 1
  syscall
  j loop

loop:
  beq $t1, $s1, done

checkdiv2:
  srl $t0, $t1, 1             # divides n by 2 which concatenates the last bit
  sll $t0, $t0, 1             # if n/2 * 2 < n, then n is odd
  slt $t0, $t0, $t1
  beq $t0, $0, div2           # branch if even
  j notdiv2                   # branch if odd

div2:
  srl $t1, $t1, 1             # A(n+1) = A(n)/2
  j print                     # prints to the console

notdiv2:
  add $t3, $t1, $t1           # A(n+1) = 3 * A(n) + 1
  add $t1, $t3, $t1
  addi $t1, $t1, 1
  j print                     # prints to the console

print:
  move $a0, $t1
  li $v0, 1
  syscall
  j loop 

done:
  jr $ra                      # returns to main

end:
  li $v0, 10
  syscall