.data
# ---------------- MENUS ----------------
menu_principal:       .asciiz "\n--- MENU PRINCIPAL ---\n1. Movimientos\n2. Funcion Trigonometrica\n3. Expresiones Varias\n4. Salir\nSeleccione una opcion: "
menu_movimientos:     .asciiz "\n--- MENU MOVIMIENTOS ---\n1. MRU\n2. MCUA\nSeleccione una opcion: "
menu_mru:             .asciiz "\n--- MRU ---\n1. Calcular distancia\n2. Calcular velocidad\nSeleccione una opcion: "
menu_mcua:            .asciiz "\n--- MCUA ---\n1. Calcular aceleracion angular\n2. Calcular velocidad angular final\nSeleccione una opcion: "
menu_trigo:           .asciiz "\n--- FUNCIONES TRIGONOMETRICAS ---\n1. Calcular tanh(x)\nSeleccione una opcion: "
menu_expresiones:     .asciiz "\n--- EXPRESIONES VARIAS ---\n1. Newton-Raphson\n2. Sistema de ecuaciones 2x2\nSeleccione una opcion: "
num_iter: .word 15         # numero de iteraciones para exp(x)

# ---------------- MENSAJES DE INGRESO ----------------
ingresar_velocidad:         .asciiz "\nIngrese la velocidad (m/s): "
ingresar_tiempo:            .asciiz "\nIngrese el tiempo (s): "
ingresar_distancia:         .asciiz "\nIngrese la distancia (m): "
ingresar_aceleracion:       .asciiz "\nIngrese la aceleracion angular (rad/s^2): "
ingresar_velocidad_inicial: .asciiz "\nIngrese la velocidad angular inicial (rad/s): "
ingresar_velocidad_final:   .asciiz "\nIngrese la velocidad angular final (rad/s): "
ingresar_x:                 .asciiz "\nIngrese el valor de x: "
ingresar_iteraciones:       .asciiz "\nIngrese el numero de iteraciones: "
ingresar_a:                 .asciiz "\nIngrese el valor de a: "
ingresar_b:                 .asciiz "\nIngrese el valor de b: "
ingresar_c:                 .asciiz "\nIngrese el valor de c: "
ingresar_d:                 .asciiz "\nIngrese el valor de d: "
ingresar_e:                 .asciiz "\nIngrese el valor de e: "
ingresar_f:                 .asciiz "\nIngrese el valor de f: "

# ---------------- MENSAJES DE RESULTADO ----------------
resultado_distancia:        .asciiz "\nLa distancia es: "
resultado_velocidad:        .asciiz "\nLa velocidad es: "
resultado_aceleracion:      .asciiz "\nLa aceleracion angular es: "
resultado_velfinal:         .asciiz "\nLa velocidad angular final es: "
resultado_tanh: .asciiz "\nEl valor de tanh(x) es: "

# ---------------- CONSTANTES ----------------
constante_uno: .float 1.0

.text
.globl main

# ======================================================
# MENU PRINCIPAL
# ======================================================
main:
loop_main:
    # Mostrar menu principal
    la   $a0, menu_principal
    li   $v0, 4
    syscall

    # Leer opcion
    li   $v0, 5
    syscall
    move $t0, $v0       # opcion principal

    beq $t0, 1, opcion_movimientos
    beq $t0, 2, opcion_trigonometrica
    beq $t0, 3, opcion_expresiones
    beq $t0, 4, fin_programa
    j loop_main

# ======================================================
# SUBMENU MOVIMIENTOS
# ======================================================
opcion_movimientos:
    la   $a0, menu_movimientos
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t1, $v0

    beq $t1, 1, submenu_mru
    beq $t1, 2, submenu_mcua
    j loop_main

# ---------- MRU ----------
submenu_mru:
    la   $a0, menu_mru
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t2, $v0

    beq $t2, 1, ejecutar_mru_dist
    beq $t2, 2, ejecutar_mru_vel
    j loop_main

ejecutar_mru_dist:
    jal mru_distancia
    j loop_main

ejecutar_mru_vel:
    jal mru_velocidad
    j loop_main

mru_distancia:
    # Pedir velocidad
    la   $a0, ingresar_velocidad
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0

    # Pedir tiempo
    la   $a0, ingresar_tiempo
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f2, $f0

    # Calcular distancia = v * t
    mul.s $f12, $f1, $f2

    # Mostrar resultado
    la   $a0, resultado_distancia
    li   $v0, 4
    syscall
    li   $v0, 2
    syscall
    jr   $ra

mru_velocidad:
    # Pedir distancia
    la   $a0, ingresar_distancia
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0

    # Pedir tiempo
    la   $a0, ingresar_tiempo
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f2, $f0

    # Calcular velocidad = d / t
    div.s $f12, $f1, $f2

    # Mostrar resultado
    la   $a0, resultado_velocidad
    li   $v0, 4
    syscall
    li   $v0, 2
    syscall
    jr   $ra

# ---------- MCUA ----------
submenu_mcua:
    la   $a0, menu_mcua
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t3, $v0

    beq $t3, 1, ejecutar_mcua_aceleracion
    beq $t3, 2, ejecutar_mcua_velfinal
    j loop_main

ejecutar_mcua_aceleracion:
    jal mcua_aceleracion
    j loop_main

ejecutar_mcua_velfinal:
    jal mcua_velocidad_final
    j loop_main

mcua_aceleracion:
    # Pedir w_f
    la   $a0, ingresar_velocidad_final
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0

    # Pedir w_0
    la   $a0, ingresar_velocidad_inicial
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f2, $f0

    # Pedir tiempo
    la   $a0, ingresar_tiempo
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f3, $f0

    # Calculo: alpha = (w_f - w_0) / t
    sub.s $f4, $f1, $f2
    div.s $f12, $f4, $f3

    # Mostrar resultado
    la   $a0, resultado_aceleracion
    li   $v0, 4
    syscall
    li   $v0, 2
    syscall
    jr   $ra

mcua_velocidad_final:
    # Pedir w_0
    la   $a0, ingresar_velocidad_inicial
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0

    # Pedir alpha
    la   $a0, ingresar_aceleracion
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f2, $f0

    # Pedir tiempo
    la   $a0, ingresar_tiempo
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f3, $f0

    # Calculo: w_f = w_0 + alpha * t
    mul.s $f4, $f2, $f3
    add.s $f12, $f1, $f4

    # Mostrar resultado
    la   $a0, resultado_velfinal
    li   $v0, 4
    syscall
    li   $v0, 2
    syscall
    jr   $ra

# ======================================================
# SUBMENU FUNCIONES TRIGONOMETRICAS
# ======================================================
opcion_trigonometrica:
    la   $a0, menu_trigo
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t4, $v0

    beq $t4, 1, ejecutar_tanh
    j loop_main


ejecutar_tanh:
    jal pedir_x_tanh
    j loop_main


# ------------------------------------------------------
# exp(x) usando serie de Taylor
# Entrada: $f1 = x
# Salida : $f12 = e^x
# ------------------------------------------------------
exp_taylor:
    li      $t0, 0          	# i = 0
    l.s    $f12, constante_uno  # resultado = 1
    l.s    $f2, constante_uno   # término
    l.s    $f3, constante_uno   # x^i
    l.s    $f4, constante_uno   # factorial

loop_exp:
    beq     $t0, 15, end_exp   # 15 términos (puedes cambiar)
    addi    $t0, $t0, 1

    # x^i = x^(i-1) * x
    mul.s   $f3, $f3, $f1

    # factorial = factorial * i
    mtc1    $t0, $f5
    cvt.s.w $f5, $f5
    mul.s   $f4, $f4, $f5

    # término = x^i / i!
    div.s   $f2, $f3, $f4

    # resultado += término
    add.s   $f12, $f12, $f2

    j loop_exp
end_exp:
    jr $ra


# ------------------------------------------------------
# Calculo tanh(x) = (e^x - e^-x) / (e^x + e^-x)
# ------------------------------------------------------
pedir_x_tanh:
    # Leer x
    la   $a0, ingresar_x
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0          # x

    # Calcular e^x
    jal exp_taylor
    mov.s $f20, $f12        # guardar e^x

    # Calcular e^(-x)
    neg.s $f1, $f1
    jal exp_taylor
    mov.s $f21, $f12        # guardar e^-x

    # tanh(x) = (e^x - e^-x) / (e^x + e^-x)
    sub.s $f22, $f20, $f21
    add.s $f23, $f20, $f21
    div.s $f12, $f22, $f23

        # Mostrar resultado
    la   $a0, resultado_tanh
    li   $v0, 4
    syscall
    li   $v0, 2
    syscall

    j loop_main   # <- volver directo al menu principal


# ======================================================
# SUBMENU EXPRESIONES VARIAS
# ======================================================
opcion_expresiones:
    la   $a0, menu_expresiones
    li   $v0, 4
    syscall

    li   $v0, 5
    syscall
    move $t5, $v0

    beq $t5, 1, newton
    beq $t5, 2, sistema2x2
    j loop_main

newton:
    # Pedir x0
    la   $a0, ingresar_x
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0

    # Pedir numero de iteraciones
    la   $a0, ingresar_iteraciones
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t6, $v0
    jr   $ra

sistema2x2:
    la   $a0, ingresar_a
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0

    la   $a0, ingresar_b
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f2, $f0

    la   $a0, ingresar_c
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f3, $f0

    la   $a0, ingresar_d
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f4, $f0

    la   $a0, ingresar_e
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f5, $f0

    la   $a0, ingresar_f
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f6, $f0
    jr   $ra

# ======================================================
# FIN PROGRAMA
# ======================================================
fin_programa:
    li $v0, 10
    syscall