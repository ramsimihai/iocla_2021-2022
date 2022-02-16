%include "../utils/printf32.asm"

section .data
    N dd 9 ; compute the sum of the first N fibonacci numbers
    print_format_1 db "Sum first %d", 10, 0
    print_format_2 db "fibo is %d", 10, 0
    
section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    push dword [N]
    push print_format_1
    call printf
    add esp, 8
    
    ; TODO: calculate the sum of first N fibonacci numbers
    ;       (f(0) = 0, f(1) = 1)
    xor eax, eax     ;store the sum in eax
    
    xor ebx, ebx     ; f(0)
    mov edx, 1       ; f(1)
    
    cmp dword[N], 1
    je print         ; fib(0)
    cmp dword[N], 2
    je inc_print     ; fib(1) + fib(0)
    
    mov ecx, [N]
    dec ecx
start:
    add eax, edx
    push eax         ; save the sum
    mov eax, edx     ; save fib(n)
    add edx, ebx     ; fib(i + 1) = fib(i) + fib(i - 1)
    mov ebx, eax     ; fib(i - 1) is previous fib(N)
    pop eax
    loop start 
    jmp print
    
inc_print:
    inc eax
print:

    push eax
    push print_format_2
    call printf
    add esp, 8
    xor eax, eax
    leave
    ret