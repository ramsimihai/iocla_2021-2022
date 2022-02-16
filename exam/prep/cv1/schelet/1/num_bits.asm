%include "utils/printf32.asm"
extern printf

section .data
    arr1 db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x99, 0x88
    len1 equ $-arr1
    arr2 db 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef
    len2 equ $-arr2
    val1 dd 0xabcdef01
    val2 dd 0x62719012


section .text
global main



main:
    push ebp
    mov ebp, esp


    ; TODO a: Print if sign bit is present or not.

    ; mask with most significat bit activated
    mov eax, 1
    ; PRINTF32 `%d\n\x0`, eax

    shl eax, 31
    ; PRINTF32 `%d\n\x0`, eax

    ;; check if a variable has the sign bit activated
    and eax, dword[val1]
    ; PRINTF32 `%d\n\x0`, eax

    test eax, eax
    jz no_sign_bit
    jmp sign_bit

sign_bit:
    PRINTF32 `sign bit\n\x0`
    jmp go_past_ex_1

no_sign_bit:
    PRINTF32 `no sign bit\n\x0`

go_past_ex_1:



    ; TODO b: Prin number of bits for integer value. (bits activated)
    xor ecx, ecx
    mov eax, dword[val1]
    mov edx, 1              ; used as mask

shift_loop:
    mov ebx, eax
    and ebx, edx
    jz continue_loop

    inc ecx
    continue_loop:
        shr eax, 1
        jnz shift_loop

    PRINTF32 `%d\n\x0`, ecx


    ; TODO c: Prin number of bits for array.
    mov eax, 0                  ; counter for the bits
    mov ecx, len1
loop_array:
    xor ebx, ebx
    mov bl, byte[arr1 + ecx - 1]

    push ecx
    mov ecx, 8
    loop_bits:
        mov edx, 1              ; mask
        and edx, ebx
        jz continue_loop_bits
        inc eax

        continue_loop_bits:
        shr ebx, 1
        loop loop_bits
    
    pop ecx
    loop loop_array

    PRINTF32 `%d\n\x0`, eax


    ; Return 0.
    xor eax, eax
    leave
    ret
