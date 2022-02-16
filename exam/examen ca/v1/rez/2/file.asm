%include "utils/printf32.asm"

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


    mov ecx, [ebp + 8]
iterate_str:
    xor eax, eax
    mov al, [ecx]

    ; PRINTF32 `%c \n\x0`, eax
    xor ebx, ebx
    mov bl, [ebp + 12]
    cmp al, bl
    je found_chr


    inc ecx
    mov al, [ecx]
    cmp al, 0
    jne iterate_str

    mov eax, -1
mystrchr_end:
    leave
    ret

found_chr:
    mov ebx, [ebp + 8]
    sub ecx, ebx
    mov eax, ecx
    jmp mystrchr_end




is_lower:
    push ebp
    mov ebp, esp

    mov ecx, [ebp + 8]
iterate_str_low:
    xor eax, eax
    mov al, [ecx]

    ; PRINTF32 `%c \n\x0`, eax
    cmp al, 'a'
    jl found_chr_bad

    cmp al, 'z'
    jg found_chr_bad

    inc ecx
    mov al, [ecx]
    cmp al, 0
    jne iterate_str_low

    xor eax, eax
islower_end:
    leave
    ret

found_chr_bad:
    mov eax, -1
    jmp islower_end



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
    push string
    push scanf_fmt
    call scanf
    add esp, 8

    push string
    call is_lower
    add esp, 4

    cmp eax, 0
    je show

endify:

    xor eax, eax
    leave
    ret

show:
    PRINTF32 `%s\n\x0`, string
    jmp endify
