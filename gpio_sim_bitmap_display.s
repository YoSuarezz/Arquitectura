.eqv FB_BASE   0x10008000
.eqv WIDTH     256

# Coordenadas del "LED" (pixel)
.eqv LED_X     10
.eqv LED_Y     10

# Colores ARGB
.eqv COLOR_ON  0x00FF0000   # rojo
.eqv COLOR_OFF 0x00000000   # negro

.text
.globl main
main:
    # addr = FB_BASE + ((LED_Y * WIDTH) + LED_X) * 4
    li   $t0, LED_Y
    li   $t1, WIDTH
    mul  $t2, $t0, $t1          # t2 = y * WIDTH
    addi $t2, $t2, LED_X        # t2 = y*W + x
    sll  $t2, $t2, 2            # *4 (word por pixel)
    li   $t3, FB_BASE
    add  $t4, $t3, $t2          # t4 -> direccion del pixel

blink:
    li   $t5, COLOR_ON
    sw   $t5, 0($t4)            # encender
    jal  delay

    li   $t5, COLOR_OFF
    sw   $t5, 0($t4)            # apagar
    jal  delay

    j    blink

# Retardo simple por software
delay:
    li   $t6, 0x00100000
d1: addi $t6, $t6, -1
    bgtz $t6, d1
    jr   $ra
