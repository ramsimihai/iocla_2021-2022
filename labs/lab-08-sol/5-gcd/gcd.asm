%include "../utils/printf32.asm"

section .text

extern printf
global main
main:
    ; input values (eax, edx) : the 2 numbers to compute the gcd for
    mov eax, 49
    mov edx, 28

    push eax
    push edx

gcd:
    neg eax
    je  L3

L1:
    neg  eax
    push eax
    push edx
    pop eax
    pop edx

L2:
    sub eax,edx
    jg L2
    jne L1

L3:
    add eax,edx
    jne print
    inc eax

print:

    pop edx
    pop ebx

    PRINTF32 `gcd(%d\x0`, ebx
    PRINTF32 `,%d)\x0`, edx
    PRINTF32 ` = %d\n\x0)`, eax ; eax = greatest common divisor

    xor eax, eax
    ret
