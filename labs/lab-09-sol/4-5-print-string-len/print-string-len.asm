section .data
    mystring db "This is my string", 0
    print_format db "String length is %d", 10, 0

section .text

extern printf
global main

main:
    push ebp
    mov ebp, esp

    mov eax, mystring
    xor ecx, ecx
again:
    mov bl, byte [eax]
    inc eax
    inc ecx
    test bl, bl
    jne again

    dec ecx
    push ecx
    push print_format
    call printf
    add esp, 8

    leave
    ret
