.data
num1:   .word 7
num2:   .word 5
txt:    .asciiz "Resultado: "
nl:     .asciiz "\n"

.text
.globl main
main:
    lw  $t0, num1         # t0 = num1
    lw  $t1, num2         # t1 = num2
    add $t2, $t0, $t1     # t2 = num1 + num2

    la  $a0, txt          # imprime "Resultado: "
    li  $v0, 4
    syscall

    move $a0, $t2         # imprime entero
    li  $v0, 1            # print_int
    syscall

    la  $a0, nl           # salto de linea
    li  $v0, 4
    syscall

    li  $v0, 10           # exit
    syscall
