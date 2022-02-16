extern malloc
extern printf

section .data
    printf_fmt_int:         db "%d ", 0
    printf_fmt_newline:     db 10, 0
    printf_fmt_int_newline: db "%d", 10, 0
    n:                      dd 5
    arr:                    dd 11, 22, 33, 44, 55
    newvector               dd 0
    lungime                 dd 0

section .text
global main

print_arr:
    push ebp
    mov ebp, esp
    mov ecx, [ebp+8] ;; arr
    mov edx, [ebp+12] ;; len
    xor eax, eax

    ;push dword [edx+4]
    ;push printf_fmt_int
    ;call printf
    
    loop_print:
        cmp eax, edx
        je end_print

        mov edi, [ecx+4*eax]

        pushad
        push edi
        push printf_fmt_int
        call printf
        add esp, 8
        popad

        inc eax
        jmp loop_print

    end_print:
        xor eax, eax
    ; TODO a

    leave
    ret

compute:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    xor edx, edx
    mov ecx, dword 9
    mul ecx
    add eax, 10


    ; TODO b

    leave
    ret

new_array:
    push ebp
    mov ebp, esp
    mov edx, [ebp+8]
    push edx

    pushad

    mov eax, edx
    xor edx, edx
    mov ecx, 4
    mul ecx
    mov [lungime], eax

    popad


    push dword [lungime]
    call malloc
    mov [newvector],eax
    pop edx

    ;; rez in eax

    xor edi, edi

    loop_new_arr:
        cmp edi, edx
        je end_loop_arr
        
        push eax

        push edx
            push edi
            call compute
            add esp, 4
        pop edx

        mov ebx, eax

        pop eax
        mov [eax + 4*edi], ebx    
        
        push edx
        pop edx

        ; push ecx
        ; push ebx 
        ; push esi
        ; push eax
        ; push edi
        ; push edx

        ; push ebx
        ; push printf_fmt_int
        ; call printf
        ; add esp, 8

        ; pop edx
        ; pop edi
        ; pop eax
        ; pop esi
        ; pop ebx
        ; pop ecx

        add edi, 1
        jmp loop_new_arr

        end_loop_arr:
            


    ; TODO c

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    ; call print_arr

    push dword [n]
    push arr
    call print_arr
    add esp, 8
    



    push printf_fmt_newline
    call printf
    add esp, 4

    ; OUTPUT:
    ; 11 22 33 44 55

    ; TODO b
    push dword[n]
    call compute
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push 100
    call compute
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT:
    ; 55
    ; 910

    ; TODO c
    ; call new_array(11)

    
    push dword 11
    call new_array
    add esp, 4

    push dword 11
    push dword [newvector]
    call print_arr
    add esp, 8
    ; call print_arr

    push printf_fmt_newline
    call printf
    add esp, 4



    ; OUTPUT:
    ; 10 19 28 37 46 55 64 73 82 91 100


    xor eax, eax
    leave
    ret
