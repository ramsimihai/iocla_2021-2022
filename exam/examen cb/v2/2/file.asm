%include "utils/printf32.asm"
extern printf
extern puts
extern strlen

section .data
    printf_fmt_int_newline  db "%d", 10, 0
    s0                      db "", 0
    s1                      db "my bad habits lead to wide eyes stare into space", 0
    s2                      db "conversations with a stranger I barely know", 0
    s3                      db "eu", 0
    s4                      db "sunt", 0
    s5                      db "barbu", 0
    s6                      db "lautaru", 0
    s_arr                   dd s3, s4, s5, s6
    s_arr_len               dd 4

section .text
global main

title:
    push ebp
    mov ebp, esp
    pusha

    ; TODO a
    mov eax, [ebp + 8]
    sub byte[eax], 32

    mov ecx, 0

forParcurgere:
    cmp byte[eax + ecx], 0
    je iesireForParcurgere
    inc ecx
    jmp forParcurgere

iesireForParcurgere:
    dec ecx
    sub byte[eax + ecx], 32

    popa
    leave
    ret

; -----------------------------------------
numarPos:
    mov eax, 1
    jmp scmp

verificareSfarsitStr2:
    cmp byte[ecx], 0
    jne numarNeg
    mov eax, 0
    jmp scmp_end

numarNeg:
    mov eax, -1
    jmp scmp_end

intoarceEAXneg:
    mov eax, -1
    jmp scmp_end

intoarceEAXpos:
    mov eax, 1
    jmp scmp_end

scmp:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push edx
    ; TODO b

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    mov edx, 0

forStrCmp:
    cmp byte[ebx], 0
    je verificareSfarsitStr2
    cmp byte[ecx], 0
    je numarPos
    xor edx, edx
    ; PRINTF32 `%hhd %hhd\n\x0`, byte[ebx], byte[ecx]
    mov dl, byte[ebx]
    cmp dl, byte[ecx]
    jl intoarceEAXneg
    jg intoarceEAXpos

    inc ebx
    inc ecx
    jmp forStrCmp

scmp_end:
    pop edx
    pop ecx
    pop ebx

    leave
    ret


map_title:
    push ebp
    mov ebp, esp
    pusha
    
    ; TODO c
    mov eax, [ebp + 8]
    xor ecx, ecx

forPar:
    cmp ecx, [ebp + 12]
    je iesire

    push dword [eax + 4 * ecx]
    call title
    add esp, 4

    ; PRINTF32 `%s\n\x0`,[eax + 4 * ecx]
    inc ecx
    jmp forPar

iesire:

    popa
    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; Test a
    push s1
    call title
    add esp, 4

    push s1
    call puts
    add esp, 4

    push s2
    call title
    add esp, 4

    push s2
    call puts
    add esp, 4

    ; OUTPUT Test a
    ; My bad habits lead to wide eyes stare into space
    ; Conversations with a stranger I barely know

    ; Test b
    push s0
    call puts
    add esp, 4

    push s4
    push s3
    call scmp
    add esp, 8
    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push s5
    push s5
    call scmp
    add esp, 8
    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push s3
    push s4
    call scmp
    add esp, 8
    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT Test b
    ; -1
    ; 0
    ; 1

    ; Test c
    push s0
    call puts
    add esp, 4

    push dword[s_arr_len]
    push s_arr
    call map_title
    add esp, 8

    push dword[s_arr]
    call puts
    add esp, 4

    push dword[s_arr + 4]
    call puts
    add esp, 4

    push dword[s_arr + 8]
    call puts
    add esp, 4

    push dword[s_arr + 12]
    call puts
    add esp, 4

    ; OUTPUT Test c
    ; Eu
    ; Sunt
    ; Barbu
    ; Lautaru

    xor eax, eax
    leave
    ret
