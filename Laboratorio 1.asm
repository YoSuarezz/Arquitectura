.data
# ---------------- MENUS ----------------
menu_principal:       .asciiz "\n--- MENU PRINCIPAL ---\n1. Movimientos\n2. Funcion Trigonometrica\n3. Expresiones Varias\n4. Salir\nSeleccione una opcion: "
menu_movimientos:     .asciiz "\n--- MENU MOVIMIENTOS ---\n1. Movimiento Rectilio Uniforme (MRU)\n2. Movimiento Circular Uniformemente Acelerado(MCUA)\nSeleccione una opcion: "
menu_mru:             .asciiz "\n--- MRU ---\n1. Calcular distancia\n2. Calcular velocidad\nSeleccione una opcion: "
menu_mcua:            .asciiz "\n--- MCUA ---\n1. Calcular aceleracion angular\n2. Calcular velocidad angular final\nSeleccione una opcion: "
menu_trigo:           .asciiz "\n--- FUNCIONES TRIGONOMETRICAS ---\n1. Calcular tanh(x)\nSeleccione una opcion: "
menu_expresiones:     .asciiz "\n--- EXPRESIONES VARIAS ---\n1. Newton-Raphson\n2. Logaritmo natural ln(x)\n3. Sistema de ecuaciones 2x2 \nSeleccione una opcion: "


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
ingresar_ln:          	    .asciiz "\nIngrese un valor positivo para calcular ln(x): "


# ---------------- MENSAJES DE RESULTADO ----------------
resultado_distancia:        .asciiz "\nLa distancia es: "
resultado_velocidad:        .asciiz "\nLa velocidad es: "
resultado_aceleracion:      .asciiz "\nLa aceleracion angular es: "
resultado_velfinal:         .asciiz "\nLa velocidad angular final es: "
resultado_newton: 	    .asciiz "\nAproximacion de la raiz: "
resultado_tanh: 	    .asciiz "\nEl valor de tanh(x) es: "
resultado_x: 		    .asciiz "\nEl valor de x es: "
resultado_y: 		    .asciiz "\nEl valor de y es: "
resultado_ln:          	    .asciiz "\nEl valor de ln(x) es: "
iteracion_msg: 		    .asciiz "\nIteracion realizada.\n"

# ---------------- CONSTANTES ----------------
constante_cero:         .float 0.0
constante_uno: 		.float 1.0
constante_dos: 		.float 2.0
constante_tres: 	.float 3.0
constante_cuatro: 	.float 4.0
constante_cinco: 	.float 5.0
constante_seis: 	.float 6.0
constante_siete: 	.float 7.0
num_iter: 	      	.word 15         # numero de iteraciones para exp(x)

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
    l.s    $f2, constante_uno   # t�rmino
    l.s    $f3, constante_uno   # x^i
    l.s    $f4, constante_uno   # factorial

loop_exp:
    beq     $t0, 15, end_exp   # 15 t�rminos (puedes cambiar)
    addi    $t0, $t0, 1

    # x^i = x^(i-1) * x
    mul.s   $f3, $f3, $f1

    # factorial = factorial * i
    mtc1    $t0, $f5
    cvt.s.w $f5, $f5
    mul.s   $f4, $f4, $f5

    # t�rmino = x^i / i!
    div.s   $f2, $f3, $f4

    # resultado += t�rmino
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
    beq $t5, 2, calcular_ln
    beq $t5, 3, sistema2x2 
    j loop_main

# ------------------------------------------------------
# Metodo Newton-Raphson para f(x) = x^3 - 5x + 1
# ------------------------------------------------------
newton:
    # Leer valor inicial x0
    la   $a0, ingresar_x
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0   # x0 en f1

    # Leer n�mero de iteraciones
    la   $a0, ingresar_iteraciones
    li   $v0, 4
    syscall
    li   $v0, 5
    syscall
    move $t6, $v0    # numero de iteraciones

    li   $t7, 0      # contador de iteraciones

loop_newton:
    beq  $t7, $t6, fin_newton

    # f(x) = x^3 - 5x + 1
    mul.s $f2, $f1, $f1      # x^2
    mul.s $f2, $f2, $f1      # x^3
    mov.s $f3, $f1
    l.s  $f4, constante_cinco
    mul.s $f3, $f3, $f4      # 5x
    sub.s $f5, $f2, $f3      # x^3 - 5x
    l.s  $f6, constante_uno
    add.s $f5, $f5, $f6      # f(x) en f5

    # f'(x) = 3x^2 - 5
    mul.s $f7, $f1, $f1      # x^2
    l.s  $f8, constante_tres
    mul.s $f7, $f7, $f8      # 3x^2
    l.s  $f9, constante_cinco
    sub.s $f7, $f7, $f9      # f'(x) en f7

    # f(x)/f'(x)
    div.s $f10, $f5, $f7

    # x = x - f(x)/f'(x)
    sub.s $f1, $f1, $f10

    addi $t7, $t7, 1
    j loop_newton

fin_newton:
    # Imprimir resultado
    la   $a0, resultado_newton
    li   $v0, 4
    syscall

    mov.s $f12, $f1   # ra�z aproximada
    li   $v0, 2
    syscall

    j loop_main


# ------------------------------------------------------
# Sistema de ecuaciones 2x2 usando regla de Cramer
# a*x + b*y = c
# d*x + e*y = f
# ------------------------------------------------------
sistema2x2:
    # Leer a
    la $a0, ingresar_a
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0   # a

    # Leer b
    la $a0, ingresar_b
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0   # b

    # Leer c
    la $a0, ingresar_c
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f3, $f0   # c

    # Leer d
    la $a0, ingresar_d
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f4, $f0   # d

    # Leer e
    la $a0, ingresar_e
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f5, $f0   # e

    # Leer f
    la $a0, ingresar_f
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f6, $f0   # f

    # Determinante D = a*e - b*d
    mul.s $f7, $f1, $f5   # a*e
    mul.s $f8, $f2, $f4   # b*d
    sub.s $f7, $f7, $f8   # D en f7

    # x = (c*e - b*f) / D
    mul.s $f9, $f3, $f5   # c*e
    mul.s $f10, $f2, $f6  # b*f
    sub.s $f9, $f9, $f10
    div.s $f20, $f9, $f7  # x en f20

    # y = (a*f - c*d) / D
    mul.s $f11, $f1, $f6  # a*f
    mul.s $f12, $f3, $f4  # c*d
    sub.s $f11, $f11, $f12
    div.s $f21, $f11, $f7 # y en f21

    # Mostrar x
    la   $a0, resultado_x
    li   $v0, 4
    syscall
    mov.s $f12, $f20
    li   $v0, 2
    syscall

    # Mostrar y
    la   $a0, resultado_y
    li   $v0, 4
    syscall
    mov.s $f12, $f21
    li   $v0, 2
    syscall

    j loop_main

# ------------------------------------------------------
# Logaritmo natural usando serie
# ln(x) = 2 * ( y + y^3/3 + y^5/5 + ... )
# donde y = (x-1)/(x+1)
# ------------------------------------------------------
calcular_ln:
    # Leer x
    la   $a0, ingresar_ln
    li   $v0, 4
    syscall
    li   $v0, 6
    syscall
    mov.s $f1, $f0      # x en f1

    # y = (x-1)/(x+1)
    l.s  $f2, constante_uno
    sub.s $f3, $f1, $f2   # x-1
    add.s $f4, $f1, $f2   # x+1
    div.s $f5, $f3, $f4   # y en f5

    # inicializar sumatoria
    mov.s $f12, $f0       # ln(x) = 0
    l.s  $f12, constante_cero

    # vamos a usar 15 t�rminos
    li   $t0, 1           # primer exponente impar = 1
    li   $t1, 0           # contador de t�rminos
    mov.s $f6, $f5        # acumulador potencia y^n, arranca en y

loop_ln:
    beq  $t1, 15, fin_ln

    # potencia actual: y^n (ya en f6)
    # t�rmino = y^n / n
    mtc1  $t0, $f7
    cvt.s.w $f7, $f7
    div.s $f8, $f6, $f7

    # suma
    add.s $f12, $f12, $f8

    # siguiente potencia: y^(n+2)
    mul.s $f6, $f6, $f5   # * y
    mul.s $f6, $f6, $f5   # * y otra vez

    # avanzar n (siguiente impar)
    addi $t0, $t0, 2
    addi $t1, $t1, 1
    j loop_ln

fin_ln:
    # multiplicar por 2
    l.s  $f9, constante_dos
    mul.s $f12, $f12, $f9

    # Mostrar resultado
    la   $a0, resultado_ln
    li   $v0, 4
    syscall
    li   $v0, 2
    syscall

    j loop_main

# ======================================================
# FIN PROGRAMA
# ======================================================
fin_programa:
    li $v0, 10
    syscall