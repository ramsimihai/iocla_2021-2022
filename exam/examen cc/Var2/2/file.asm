extern printf
extern scanf

section .data
    printf_fmt_int_newline: db "%d", 10, 0
    arr:                    dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700
    N:                      dd 17
    eroare_str: db "Eroare", 0
    format_str: db "%s", 0
    pos1: dd 0
    pos2: dd 0
    fmt: db "%d", 0

section .text
global main

is_pow2:
    push ebp
    mov ebp, esp

    ; TODO a
    

    leave
    ret



sum_interval:
    push ebp
    mov ebp, esp

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a
    push 8
    call is_pow2
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 10
    call is_pow2
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 0
    ; -1

    ; TODO b
    push dword[N]
    push 0
    push arr
    call sum_interval
    add esp, 12

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 3
    push 1
    push arr
    call sum_interval
    add esp, 12

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 15300
    ; 500

    ; TODO c

    push pos1
    push fmt
    call scanf
    add esp, 8

    push pos2
    push fmt
    call scanf
    add esp, 8

    push dword [pos1]
    call is_pow2
    add esp, 4
    cmp eax, 0
    jz next
    jmp exitc
next: 
    push dword [pos2]
    call is_pow2
    add esp, 4
    cmp eax, 0
    jz next2
    jmp exitc
next2:
    push dword [pos2]
    push dword [pos1]
    push arr
    call sum_interval
    add esp, 12

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

exitc:

    xor eax, eax
    leave
    ret
