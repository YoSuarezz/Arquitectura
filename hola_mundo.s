.data
msg:    .asciiz "Hola, mundo!\n"

.text
.globl main
main:
    la  $a0, msg      # puntero al mensaje
    li  $v0, 4        # syscall: print_string
    syscall

    li  $v0, 10       # syscall: exit
    syscall
