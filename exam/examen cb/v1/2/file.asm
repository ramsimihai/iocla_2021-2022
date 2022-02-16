extern puts
extern strlen

section .data
    s0          db "", 0
    s1          db "mY BAD HABiTs lEAD To wIdE eYeS sTaRe intO spACE", 0
    s2          db "cOnVeRsAtIoNs wItH A StRaNgEr i bArElY KnOw", 0
    s3          db "YO SOY, yO soy CaPiTaN PiNgAlOcA, y tO' mUnDo aQui, mE SiRvE A Mi o vA", 0
    s4          db "Eu sunt Barbu Lautaru", 0
    s5          db "STAROSTELE SI COBZARUL", 0
    s_arr       dd s4, s5
    s_arr_len   dd 2

section .text
global main

lwr:
    push ebp
    mov ebp, esp

    ; TODO a
	mov eax, [ebp + 8]		; char *

lower_loop:
	cmp byte [eax], 0
	je lwr_end

	mov dl, byte [eax]

	;; check if it s an uppercase
	cmp dl, 'A'
	jb lower_next

	cmp dl, 'Z'	
	ja lower_next

	add dl, 0x20
	
	mov byte [eax], dl

lower_next:	
	inc eax
	jmp lower_loop

lwr_end:
    leave
    ret

reverse:
    push ebp
    mov ebp, esp

    ; TODO b
	; get strlen
	push dword [ebp + 8]
	call strlen
	add esp, 4

	mov ecx, eax
	mov eax, [ebp + 8]

	dec ecx			; the last is \0, no need to change it
	push ebx		; callee-saved
	xor ebx, ebx
reverse_loop:
	xor edx, edx
	mov dl, byte [eax + ebx]
	push edx
	mov dl, byte [eax + ecx]
	mov byte [eax + ebx], dl
	pop edx
	mov byte [eax + ecx], dl

	dec ecx
	inc ebx

	cmp ebx, ecx
	jb reverse_loop


    leave
    ret

map_lwr:
    push ebp
    mov ebp, esp

    ; TODO c
	mov eax, [ebp + 8]		; array of char *	
	mov ecx, [s_arr_len]	; len

map_loop
	push eax
	push ecx

	mov ebx, dword [eax]

	push ebx
	call lwr
	add esp, 4

	pop ecx
	pop eax	
	add eax, 4

loop map_loop

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; Test a
    push s1
    call lwr
    add esp, 4

    push s1
    call puts
    add esp, 4

    push s2
    call lwr
    add esp, 4

    push s2
    call puts
    add esp, 4

    push s3
    call lwr
    add esp, 4

    push s3
    call puts
    add esp, 4

    ; OUTPUT Test a
    ; my bad habits lead to wide eyes stare into space
    ; conversations with a stranger i barely know
    ; yo soy, yo soy capitan pingaloca, y to' mundo aqui, me sirve a mi o va

    ; Test b
    push s0
    call puts
    add esp, 4

    push s3
    call reverse
    add esp, 4

    push s3
    call puts
    add esp, 4

    ; OUTPUT Test b
    ; av o im a evris em ,iuqa odnum 'ot y ,acolagnip natipac yos oy ,yos oy

    ; Test c
    push s0
    call puts
    add esp, 4
    
    push dword[s_arr_len]
    push s_arr
    call map_lwr
    add esp, 8

    push dword[s_arr]
    call puts
    add esp, 4

    push dword[s_arr + 4]
    call puts
    add esp, 4

    ; OUTPUT Test c
    ; eu sunt barbu lautaru
    ; starostele si cobzarul

    xor eax, eax
    leave
    ret
