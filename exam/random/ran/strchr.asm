%include "io.mac"

extern strlen
extern printf


section .rodata
    test_str db "hell, it's about time", 0
    format db "length = %d", 10, 0

section .text
global main


main:
    push ebp
    mov ebp, esp



    push test_str
    call strlen
    add esp, 4

    push eax        ;; imi salvez valoarea de la primul strlen

    push eax
    push format
    call printf
    add esp, 8


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.

    xor eax, eax
    push test_str
    call my_strlen
    add esp, 4
    
    push eax

    push eax
    push format
    call printf
    add esp, 8

    pop eax
    pop ebx
    cmp ebx, eax
    je equal_printf

    PRINTF32 `lungimile nu sunt egale %d\n\x0`, eax

return_printf:
    ; Return 0.
    xor eax, eax
    leave
    ret

equal_printf:
    PRINTF32 `lungimile sunt egale\n\x0`
    jmp return_printf
    
;; my_strlen (char* string)
my_strlen:
    enter 0, 0

    ;; string iterator
    mov ebx, dword [ebp + 8]
    cmp byte [ebx], 0
    je end_of_string

    inc eax
    inc ebx
    push ebx
    call my_strlen
    add esp, 4

end_of_string:
    leave
    ret
