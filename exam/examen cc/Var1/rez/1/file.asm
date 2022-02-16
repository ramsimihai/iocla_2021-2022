%include "utils/printf32.asm"
extern printf

section .data

M dd 0x12121212
mask db 0x12


arr dd 0x12345678, 0x12121212, 0x42424242, 0x12771277, 0xCAFEBABE, 0x12001200, 0x20222022, 0x03020302, 0x12FF12FF, 0xFF12FF12
global res
res: times 10 dd 0
len equ 10

;TODO c: Declarati vectorul de intregi (double word) `res` cu dimensiunea egala cu `len`

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculați și afișati numărul de biți `1` din numărul întreg `M`.
    ; Numărul `M` este definit în secțiunea `.data`.
    mov eax, [M]
    popcnt edx, eax
    PRINTF32 `%d\n\x0`, edx

    ; TODO b: Calculați și afișati numărul de octeți egali cu `mask` din numărul întreg `M`.
    ; Numerele `M` și `mask` sunt definite în secțiunea `data`
    mov ebx, [M]
    xor ecx, ecx
    loop_b:
        cmp ebx, 0
        je end_loop_b
        mov edx, ebx
        shl edx, 24
        shr edx, 24
        cmp edx, [mask]
        je inc_nr
        shr ebx, 8

        inc_nr:
            add ecx, 1
            jmp loop_b


    end_loop_b:
    PRINTF32 `%d\n\x0`, ecx


    ; TODO c: Completați vectorul `res` de dimensiune `len` astfel:
    ;   - fiecare element res[i] este egal cu numărul de octeți din arr[i] ce au valoarea `mask`
    xor ecx, ecx
    loop_c:
        cmp ecx, len
        je end_loop_c
        mov ebx, [arr+4*ecx]
        xor edi, edi
        loop_c_nr:
            cmp ebx, 0
            je end_loop_c_nr
            xor edx, edx
            mov edx, ebx
            shl edx, 24
            shr edx, 24
            cmp edx, 0x12
            je inc_nr_c
            shr ebx, 8
            jmp loop_c_nr

        inc_nr_c:
            add edi, 1
            shr ebx, 8
            jmp loop_c_nr

        end_loop_c_nr:
            mov [res+4*ecx], edi
            inc ecx
            jmp loop_c


    end_loop_c:
        xor edi, edi
        afisare:
            cmp edi, len
            je end_afisare

            PRINTF32 `%d \x0`, [res+4*edi]

            inc edi
            jmp afisare

        end_afisare:
            PRINTF32 `\n\x0`
            


    ; TODO d: Afișați vectorul `res` de dimensiunea `len` completat cu elementele definite la punctul c)
    ;; rezolvarea e la tagul afisare.

    ; Return 0.
    xor eax, eax
    leave
    ret
