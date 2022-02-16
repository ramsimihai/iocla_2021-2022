%include "utils/printf32.asm"
extern printf

section .data

arr dd 9, 7, 100, 20, 90, 97, 192, 1000, 256, 999
N equ 10
q dd 3

section .bss
    res1: resd N
    len1: resd 1
; TODO c:
;   - definiti vectorul res1 cu elemente de tip dword si dimensiunea maxima egala cu N
;   - definiti variabla len1 de tipul dword care va retine dimensiunea efectiva a vectorului res1

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Afisati restul impartirii elementului arr[7] la numarul referit de adresa Q
    ; Reamintim folosirea instructiunii div
    ; dividend  -> EDX : EAX
    ; divisor   -> r/m32
    ; quotient  -> EAX
    ; remainder -> EDX
    mov eax, [arr + 4 * 3]
    mov ecx, [q]
    xor edx, edx
    div ecx

    PRINTF32 `remainder is %d\n\x0`, edx

    ; PRINTF32 `N is %d\n\x0`, edx
    ; TODO b: Calculați și afișați suma numerelor divizibile cu 3 din vectorul arr

    xor eax, eax
    push eax


    xor ecx, ecx
iterate_array:
    mov eax, [arr + ecx * 4]

    mov ebx, [q]
    xor edx, edx
    div ebx

    cmp edx, 0
    je add_to_sum
    

return_point:

    inc ecx
    mov edx, N
    cmp ecx, edx
    jl iterate_array


    pop eax
    PRINTF32 `sum is %d\n\x0`, eax
    ; TODO c: Completati vectorul `res1` cu elementele din vectorul arr
    ; care dau restul 1 la impartirea cu 3.
    ; Retineti dimensiunea vectorului `res1` in variabila len1

    mov [len1], dword N
    mov eax, [len1]
    PRINTF32 `sum is %d\n\x0`, eax
    
    xor eax, eax
    push eax
    xor ecx, ecx
iterate_array_c:
    mov eax, [arr + ecx * 4]

    mov ebx, [q]
    xor edx, edx
    div ebx

    cmp edx, 1
    je add_to_array
    

return_point_array:

    inc ecx
    mov edx, N
    cmp ecx, edx
    jl iterate_array_c

    ; Return 0.
    xor eax, eax
    leave
    ret

add_to_array:
    mov eax, [arr + 4 * ecx]
    pop edx

    lea ebx, [res1 + 4 * edx]
    mov [ebx], eax

    PRINTF32 `%d \x0`, [ebx]
    

    inc edx
    push edx

    jmp return_point_array

add_to_sum:
    mov eax, [arr + 4 * ecx]
    pop edx
    add edx, eax
    push edx
    xor edx, edx
    xor eax, eax

    jmp return_point
