.data
    # Menus
.data
    menu_principal: .asciiz "\n--- MENU PRINCIPAL ---\n1. Movimientos\n2. Funcion Trigonometrica\n3. Expresiones Varias\n4. Salir\nSeleccione una opcion: "
    menu_movimientos: .asciiz "\n--- MENU MOVIMIENTOS ---\n1. Movimiento Rectilineo Uniforme (MRU)\n2. Movimiento Circular Uniformemente Acelerado (MCUA)\nSeleccione una opcion: "
    menu_mru: .asciiz "\n--- MRU ---\n1. Calcular distancia\n2. Calcular velocidad\nSeleccione una opcion: "
    menu_mcua: .asciiz "\n--- MCUA ---\n1. Calcular aceleracion angular\n2. Calcular velocidad angular final\nSeleccione una opcion: "
    menu_trigo: .asciiz "\n--- FUNCIONES TRIGONOMETRICAS ---\n1. Calcular tanh(x)\nSeleccione una opcion: "
    menu_expresiones: .asciiz "\n--- EXPRESIONES VARIAS ---\n1. Metodo Newton-Raphson\n2. Sistema de ecuaciones 2x2\nSeleccione una opcion: "

    # Mensajes ingreso datos
    ingresar_velocidad: .asciiz "\nIngrese la velocidad (m/s): "
    ingresar_tiempo: .asciiz "\nIngrese el tiempo (s): "
    ingresar_distancia: .asciiz "\nIngrese la distancia (m): "
    ingresar_radio: .asciiz "\nIngrese el radio (m): "
    ingresar_aceleracion: .asciiz "\nIngrese la aceleracion angular (rad/s^2): "
    ingresar_velocidad_inicial: .asciiz "\nIngrese la velocidad angular inicial (rad/s): "
    ingresar_velocidad_final: .asciiz "\nIngrese la velocidad angular final (rad/s): "
    ingresar_x: .asciiz "\nIngrese el valor de x: "
    ingresar_iteraciones: .asciiz "\nIngrese el numero de iteraciones: "
    ingresar_a: .asciiz "\nIngrese el valor de a: "
    ingresar_b: .asciiz "\nIngrese el valor de b: "
    ingresar_c: .asciiz "\nIngrese el valor de c: "
    ingresar_d: .asciiz "\nIngrese el valor de d: "
    ingresar_e: .asciiz "\nIngrese el valor de e: "
    ingresar_f: .asciiz "\nIngrese el valor de f: "
    resultado_distancia: .asciiz "\nLa distancia es: "
    resultado_velocidad: .asciiz "\nLa velocidad es: "
    resultado_aceleracion: .asciiz "\nLa aceleracion angular es: "
    resultado_velocidad_final: .asciiz "\nLa velocidad angular final es: "

.text
.globl main

main:
loop_main:
    # Mostrar menu principal
    la $a0, menu_principal
    li $v0, 4
    syscall

    # Leer opcion
    li $v0, 5
    syscall
    move $t0, $v0   # opcion principal

    beq $t0, 1, opcion_movimientos
    beq $t0, 2, opcion_trigonometrica
    beq $t0, 3, opcion_expresiones
    beq $t0, 4, fin_programa   # boton salir
    j loop_main

# --------- MOVIMIENTOS --------------
opcion_movimientos:
    la $a0, menu_movimientos
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    beq $t1, 1, submenu_mru
    beq $t1, 2, submenu_mcua
    jr $ra

mru_distancia:
    # Pedir velocidad
    la $a0, ingresar_velocidad
    li $v0, 4
    syscall
    li $v0, 6       # float input
    syscall
    mov.s $f1, $f0  # guardar velocidad

    # Pedir tiempo
    la $a0, ingresar_tiempo
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0  # guardar tiempo

    # Calcular distancia = v * t
    mul.s $f12, $f1, $f2

    # Imprimir resultado
    la $a0, resultado_distancia
    li $v0, 4
    syscall

    li $v0, 2       # print float
    syscall
    
    jr $ra  # volver al menu principal

mru_velocidad:
    # Pedir distancia
    la $a0, ingresar_distancia
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0  # guardar distancia

    # Pedir tiempo
    la $a0, ingresar_tiempo
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0  # guardar tiempo

    # Calcular velocidad = d / t
    div.s $f12, $f1, $f2

    # Imprimir resultado
    la $a0, resultado_velocidad
    li $v0, 4
    syscall

    li $v0, 2       # print float
    syscall
    
    jr $ra   # volver al menu principal

submenu_mru:
    la $a0, menu_mru
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t2, $v0

    beq $t2, 1, ejecutar_mru_dist
    beq $t2, 2, ejecutar_mru_vel
    jr $ra

ejecutar_mru_dist:
    jal mru_distancia
    j loop_main

ejecutar_mru_vel:
    jal mru_velocidad
    j loop_main



submenu_mcua:
    la $a0, menu_mcua
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t3, $v0

    beq $t3, 1, ejecutar_mcua_aceleracion
    beq $t3, 2, ejecutar_mcua_velfinal
    jr $ra

ejecutar_mcua_aceleracion:
    jal mcua_aceleracion
    j loop_main

ejecutar_mcua_velfinal:
    jal mcua_velocidad_final
    j loop_main

mcua_aceleracion:
    # Pedir velocidad angular final
    la $a0, ingresar_velocidad_final
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0   # w_f

    # Pedir velocidad angular inicial
    la $a0, ingresar_velocidad_inicial
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0   # w_0

    # Pedir tiempo
    la $a0, ingresar_tiempo
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f3, $f0   # t

    # Calculo: alpha = (w_f - w_0) / t
    sub.s $f4, $f1, $f2
    div.s $f12, $f4, $f3

    # Imprimir resultado
    la $a0,  resultado_aceleracion
    li $v0, 4
    syscall
    li $v0, 2
    syscall

    jr $ra


mcua_velocidad_final:
    # Pedir velocidad angular inicial
    la $a0, ingresar_velocidad_inicial
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0   # w_0

    # Pedir aceleracion angular
    la $a0, ingresar_aceleracion
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0   # alpha

    # Pedir tiempo
    la $a0, ingresar_tiempo
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f3, $f0   # t

    # Calculo: w_f = w_0 + alpha * t
    mul.s $f4, $f2, $f3
    add.s $f12, $f1, $f4

    # Imprimir resultado
    la $a0, resultado_velocidad_final
    li $v0, 4
    syscall

    li $v0, 2
    syscall

    jr $ra



# --------- TRIGONOMETRICA --------------
opcion_trigonometrica:
    la $a0, menu_trigo
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t4, $v0

    beq $t4, 1, pedir_x_tanh
    jr $ra

pedir_x_tanh:
    la $a0, ingresar_x
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0
    jr $ra

# --------- EXPRESIONES VARIAS --------------
opcion_expresiones:
    la $a0, menu_expresiones
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t5, $v0

    beq $t5, 1, newton
    beq $t5, 2, sistema2x2
    jr $ra

newton:
    la $a0, ingresar_x
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0   # valor inicial x0

    la $a0, ingresar_iteraciones
    li $v0, 4
    syscall
    li $v0, 5       # int
    syscall
    move $t6, $v0   # numero de iteraciones
    jr $ra

sistema2x2:
    la $a0, ingresar_a
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f1, $f0

    la $a0, ingresar_b
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f2, $f0

    la $a0, ingresar_c
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f3, $f0

    la $a0, ingresar_d
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f4, $f0

    la $a0, ingresar_e
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f5, $f0

    la $a0, ingresar_f
    li $v0, 4
    syscall
    li $v0, 6
    syscall
    mov.s $f6, $f0
    jr $ra

# --------- FIN PROGRAMA --------------
fin_programa:
    li $v0, 10
    syscall