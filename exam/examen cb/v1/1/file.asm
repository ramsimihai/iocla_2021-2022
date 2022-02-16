%include "utils/printf32.asm"
extern printf

section .data

M dd 91

arr dd 11, 123, 199, 201, 333, 400, 410, 940, 130, 444
len equ 10

res times len dd 0

section .bss

; TODO c: Declarati vectorul `res` de intregi (double word) de dimensiune `len`

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Determinati ultima cifră a numărului M reprezentat în zecimal (e.g ultima cifra a numarului 91, este 1)
	mov eax, [M]
	xor edx, edx
	cdq
	mov ecx, 10
	div ecx
	PRINTF32 `%\d\n\x0`, edx



    ; TODO b: Verificati daca numarul natural M > 2, este prim. Afisați `1` dacă numărul `M` este prim și `0` altfel.
    ; - un număr este prim dacă se divide oar doar cu `1` și cu el însuși. (e.g 13 este prim, 28 nu este prim).
	mov eax, [M]
	mov ecx, 2
check_prime:
	xor edx, edx
	cdq
	mov ebx, 10
	div ebx
	test edx, edx
	jnz fail
	inc ecx
	cmp ecx, [M]
	jae success
	jmp check_prime

fail:
	PRINTF32 `0\n\x0`
	jmp b_end

success:
	PRINTF32 `1\n\x0`

b_end:
    ; TODO c: Completati vectorul `res` de dimensiune `len` astfel:
    ;   - elementul res[i] reprezinta ultimele doua cifre din reprezentarea zecimala a elementului arr[i]
    ;   - e.g (133 -> 33, 100 -> 0, 108 -> 8, 1342 -> 42, 1000 -> 0, 1230 -> 30)
	mov edi, res
	mov esi, arr
	mov ecx, len

digit_loop:
	; take number from arr
	mov eax, dword [esi]
	add esi, 4

	; take first digit
	xor edx, edx
	mov ebx, 10
	cdq
	div ebx
	push edx			; storing the last digit on the stack

	xor edx, edx
	cdq
	div ebx

	xchg eax, edx		; putting in eax the next digit
	mul ebx				; now in eax i have digit * 10
	pop ebx				; restoring the last digit
	add eax, ebx		; generate the number

	mov dword [edi], eax
	add edi, 4			; put the result

	loop digit_loop

    ; TODO d: Afisati vectorul `res` de dimensiune `len` cu elementele pe aceeasi linie separate de spatii

	mov eax, res
	mov ecx, len
print_loop:
	PRINTF32 `%d \x0`, [eax]
	add eax, 4
	loop print_loop

	PRINTF32 `\n\x0`
    ; Return 0.
    xor eax, eax
    leave
    ret
