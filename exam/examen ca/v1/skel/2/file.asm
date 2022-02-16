extern scanf
extern strchr
extern strlen
extern printf
extern puts

section .data
    printf_fmt_int: db "%d", 10, 0
    alice:          db "Alice", 0
    bob:            db "bob", 0
    scanf_fmt:      db "%10s", 0
    string:         times 11 db 0

section .text
global main

mystrchr:
    push ebp
    mov ebp, esp

    ; TODO a

    leave
    ret

is_lower:
    push ebp
    mov ebp, esp

    ; TODO b

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    xor eax, eax
    mov al, 'i'
    push eax
    push alice
    call mystrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    xor eax, eax
    mov al, 'x'
    push eax
    push bob
    call mystrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    ; OUTPUT:
    ; 2
    ; -1

    ; TODO b
    push alice
    call is_lower
    add esp, 4
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    push bob
    call is_lower
    add esp, 4
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    ; OUTPUT:
    ; -1
    ; 0

    ; TODO c

    xor eax, eax
    leave
    ret
