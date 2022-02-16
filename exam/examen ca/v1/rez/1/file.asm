%include "utils/printf32.asm"
extern printf

section .data
    arr1 dd -100, 200, 300, -400, -950, 230, 900, -230, -180, 100
    arr2 dd 300, 900, -200, -300, -50, -70, -800, -30, -280, 120
    N dd 10
    res times 10 dd 0

    ;TODO c: definiti vectorul 'res' cu dimensiunea `N` elemente de tip double word (4 octeti)

section .text
global main
extern printf

main:
    push ebp
    mov ebp, esp
       
        sub esp, [N]
    sub esp, [N]
    sub esp, [N]
    sub esp, [N]

    mov [res], esp

    push dword [N]
    push dword  [res]
    push arr2
    push arr1
    call print_dif
    add esp, 16

    push dword [N]
    push dword [res]
    call print_sum_mod
    add esp, 8


    ; TODO a: afisati vectorul arr1

    push dword [N]
    push arr1
    call print_vec
    add esp, 8




    ; TODO b: afisati modulul fiecarui element din vectorul `arr2`
    ; modulul unui numar x, este definit astfel:
    ;   |x| =
    ;       * x, daca x >= 0
    ;       * -x, daca x < 0
    
    push dword [N]
    push arr1
    call print_vec_mod
    add esp, 8


    ; TODO c: Determinati suma modulelor numerelor din vectorul arr1
    ; s = |arr1[0]| + |arr1[1]| + ... + |arr1[N-1]|
    push dword [N]
    push arr1
    call print_sum_mod
    add esp, 8


    PRINTF32 `sum is %d\n\x0`, eax


    ; TODO d: Completati vectorul `res` astfel incat fiecare element res sa fie modulul diferentei
    ; elementelor din vectorii `arr1` si `arr2`
    ; res[i] = |arr1[i] - arr2[i]|, 0 <= i < N





    ; TODO d: Afisati vectorul `res`
    ; push dword [N]
    ; push ebx
    ; call print_vec_mod
    ; add esp, 8

    ; Return 0.
    ; xor eax, eax

    leave
    ret



print_vec:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push eax

    mov ebx, [ebp + 8]

    xor ecx, ecx
print_v:
    xor eax, eax
    mov eax, [ebx + ecx * 4]
    PRINTF32 `%d \x0`, eax

    inc ecx
    mov edx, [ebp + 12]
    cmp ecx, edx
    jl print_v

    pop eax
    pop ecx
    pop ebx
    PRINTF32 `\n\x0`, eax

    leave
    ret


print_vec_mod:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push eax

    mov ebx, [ebp + 8]

    xor ecx, ecx
print_v_mod:
    xor eax, eax
    mov eax, [ebx + ecx * 4]

    ; PRINTF32 `%d \x0`, eax


    mov edx, eax ; Duplicate value
    shr edx, 31 ; Fill edx with its sign
            ;     PRINTF32 `\n eax %u \n\x0`, edx

            ; PRINTF32 `\n eax %u \n\x0`, eax

    ; xor eax, edx ; Do 'not eax' if negative
    ;     PRINTF32 `eax %u \n\x0`, eax
    
    cmp edx, 1
    je not_eax
back:

    ; PRINTF32 `edx %x \n\x0`, edx

    add eax, edx ; Do 'inc eax' if negative

    ; sar edx, 0x1f
    ; xor eax, edx
    ; sub eax, edx

    ; PRINTF32 `%d \n\x0`, eax

    lea edx, [ebx + ecx * 4]
    mov [edx], eax

    inc ecx
    mov edx, [ebp + 12]
    cmp ecx, edx
    jl print_v_mod

    pop eax
    pop ecx
    pop ebx

    leave
    ret



print_sum_mod:
    push ebp
    mov ebp, esp

    push ebx
    push ecx

    mov ebx, [ebp + 8]
    push 0

    xor ecx, ecx
print_s_mod:
    xor eax, eax
    mov eax, [ebx + ecx * 4]

    pop edx
    add edx, eax
    push edx

    PRINTF32 `%d \x0`, eax

    inc ecx
    mov edx, [ebp + 12]
    cmp ecx, edx
    jl print_s_mod

    PRINTF32 `\n\x0`, eax

    pop eax

    pop ecx
    pop ebx

    leave
    ret


not_eax:
    not eax
    jmp back





print_dif:
    push ebp
    mov ebp, esp

    push eax
    push ebx
    push ecx
    push edx
    


    xor ecx, ecx
print_dif_mod:
    mov ebx, [ebp + 8]
    xor eax, eax
    mov eax, [ebx + ecx * 4]

    mov ebx, [ebp + 12]
    sub eax, [ebx + ecx * 4]



    mov edx, eax ; Duplicate value
    shr edx, 31 ; Fill edx with its sign
    cmp edx, 1
    je not_eax_mod
back_mod_2:
    add eax, edx ; Do 'inc eax' if negative

        ; PRINTF32 `%d \x0`, eax

    
    mov ebx, [ebp + 16]
    lea edx, [ebx + ecx * 4]
    mov [edx], eax
    
    inc ecx
    mov edx, [ebp + 20]
    cmp ecx, edx
    jl print_dif_mod
    
    pop edx
    pop ecx
    pop ebx
    pop eax

    leave
    ret

not_eax_mod:
    not eax
    jmp back_mod_2
