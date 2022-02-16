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
    call rec_strlen
    add esp, 4


    push eax
    push format
    call printf
    add esp, 8


    ; TODO a: Implement strlen-like functionality using a RECURSIVE implementation.


    ; Return 0.
    xor eax, eax
    leave
    ret


; int rec_strlen(char *str)
rec_strlen:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor eax, eax
    mov al, byte [ebx]
    cmp al, 0
    je ret_0

    inc ebx
    push ebx
    call rec_strlen
    add esp, 4

    inc eax

end:
    leave
    ret

ret_0:
    xor eax, eax
    jmp end