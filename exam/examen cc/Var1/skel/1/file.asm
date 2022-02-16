%include "utils/printf32.asm"
extern printf

section .data

M dd 0x12121212
mask db 0x12


arr dd 0x12345678, 0x12121212, 0x42424242, 0x12771277, 0xCAFEBABE, 0x12001200, 0x20222022, 0x03020302, 0x12FF12FF, 0xFF12FF12
len equ 10

;TODO c: Declarati vectorul de intregi (double word) `res` cu dimensiunea egala cu `len`

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculați și afișati numărul de biți `1` din numărul întreg `M`.
    ; Numărul `M` este definit în secțiunea `.data`.



    ; TODO b: Calculați și afișati numărul de octeți egali cu `mask` din numărul întreg `M`.
    ; Numerele `M` și `mask` sunt definite în secțiunea `data`



    ; TODO c: Completați vectorul `res` de dimensiune `len` astfel:
    ;   - fiecare element res[i] este egal cu numărul de octeți din arr[i] ce au valoarea `mask`


    ; TODO d: Afișați vectorul `res` de dimensiunea `len` completat cu elementele definite la punctul c)
    ;; rezolvarea e la tagul afisare.

    ; Return 0.
    xor eax, eax
    leave
    ret
