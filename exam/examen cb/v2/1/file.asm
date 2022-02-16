%include "utils/printf32.asm"
extern printf

section .data

M dd 0xFF10FF10

arr dd 0x10101010, 0x11223344, 0x22448800, 0x12121212, 0x42424242, 0x22002200, 0x10001000, 0x20002000, 0x40404040, 0x00000004
len equ 10

section .bss

;TODO c: Alocati vectorul `res` cu `len` elemente intregi (double word)
    res times len dd 0

section .text
global main

calMedAritmetica:
    enter 0, 0

    mov edx, [ebp + 8]

    push ebx
    push ecx
    push edx

    push edi
    xor eax, eax
    xor ebx, ebx
    mov al, dl
    mov bx, dx
    sub ebx, eax
    shr ebx, 8
    mov ecx, edx
    shl ecx, 8
    shr ecx, 24
    xor edi, edi
    mov edi, edx
    shr edi, 24

    xor edx, edx
    add eax, ebx
    add eax, ecx
    add eax, edi
    mov ecx, 4
    div ecx

    pop edi

    pop edx
    pop ecx
    pop ebx

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: Calculati produsul octetilor numarului M interpretati ca numere fara semn
    push edi
    xor eax, eax
    xor ebx, ebx
    mov al, byte [M]
    mov bx, word[M]
    sub ebx, eax
    shr ebx, 8
    mov ecx, [M]
    shl ecx, 8
    shr ecx, 24
    xor edi, edi
    mov edi, [M]
    shr edi, 24
    
    mul ebx
    mul ecx
    mul edi
    PRINTF32 `%d\n\x0`, eax

    ; TODO b: Calculați media aritmetica a octetilor numarului M interpretati ca numere fara semn.

    push dword[M]
    call calMedAritmetica
    add esp, 4

    PRINTF32 `%d\n\x0`, eax

    pop edi

    ; TODO c: Completati vectorul `res` de dimensiunea `len` astfel incat:
    ; - elementul`res[i]` este egal cu media aritmetica a octetilor intregului (double word) fara semn `arr[i]`
    ; -e,g: res[0] = amean(arr[0]) = (0x10 + 0x10 + 0x10 + 0x10) / 4 = (16 + 16 + 16 + 16) /4 = 32

    mov ecx, len
    PRINTF32 `\n\x0`
forPentruParcurgere:
    push ecx
    dec ecx

    mov eax, dword[arr + 4*ecx]
    push eax
    call calMedAritmetica
    add esp, 4

    mov dword [res + 4*ecx], eax
    pop ecx
    loop forPentruParcurgere


    ; TODO d: Afisati vectorul `res` de dimensiune `len` cu elementele pe aceeasi linie separate de spatii
    mov ecx, len

forPentruAfisare:
    push ecx
    mov edx, len
    sub edx, ecx
    PRINTF32 `%d \x0`, [res + 4*edx]
    pop ecx
    loop forPentruAfisare


    ; Return 0.
    xor eax, eax
    leave
    ret
