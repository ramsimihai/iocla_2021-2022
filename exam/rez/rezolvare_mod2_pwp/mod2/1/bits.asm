%include "utils/printf32.asm"

section .data
    num dd 3453235129

section .text
global main
    extern printf
main:
    push ebp
    mov ebp, esp

    xor eax, eax
    ;TODO a: print least significant 2 bits of the second most significant byte of num
    mov al, [num + 1]
    xor ebx, ebx
    inc bl
    shl bl, 1
    inc bl
    and bl, al
    PRINTF32 `bits are %d\n\x0`, ebx


    ;TODO b: print number of bits set on odd positions
        ; TODO b: Prin number of bits for integer value.
count_bits:
    xor edx, edx
    xor eax, eax
    inc eax
    xor ecx, ecx
while:
    test eax, [num]
    jnz add_1

while_cond:
    shl eax, 2
    inc ecx
    cmp ecx, 16
    jl while

    PRINTF32 `variable has %d odd bits!\n\x0`, edx


    ;TODO c: print number of groups of 3 consecutive bits set
    xor edx, edx
    xor eax, eax
    mov eax, 7
    xor ecx, ecx
while_group:
    mov ebx, eax
    and ebx, [num]
    cmp ebx, eax
    jz add_1_group

while_cond_group:
    shl eax, 1
    inc ecx
    cmp ecx, 30
    jl while_group

    PRINTF32 `variable has %d 3 bits groups!\n\x0`, edx


    xor eax, eax
    leave
    ret

add_1:
    inc edx
    jmp while_cond

add_1_group:
    inc edx
    jmp while_cond_group