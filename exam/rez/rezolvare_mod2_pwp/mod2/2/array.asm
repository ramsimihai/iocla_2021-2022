%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123
;;  TODO d: declare byte_array so that PRINT_HEX shows babadac
    byte_array dd 0xBABADAC
    first_arr    dd  0
    second_arr dd 0

; byte_array db 0  
	
section .text
global main

; TODO b: implement array_reverse
; void arr_rev(char *arr, usigned int length)
array_reverse:
    push ebp
    mov ebp, esp


    push ebx
    push ecx
    push eax

    mov eax, [ebp + 12]
    shr eax, 1
    push eax


    xor ecx, ecx
iterate:
    mov eax, [ebp + 8] ; vector start
    
    mov ebx, [ebp + 12]
    dec ebx
    add ebx, eax ; vector end

    add eax, ecx ; left swap
    sub ebx, ecx ; right swap

    push ecx
    
    mov dl, byte [eax]
    mov cl, byte [ebx]
    mov byte [eax], cl
    mov byte [ebx], dl

    pop ecx

    inc ecx
    pop ebx
    push ebx
    cmp ecx, ebx
    jl iterate 

    pop ebx
    xor eax, eax

    pop eax
    pop ecx
    pop ebx

    leave
    ret



; TODO c: implement pow_arraypowArray
; void pow_arrat(char *first, short *second, int size)
pow_array:
    push ebp
    mov ebp, esp

      ;; iterator
    xor ecx, ecx
iterate_arrays:
    mov eax, [ebp + 8]
    add eax, ecx
    
    xor edx, edx
    mov dl, byte [eax]
    xor eax, eax
    mov al, dl
    mul dl

    mov edx, [ebp + 12]
    add edx, ecx
    add edx, ecx

    mov word [edx], ax

    inc ecx
    mov edx, [ebp + 16]
    cmp ecx, edx
    jl iterate_arrays


    leave
    ret





main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    sub esp, 20
    mov [first_arr], esp
    
    xor ecx, ecx
    mov al, "A"
fill:
    mov [esp + ecx], al
    inc al
    inc ecx
    cmp ecx, 20
    jl fill


    push esp
    call print_vec
    add esp, 4

;     xor ecx, ecx
; print:
;     xor eax, eax
;     mov al, [esp + ecx]
;     PRINTF32 `%c\n\x0`, eax

;     inc ecx
;     cmp ecx, 20
;     jl print

    ;TODO b: call array_reverse and print reversed array
    mov ebx, esp

    push 20
    push ebx
    call array_reverse
    add esp, 8

    push ebx
    call print_vec
    add esp, 4

    ;TODO c: call pow_array and print the result array
    sub esp, 40 ; allocate 2nd array
    mov [second_arr], esp

    push 20
    push dword [second_arr]
    push dword [first_arr]
    call pow_array
    add esp, 12

    push dword [first_arr]
    call print_vec
    add esp, 4

    push dword [second_arr]
    call print_vec_short
    add esp, 4

	;;  TODO d: this print of an uint32_t should print babadac
	PRINTF32 `%x\n\x0`, [byte_array] 

    xor eax, eax
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
    mov al, [ebx + ecx]
    PRINTF32 `%c \x0`, eax

    inc ecx
    cmp ecx, 20
    jl print_v

    pop eax
    pop ecx
    pop ebx
    PRINTF32 `\n\x0`, eax

    leave
    ret



print_vec_short:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push eax

    mov ebx, [ebp + 8]

    xor ecx, ecx
print_v_short:
    xor eax, eax
    mov ax, [ebx + ecx * 2]
    PRINTF32 `%u \x0`, eax

    inc ecx
    cmp ecx, 20
    jl print_v_short

    pop eax
    pop ecx
    pop ebx
    PRINTF32 `\n\x0`, eax

    leave
    ret