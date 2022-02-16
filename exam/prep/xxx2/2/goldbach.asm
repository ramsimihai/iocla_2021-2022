%include "io.inc"

extern fgets
extern stdin
extern printf

section .data
    n            dd 7
    format_str   dd "Number: %d", 10 ,0
    prime_format dd "isPrime: %d", 10, 0
    string       db "%s", 10, 0
    max_size     dd 10
    
section .text
global main

;TODO b: Implement stringToNumber
stringToNumber:
;fast atoi bitch! (vezi tema3)
    mov     ecx, DWORD [esp+4]
    xor     eax, eax
    movsx   edx, BYTE [ecx]
    test    dl, dl
    je      m.L4
m.L3:
    lea     eax, [eax+eax*4]
    add     ecx, 1
    lea     eax, [edx-48+eax*2]
    movsx   edx, BYTE [ecx]
    test    dl, dl
    je      m.L4
    cmp     dl, 10
    jne     m.L3
m.L4:
    ret
;TODO c.: Add missing code bits
isPrime: ; isPrime(int nr) !!
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]
    cmp eax, 1
    je not_prime
    mov ecx, eax
    dec ecx
for: ; redenumire loop:
    cmp ecx, 1
    je prime
    xor edx, edx
    mov eax, [ebp+8]
    div ecx
    cmp edx, 0
    je not_prime ; rest 0
    loop for
prime:    
    mov eax, 1
    jmp done
not_prime:
    mov eax, 0
done:
    leave
    ret


CMAIN:
    push ebp
    mov ebp, esp

    ;TODO a.: allocate space on stack and call fgets

    sub esp, dword[max_size] ; local str starts at [ebp-4]
    
    mov eax, esp
    
    push dword[stdin]
    mov ebx, [max_size]
    push ebx
    push eax ;address of local str
    call fgets
    add esp, 12
    ;TODO b.: call stringToNumber and print it using printf

    mov eax, esp
    push string
    push eax
    call printf
    add esp, 8
    
    mov eax, esp
    push eax
    call stringToNumber
    add esp, 4
        
    push eax
    push format_str
    call printf
    add esp, 4
    pop eax
    NEWLINE
    ;TODO c.: call isPrime and print result
    
    push eax
    call isPrime
    add esp, 4
    
    push eax
    push prime_format
    call printf
    add esp, 8
    NEWLINE
    
    add esp, dword[max_size]
    leave
    ret
