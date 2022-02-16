extern malloc
extern printf
extern strlen

section .data
    printf_fmt_int          db "%d ", 0
    printf_fmt_newline      db 10, 0
    printf_fmt_int_newline  db "%d", 10, 0
    printf_fmt_char_newline db "%c", 10, 0
    arr1                    dd 1, 2, 3, 4, 5, 6, 7
    arr1_len                equ ($ - arr1) / 4
    arr2                    dd 10, 20, 30, 40, 50, 60, 70
    arr2_len                equ ($ - arr2) / 4
    str1                    db "His palms are sweaty, knees weak, arms are heavy", 0
    str2                    db "anutforajaroftuna", 0


section .text
global main

print_arr:
    push ebp
    mov ebp, esp

    ; TODO a
	push ebx
	xor ecx, ecx
	xor eax, eax
	xor edx, edx
	xor ebx, ebx
	mov edx, [ebp + 8] ; vectorul
	mov ebx, [ebp + 12] ;lungimea

loop_elem: 	
	cmp ecx, ebx
	je out
	mov eax, [edx + ecx * 4]
	inc ecx

	pushad
	push eax
	push printf_fmt_int
	call printf
	add esp, 8
	popad
	jmp loop_elem	
out:
	pop ebx
    leave
    ret

sum_arrays:
    push ebp
    mov ebp, esp

    ; TODO b

    leave
    ret

is_palindrome:
    push ebp
    mov ebp, esp

    ; TODO c

    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; Test a
    push arr1_len
    push arr1
    call print_arr
    add esp, 8

    push printf_fmt_newline
    call printf
    add esp, 4

    ; OUTPUT Test a
    ; 1 2 3 4 5 6 7

    ; Test b
    push arr1_len
    push arr2
    push arr1
    call sum_arrays
    add esp, 12

    ; TODO b: Print the array returned by `sum_arrays` using `print_arr`.

    ; OUTPUT Test b
    ; 11 22 33 44 55 66 77

    ; Test c
    push str1
    call is_palindrome
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    push str2
    call is_palindrome
    add esp, 4

    push eax
    push printf_fmt_int_newline
    call printf
    add esp, 8

    ; OUTPUT Test c
    ; -1
    ; 0

    xor eax, eax
    leave
    ret
