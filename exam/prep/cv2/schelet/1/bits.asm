; %include "utils/printf32.asm"

section .data
    num dd 13456198
    ; 55 55 51 23
    format db "%d %d", 10, 0
    format2 db "%d", 10, 0

section .text
    global main
    extern printf

main:
    push ebp
    mov ebp, esp

    ;TODO a: print least significant 2 bits of the second most significant byte of num
    mov eax, [num]
    shl eax, 8
    shl eax, 6
    shr eax, 30

    mov ebx, eax
    shr ebx, 1
    and eax, 1
    push eax
    push ebx
    push format
    call printf
    add esp, 12

    ;TODO b: print number of bits set on odd positions
    xor ebx, ebx
    mov ecx, 0
    mov eax, dword[num]

loop_bits:
    mov edx, eax
    and edx, 1
    add ebx, edx

    shr eax, 2
    inc ecx
    inc ecx

    cmp ecx, 31
    jl loop_bits

    push ebx
    push format2
    call printf
    add esp, 8



    ;TODO c: print number of groups of 3 consecutive bits set
    mov ecx, 31
    mov eax, dword[num]
    xor edx, edx
loop_bits2:
    shr eax, 1
    mov ebx, eax
    and ebx, 7

    cmp ebx, 7
    je add_pair

    loop loop_bits2
    jmp end

add_pair:
    inc edx
    loop loop_bits2

end:
    push edx
    push format2
    call printf



    xor eax, eax
    leave
    ret