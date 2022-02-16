%include "utils/printf32.asm"


section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012


section .text
global main
    extern printf
    global main


main:
    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.
    mov eax, dword [val1]
    test eax, eax
    js has_sign_bit_v1
    jmp no_sign_bit_v1

has_sign_bit_v1:
    PRINTF32 `variable has sign bit!\n\x0`, eax
    jmp count_bits

no_sign_bit_v1:
    PRINTF32 `variable has no sign bit!\n\x0`, eax



    ; TODO b: Prin number of bits for integer value.
count_bits:
    xor edx, edx
    xor eax, eax
    mov eax, 1
    xor ecx, ecx
while:
    test eax, [val1]
    jnz add_1

while_cond:
    shl eax, 1
    inc ecx
    cmp ecx, 32
    jl while

    PRINTF32 `variable has %d bits!\n\x0`, edx
    jmp count_bits_vec

add_1:
    inc edx
    jmp while_cond


    ; TODO c: Prin number of bits for array.
count_bits_vec:
    xor edx, edx

    mov ecx, len2
    dec ecx

big_while:
    push ecx


    xor ebx, ebx
    mov ebx, [arr2 + ecx]
    xor eax, eax
    inc eax
    xor ecx, ecx
small_while:
    test ebx, eax
    jnz add_1_vec
small_while_cond:
    shl eax, 1
    inc ecx
    cmp ecx, 8
    jl small_while

    PRINTF32 `vector has %d bits!\n\x0`, edx

    pop ecx
    dec ecx
    cmp ecx, 0
    jge big_while

    PRINTF32 `vector has %d bits!\n\x0`, edx

    ; Return 0.
    xor eax, eax
    leave
    ret

add_1_vec:
    inc edx
    jmp small_while_cond