%include "printf32.asm"
extern scanf
extern strrchr
extern strlen
extern printf
extern puts

section .data
    printf_fmt_int: db "%d", 10, 0
    anna:           db "Anna", 0
    scanf_fmt:      db "%10s", 0
    string:         times 11 db 0

section .bss
    buffer: resb 32

section .text
extern printf
extern fgets
extern stdin
global main

;; cauta un caracter dat intr-un string si afiseaza 1 daca se afla in string, altfel -1
;; mystrchr(char *str, char chr)
mystrrchr:
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]
    xor eax, eax
iterate_string:
    ; pop ecx

    mov dl, byte [ebx]

    mov dl, byte [ebx]
    mov cl, byte [ebp + 12]

    cmp dl, cl
    je exists

    add ebx, 1
    add eax, 1


    mov dl, [ebx]
    cmp dl, 0
    jne iterate_string

    xor eax, eax

    xor eax, eax
    mov eax, -1
    leave
    ret

exists:

    leave
    ret

;; transforma orice litera in litera mare
;; to_upper(char *string)
to_upper:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    xor eax, eax
iterate_string_v2:
    mov dl, byte [ebx]

    cmp dl, 'A'
    jg change_string


return_to_string:
    add ebx, 1



    mov dl, [ebx]
    cmp dl, 0
    jne iterate_string_v2

   
    leave
    ret


change_string:
    sub dl, 32
    mov [ebx], dl
    jmp return_to_string
main:
    push ebp
    mov ebp, esp


    ; TODO a
    push 'n'
    push anna
    call mystrrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    push 'x'
    push anna
    call mystrrchr
    add esp, 8
    push eax
    push printf_fmt_int
    call printf
    add esp, 8

    ; OUTPUT:
    ; 2
    ; -1

    ; TODO b
    push anna
    call to_upper
    add esp, 4
    push anna
    call puts
    add esp, 4

    ; OUTPUT:
    ; ANNA




;; initializeaza global un buffer, citete de la tastatura un string
;; si apeleaza to_upper sa transformi stringul de la stdin in string cu litere mari
    ; TODO c

    push dword [stdin]
    push dword 32
    push dword buffer
    call fgets
    add esp, 12

    push buffer
    call to_upper
    add esp, 4
    push buffer
    call puts
    add esp, 4
 
    xor eax, eax
    leave
    ret
