section .text
        global expression
        global term
        global factor

; `factor(char *p, int *i)`
;       Evaluates "(expression)" or "number" expressions 
; @params:
;	p -> the string to be parsed
;	i -> current position in the string
; @returns:
;	the result of the parsed expression
factor:
        push    ebp
        mov     ebp, esp

        ;; ecx - string iterator || ebx - index || edx - helper
        mov ebx, [ebp + 12]
        mov ecx, [ebp + 8]

        ;; gets to index position in string
        mov edx, [ebx]
        add ecx, edx

        ;; checks if the character is a number
        mov edx, [ecx]
        cmp dl, '0'
        jge next_condition_for_number
not_a_number:
        cmp dl, '('
        je check_expression

        leave
        ret

check_expression:
        ;; ebx - index || ecx - string iterator || edx - helper
        mov ecx, [ebp + 8]
        mov edx, [ebp + 12]
        mov ebx, [edx]

        ;; gets over (
        inc ebx
        add ecx, ebx
        mov [edx], ebx

        push dword [ebp + 12]
        push dword [ebp + 8]
        call expression
        add esp, 8

        ;; ebx - index || ecx - string iterator || edx - helper
        mov ecx, [ebp + 8]
        mov edx, [ebp + 12]
        mov ebx, [edx]

        ;; gets over )
        inc ebx
        add ecx, ebx
        mov [edx], ebx

        leave
        ret

next_condition_for_number:
        cmp dl, '9'
        jle return_number
        jmp not_a_number

return_number:
        ;; result is stored in eax
        mov eax, [ebp + 8]
        mov ebx, [ebp + 12]

        ;; gets first digit of the number
        add eax, [ebx]
        xor edx, edx
        mov dl, byte [eax]
        sub edx, '0'

        xor eax, eax
        mov eax, edx

        ;; increase index
        mov ecx, [ebx]
        inc ecx
        mov [ebx], ecx

        jmp while_condition_number
while_content_number:
        imul eax, dword 10
        ;; ebx - index || ecx - string iterator || edx - helper
        mov ecx, [ebp + 8]
        mov edx, [ebp + 12]
        mov ebx, [edx]
        add ecx, ebx

        ;; gets the int value of the character
        xor edx, edx
        mov dl, byte [ecx]
        sub edx, '0'

        ;; adds it to the int number
        add eax, edx

        ;; increase index and get to the next character
        mov edx, [ebp + 12]
        mov ebx, [edx]
        inc ebx
        mov [edx], ebx

while_condition_number:
        ;; ebx - index || ecx - string iterator || edx - helper
        mov ecx, [ebp + 8]
        mov edx, [ebp + 12]
        mov ebx, [edx]
        add ecx, ebx

        mov edx, [ecx]
        cmp dl, '0'
        jge next_condition_while

return_while:        
        jmp not_a_number
        
next_condition_while:
        cmp dl, '9'
        jle while_content_number
        jmp return_while

; `term(char *p, int *i)`
;       Evaluates "factor" * "factor" or "factor" / "factor" expressions 
; @params:
;	p -> the string to be parsed
;	i -> current position in the string
; @returns:
;	the result of the parsed expression
term:
        push    ebp
        mov     ebp, esp

        ;; eax - stores result
        push dword [ebp + 12]
        push dword [ebp + 8]
        call factor
        add esp, 8
        push eax

        ;; ecx - string iterator
        mov ecx, [ebp + 8]
        jmp while_condition_term
while_content_term:
        ;; increase index
        mov edx, [ebp + 12]
        mov ebx, [edx]
        inc ebx
        mov [edx], ebx

        ;; saves ecx 
        push ecx
        mov edx, eax
        ;; eax - stores result || edx - old result
        push dword [ebp + 12]
        push dword [ebp + 8]
        call factor
        add esp, 8
        pop ecx

        ;; checks for '*' or '/'
        mov ebx, [ecx]
        cmp bl, '*'
        je found_mull
        jmp found_div

found_mull:
        mov edx, eax

        ;; calculates the multiplication
        pop eax
        imul edx
        push eax
       
        jmp while_condition_term

found_div:
        mov ebx, eax

        ;; calculates the division
        pop eax
        cdq
        idiv ebx
        push eax
    
        jmp while_condition_term

while_condition_term:
        ;; ebx - index || ecx - string iterator || edx - helper
        mov ecx, [ebp + 8]
        mov edx, [ebp + 12]
        mov ebx, [edx]
        add ecx, ebx

        mov edx, [ecx]
        cmp dl, '*'
        je while_content_term

        cmp dl, '/'
        je while_content_term

        pop eax
        
        leave
        ret

; `expression(char *p, int *i)`
;       Evaluates "term" + "term" or "term" - "term" expressions 
; @params:
;	p -> the string to be parsed
;	i -> current position in the string
; @returns:
;	the result of the parsed expression
expression:
        push    ebp
        mov     ebp, esp

        ;; eax - stores result
        push dword [ebp + 12]
        push dword [ebp + 8]
        call term
        add esp, 8

        ;; saves the sum on stack
        push eax

        ;; ecx - string iterator
        mov ecx, [ebp + 8]
        jmp while_condition_expression
while_content_expression:
        ;; increase index
        mov edx, [ebp + 12]
        mov ebx, [edx]
        inc ebx
        mov [edx], ebx

        push ecx
        mov edx, eax
        ;; eax - stores result || edx - old result
        push dword [ebp + 12]
        push dword [ebp + 8]
        call term
        add esp, 8
        pop ecx

        ;; checks for '+' or '-'
        mov ebx, [ecx]
        cmp bl, '+'
        je found_plus
        jmp found_minus

found_plus:
        pop edx
        add eax, edx
        push eax
    
        jmp while_condition_expression

found_minus:
        pop edx
        sub edx, eax
        push edx

        jmp while_condition_expression

while_condition_expression:
        ;; ebx - index || ecx - string iterator || edx - helper
        mov ecx, [ebp + 8]
        mov edx, [ebp + 12]
        mov ebx, [edx]
        add ecx, ebx

        mov edx, [ecx]
        cmp dl, '+'
        je while_content_expression

        cmp dl, '-'
        je while_content_expression

        ;; gets the sum from the stack
        pop eax
        
        leave
        ret
