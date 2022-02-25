section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple for 2 numbers, a and b
cmmmc:
	push ebp
	push esp
	pop ebp

	push dword [ebp + 8]
	pop eax

	push dword [ebp + 12]
	pop ebx

	jmp while_condition
;; calculates greatest common divisior by succesive subtraction
start_while:
	cmp eax, ebx
	jle else_condition
	sub eax, ebx
	jmp while_condition

else_condition:
	sub ebx, eax
while_condition:
	cmp eax, ebx
	jne start_while

	xor ebx, ebx
	push eax
	pop ebx

	;; calculates least common multiple
	push dword [ebp + 8]
	pop eax
	imul eax, [ebp + 12]
	cdq
	idiv ebx

	push esp
	pop ebp
	pop ebp
	ret
