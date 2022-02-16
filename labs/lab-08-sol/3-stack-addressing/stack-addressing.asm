%include "../utils/printf32.asm"

%define NUM 5
   
section .text

extern printf
global main
main:
    mov ebp, esp
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov dword [esp], ecx
    loop push_nums

    sub esp, 4
    mov dword [esp], 0

    sub esp, 4
    mov dword [esp], "mere"

    sub esp, 4
    mov dword [esp], "are "

    sub esp, 4
    mov dword [esp], "Ana "
    
    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; print the stack in "address: value" format
    mov eax, ebp
print_stack:
    PRINTF32 `0x\x0`
    PRINTF32 `%x\x0`, eax
    PRINTF32 `: 0x\x0`
    PRINTF32 `%x\n\x0`, [eax]

    sub eax, 4
    cmp eax, esp
    jge print_stack

    ; print the string
    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; restore the previous value of the EBP (Base Pointer)
    mov esp, ebp

    ; exit without errors
    xor eax, eax
    ret
