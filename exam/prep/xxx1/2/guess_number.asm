extern rand
extern time
extern srand
extern scanf
extern printf
extern puts


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    msg    db "Insert number: ", 0
    right db "Corect" ,10 ,0
    is_smaller_string db "Numarul introdus este mai mic",10, 0
    is_larger_string db "Numarul introdus este mai mare", 10, 0


section .bss
    num resd 1
    guess resd 1


section .text


; TODO c: Create read_cmp() function.
read_cmp:
    push msg
    call printf
    add esp, 4
    
    push guess
    push uint_format
    call scanf
    add esp, 8
    
    push dword[guess]
    push uint_format_newline
    call printf
    add esp,4
    pop eax ; =guess
    
    cmp eax, [num]
    je ok
    jl less
    push is_larger_string
    call printf
    add esp, 4
    jmp not_ok
less:
    push is_smaller_string
    call printf
    add esp, 4
    jmp not_ok
ok:
    push right
    call printf
    add esp, 4
    mov eax, 1
    ret
not_ok:
    xor eax, eax
    ret

global main
main:
    push ebp
    mov ebp, esp


    ; TODO a: Call srand(time(0)) and then rand() and store return value modulo 100 in num.
    xor eax,eax
    push eax
    call time
    add esp, 4
    push eax
    call srand
    add esp, 4
    
    call rand
    xor edx, edx
    mov ebx, 100
    div ebx
    mov [num], edx
    
    ; Debug only: Print value of num to check it was properly initialized.
    push dword [num]
    push uint_format_newline
    call printf
    add esp, 8

    ; Comment this out when doing TODO b. Uncomment it when doing TODO c and d.
    jmp make_call
    
    ; TODO b: Read numbers from keyboard in an infinite loop.
    
make_call:
    call read_cmp
    cmp eax, 1
    jne make_call
    ; TODO d
    
    ; Return 0.
    xor eax, eax
    leave
    ret
