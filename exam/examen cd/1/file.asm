%include "utils/printf32.asm"
extern printf

section .data
M dd -20
N dd 90

arr dd -30, -20, -10, 40, 150, 60, 70, 80, 90, 100
len equ 10

section .bss

; TODO b: Declarati variabla de tip `double word` cu numele `in_len`
	in_len: resd 0
; TODO c: Declarati vectorul de intregi (`double word`) `res` cu maximum `len` elemente
	res: resd 0
section .text
global main

main:
    push ebp
    mov ebp, esp

    ; TODO a: Determinați cum este plasat numarul arr[0] relativ la intervalul [M, N], unde M < N. Afisati:
    ; -1, daca numarul arr[0] se afla la stanga intervalului (arr[0] < M)
    ; 0, daca numarul arr[0] se gaseste in intervalul [M, N] (M <= arr[0] <= N)

    ; 1, daca numarul arr[0] se gaseste la dreapta intervalului (arr[0] > N)
	xor ecx, ecx
	mov edx, [M]
	mov ebx, [N]
	mov eax, [arr + ecx] ; primul element
ex1:
	cmp eax, edx
	jl afisare_1
	cmp eax, ebx
	jg afisare_2
	jmp e_in_interval
afisare_1:
	PRINTF32 `%d\n\x0`, -1
	jmp ex2_1
afisare_2:
	PRINTF32 `%d\n\x0`, 1
	jmp ex2_1
e_in_interval:
	PRINTF32 `%d\n\xo`, 0
	jmp ex2_1
    ; TODO b: Calculati si afisati numarul elementelor din vectorul `arr` care se gasesc
    ; in intervalul [M, N]. Retineti aceasta valoare in variabila `in_len` din sectiunea `.bss`.
ex2_1:	
	push edi
	push ebx
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	mov ebx, [M] 
	mov edx, [N]
	xor edi, edi
	
ex2:
	cmp edi, len
	je afisare_in_len
	mov eax, [arr + 4 * edi]
	inc edi
	cmp eax, ebx
	jl nu_e_in_interval
	cmp eax, edx
	jg nu_e_in_interval
	inc ecx
	jmp ex2
nu_e_in_interval:
	jmp ex2
afisare_in_len:
	mov [in_len], ecx	
	PRINTF32 `%d\n\x0`, [in_len]
	pop edi 
	pop ebx
	jmp ex2_5
    ; TODO c: Completati vectorul `res` de dimensiune maxima `len` cu elementele din
    ; vectorul `arr` care se gasesc in intervalul [M, N].
    ; Declarati vectorul `res` in sectiunea `bss`.
ex2_5:
        push edi
        push ebx
	push esi
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        mov ebx, [M]
        mov edx, [N]
        xor edi, edi
	xor esi, esi
	;	PRINTF32 `AM INTRAT AICI`
ex2_3:
   	   cmp edi, len
           je afisare_in_len_2
           mov eax, [arr + 4 * edi]
	   	inc edi
		cmp eax, ebx
    	 jl nu_e_in_interval_2
     cmp eax, edx
        jg nu_e_in_interval_2
        mov [res + 4 * esi], eax
	PRINTF32 `%d \x0`, [res + 4 * esi]
	inc esi
        jmp ex2_3
nu_e_in_interval_2:
        jmp ex2_3
afisare_in_len_2:
	PRINTF32 `\n\x0`
	pop edi
	pop esi
	pop ebx
;	xor esi, esi
 ;       cmp esi, len
;	je finish_afis
	
 ;       PRINTF32 `%d \n\x0`, [res + 4 * esi]
;	inc esi
;	jmp afisare_in_len_2
;finish_afis:
	;pop edi
	;pop ebx
	;pop esi


    ; TODO d: Afisati vectorul `res` de dimensiune `in_len` cu elementele
    ; pe aceeasi linie separate de un spatiu

out:
    ; Return 0.
    xor eax, eax
    leave
    ret
