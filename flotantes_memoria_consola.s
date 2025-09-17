.data
f1: .float 5.5
f2: .float 2.5
txt: .asciiz "Suma (float) = "
nl:  .asciiz "\n"

.text
.globl main
main:
    l.s   $f0, f1         # f0 = 5.5
    l.s   $f2, f2         # f2 = 2.5
    add.s $f4, $f0, $f2   # f4 = f0 + f2

    la    $a0, txt        # imprime texto
    li    $v0, 4          # print_string
    syscall

    mov.s $f12, $f4       # argumento float
    li    $v0, 2          # print_float
    syscall

    la    $a0, nl         # salto de linea
    li    $v0, 4
    syscall

    li    $v0, 10         # exit
    syscall
