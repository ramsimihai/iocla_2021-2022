%include "utils/printf32.asm"

section .data
    num dd 55555123

section .text
extern printf
global main

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num

    mov eax, [num]
    shl eax, 14
    shr eax, 30

    PRINTF32 `%d\n\x0`, eax
    
    ;TODO b: print number of bits set on odd positions

    ;TODO c: print number of groups of 3 consecutive bits set

    xor eax, eax
    leave
    ret
