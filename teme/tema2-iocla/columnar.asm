section .data
    extern len_cheie, len_haystack
    counter dd 0

section .text
    global columnar_transposition
    extern printf

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor ecx, ecx
    mov dword [counter], 0
;; iterates through every column from the haystack and adds to the cipher text
;; all the characters in the specified order from the keys array
iterate_through_columns:
    ;; the eax register is used to get the order from the key array
    mov eax, [counter]
    mov eax, [edi + 4 * eax]

    ;; get on the first line of the haystack on the first character
    ;; that is going to be added in the haystack
    mov esi, [ebp + 12]
    add esi, eax

    ;; position counter to see if there is a character or not on the
    ;; last line of the haystack
    mov ecx, eax

    xor edx, edx

;; iterates through every line of the haystack and adds the character
;; coresponding to the haystack column 
iterate_through_lines:
    ;; 
    xor eax, eax
    mov al, [esi]

    mov [ebx + edx], al

    add esi, [len_cheie]
    ;; increments position in cipher
    inc edx

    ;; checks if the column of the haystack has ended
    add ecx, [len_cheie]
    cmp ecx, [len_haystack]
    jl iterate_through_lines

    ;; get on the next position after adding a column in cipher text
    add ebx, edx

    inc dword [counter]

    ;; compare if the column ended and gets to the new column
    xor edx, edx
    mov edx, [counter]
    cmp edx, [len_cheie]
    jl iterate_through_columns

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY