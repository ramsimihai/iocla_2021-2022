%include "utils/printf32.asm"
extern printf

section .data
    arr1 dd -100, 200, 300, -400, -950, 230, 900, -230, -180, 100
    arr2 dd 300, 900, -200, -300, -50, -70, -800, -30, -280, 120
    N dd 10

    ;TODO c: definiti vectorul 'res' cu dimensiunea `N` elemente de tip double word (4 octeti)

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: afisati vectorul arr1

    ; TODO b: afisati modulul fiecarui element din vectorul `arr2`
    ; modulul unui numar x, este definit astfel:
    ;   |x| =
    ;       * x, daca x >= 0
    ;       * -x, daca x < 0

    ; TODO c: Determinati suma modulelor numerelor din vectorul arr1
    ; s = |arr1[0]| + |arr1[1]| + ... + |arr1[N-1]|

    ; TODO d: Completati vectorul `res` astfel incat fiecare element res sa fie modulul diferentei
    ; elementelor din vectorii `arr1` si `arr2`
    ; res[i] = |arr1[i] - arr2[i]|, 0 <= i < N

    ; TODO d: Afisati vectorul `res`

    ; Return 0.
    xor eax, eax
    leave
    ret
