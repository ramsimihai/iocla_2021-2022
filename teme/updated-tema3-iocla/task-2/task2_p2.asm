section .text
	global par

;; int par(int str_length, char* str)
; check for balanced brackets in an expression
par:
	push ebp
	push esp
	pop ebp

	;; stack "barrier" aka starting point
	push 99

	;; eax - string iterator || ecx - counter || edx - helper
	push dword [ebp + 12]
	pop eax

	xor ecx, ecx
check_parantheses_for:
	xor edx, edx
	push dword [eax + ecx]
	pop edx
	
	;; checks character is '('
	cmp dl, '('
	je found_left_parantheses

	;; edx is last element on stack
	xor edx, edx
	pop edx
	
	;; checks if stack is empty
	cmp edx, 99
	je got_error

	;; checks character is ')' and top element of stack
	;; is not '(', basically the matching paranthesis
	push dword [eax + ecx]
	pop ebx
	cmp bl, ')'
	je next_condition

return_for:

	;; increase counter
	push dword [ebp + 8]
	pop edx
	inc ecx
	cmp ecx, edx
	jl check_parantheses_for

final_check:
	pop edx

	cmp edx, 99
	jne stack_not_empty
	cmp eax, 1

	je wrong_answer
	push 1
	pop eax

	push ebp
	pop ebp
	pop ebp
	ret

stack_not_empty:
	push 0
	pop eax

	pop edx
	cmp edx, dword 99
	jne stack_not_empty

	push esp
	pop ebp
	pop ebp
	ret
wrong_answer:
	push 0
	pop eax
	
	push esp
	pop ebp
	pop ebp
	ret

got_error:
	;; error = 1
	push 1
	pop eax
	push 99
	jmp final_check

next_condition:
	push edx
	cmp dl, '('
	jne got_error
	
	pop edx
	jmp return_for

found_left_parantheses:
	push edx
	jmp return_for
