extern malloc
extern printf

section .data
    printf_fmt_int:         db "%d ", 0
    printf_fmt_newline:     db 10, 0
    printf_fmt_int_newline: db "%d", 10, 0
    n:                      dd 5
    arr:                    dd 11, 22, 33, 44, 55
section .text
global main


;; Functie ce printeaza un vector void print_arr (char *p, int n) 
print_arr:
    push ebp
    mov ebp, esp


    ; TODO a

    leave
    ret


;; Functie ce calculeaza k*9+10 si returneaza rez
compute:
    push ebp
    mov ebp, esp


    ; TODO b

    leave
    ret

;; O cerinta mai dubioasa, sa faci un array din arr (faci compute pe fiecare element din arr si pui in res rezultatul parca)
new_array:
    push ebp
    mov ebp, esp

    ; TODO c

    leave
    ret

main:
    push ebp
    mov ebp, esp


    ; TODO a
    ; call print_arr
    



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


    push printf_fmt_newline
    call printf
    add esp, 4



    ; OUTPUT:
    ; 10 19 28 37 46 55 64 73 82 91 100


    xor eax, eax
    leave
    ret
