%include "utils/printf32.asm"
extern printf

section .data

M dd 0xF0000001

arr dd 0x11223344, 0xFF11FF11, 0x12AA12AA, 0xAABBCCDD, 0x10C010C0, 0x17272727, 0x97979797, 0xA1A1A1A1, 0xB2B2B2B2, 0xC4C4C4
len equ 10

section .bss

;TODO c: Declarati vectorul `res` cu elemente de tip intreg si dimensiunea egala cu `len`

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Afișați în binar numărul întreg definit de variabila M.
    ; Cel mai semnificativ bit va fi afișat primul (e.g 0x0000000F -> 0b00000000000000000000000000001111)
    ; Pentru simplificare, se vor afișa 32 de cifre binare chiar dacă biții cei mai semnificativi sunt zero

 

    ; TODO b: Afișați numărul octetilor pari din reprezentarea numărului întreg M (e.g 0x12131415 -> are 2 octeți pari 0x12, 0x14)




    ; TODO c: Completati fiecare element al vectorului `res` cu numărul octetilor pari corespunzator fiecarui element din vectorul `arr`
    ; e.g: elementul `j` al vectorului `res` va contine numarul octetilor pari al intregului de pe pozitia `j` din vectorul `arr`
    ; res [2] = octeti_pari(arr[2]) = octeti_pari(0x12AA12AA) = 4

    ; TODO d: Afisati elementele vectorului `res` pe aceeasi linie separate de spatii.

  

    ; Return 0.
    xor eax, eax
    leave
    ret
