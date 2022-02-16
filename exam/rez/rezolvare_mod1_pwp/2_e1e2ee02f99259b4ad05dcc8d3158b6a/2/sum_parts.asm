extern scanf
extern printf


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    pos1_str    db "Introduceti prima pozitie: ", 0
    pos2_str   db "Introduceti a doua pozitie: ", 0
    sum_str db "Suma este: %zu", 10, 0
    sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    arr     dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400


section .text
global main

sum:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push edx

    ; TODO b: Implement sum() to compute sum for array.
    xor eax, eax
    mov ecx, [ebp + 12]
while:
    mov ebx, [ebp + 8]
    mov edx, [ebx + ecx * 4]

    add eax, edx

    dec ecx
    cmp ecx, 0
    jge while

    pop edx
    pop ecx
    pop ebx

    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum_interval() to compute sum for array between two positions.

    leave
    ret


main:
    push ebp
    mov ebp, esp


    push dword 14
    push arr
    call sum
    add esp, 8

    push eax
    push sum_str
    call printf
    add esp, 8


    ; TODO b: Call sum_interval() and print result.


    ; TODO c: Use scanf() to read positions from standard input.


    ; Return 0.
    xor eax, eax
    leave
    ret
