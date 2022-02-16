%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123
    format db "%s", 10, 0
    format_int db "%d ", 0

    orig dd 1, 2, 3, 4
    orig_size equ ($-orig)/4
    sqrd dd 0, 0, 0, 0

;;  TODO d: declare byte_array so that PRINT_HEX shows babadac 
byte_array db 0xac, 0xad, 0xab, 0x0b
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:
    enter 0, 0

    ; mov ecx, dword[ebp + 12]
    ; mov edx, ecx
    mov eax, dword[ebp + 8]

    ; shr ecx, 1

    xor ebx, ebx
    mov edx, dword[ebp + 12]
    dec edx

for_swaps:
    mov cl, byte[eax + ebx]
    push ecx
    mov cl, byte[eax + edx]
    mov byte[eax + ebx], cl
    pop ecx

    mov byte[eax + edx], cl

    inc ebx
    dec edx

    cmp ebx, edx
    jl for_swaps

    leave
    ret

; TODO c: implement pow_arraypowArray
pow_array:
    enter 0, 0

    mov eax, dword[esp + 8]
    mov edx, dword[esp + 16]
    mov ecx, dword[esp + 12]

loop_for:
    mov ebx, dword[eax + (ecx - 1) * 4]
    
    push eax
    push edx

    mov eax, ebx
    mul ebx
    mov ebx, eax

    pop edx
    pop eax

    mov dword[edx + (ecx - 1) * 4], ebx

    loop loop_for

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'
    mov byte[esp], 0
    sub esp, 20

    xor edx, edx
    mov dl, 'A'
for_l:
    mov byte[esp + edx - 'A'], dl

    inc edx
    cmp edx, 'T'
    jle for_l

    push esp
    push format
    call printf
    add esp, 8


    ;TODO b: call array_reverse and print reversed array
    push 20
    push esp
    add dword[esp], 4
    call array_reverse
    add esp, 8

    push esp
    push format
    call printf
    add esp, 8


    ;TODO c: call pow_array and print the result array
    push sqrd
    push orig_size
    push orig
    call pow_array
    add esp, 12

    mov ecx, orig_size
print_loop:
push ecx
    push dword[sqrd + (ecx - 1) * 4]
    push format_int
    call printf
    add esp, 8
    pop ecx

    loop print_loop
    PRINTF32 `\n\x0`

	;;  TODO d: this print of an uint32_t should print babadac 
	PRINTF32 `%x\n\x0`, dword[byte_array]

    xor eax, eax
    leave
    ret
