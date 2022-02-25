global get_words
global compare_func
global sort

section .text
    extern qsort
    extern strlen
    extern strcmp

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0
    
    mov ecx, [ebp + 16]
    mov ebx, [ebp + 12]
    mov eax, [ebp + 8]
    
    push compare_strings
    push ecx
    push ebx
    push eax
    call qsort
    add esp, 16

    leave
    ret

;; compare_strings(char **a, char **b)
; compares two strings by their length, then lexicografix
compare_strings:
    enter 0, 0

    ;; saves the old values from the registers
    push ebx
    push ecx
    push edx

    ;; calculates string a length
    mov eax, [ebp + 8]
    push dword [eax]
    call strlen

    add esp, 4

    ;; eax length of string a
    push eax
    ;; calculates string b length
    mov ebx, [ebp + 12]
    push dword [ebx]
    call strlen

    add esp, 4

    ;; ebx length of string b
    mov ebx, eax
    pop eax
;; first compare length of the two strings
compare_lengths:
    cmp eax, ebx
    jl return_string_a
    cmp eax, ebx
    jg return_string_b

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    push dword [ebx]
    push dword [eax]
    call strcmp
    add esp, 8

    pop edx
    pop ecx
    pop ebx

    leave
    ret

return_string_a:
    mov eax, -1

    pop edx
    pop ecx
    pop ebx

    leave
    ret

return_string_b:
    mov eax, 1

    pop edx
    pop ecx
    pop ebx

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0

    xor ecx, ecx
    mov eax, [ebp + 8]
    jmp delete_delimiter
first:
    ;; iterator for words
    xor ecx, ecx
    push ecx

    ;; iterator for the given string
    mov eax, [ebp + 8]
iterate_through_words:
    ;; iterator for characters per word
    xor ecx, ecx
    push ecx
    
iterate_through_characters:
    ;; gets character's iterator
    pop ecx
    ;; gets no words' iterator
    pop ebx

    ;; checks if character is '\0'
    mov dl, [eax]
    cmp dl, 0
    je before_end_word

    ;; checks if the characters' iterator is 0,
    ;; so the word will be added
    cmp ecx, 0
    je add_word

return_word:
    inc ecx
    inc eax

    push ebx
    push ecx
    jmp iterate_through_characters

end_word:
    ;; gets words iterator
    pop ecx
    inc ecx
    ;; readds the words iterator so it wouldnt be lost at the next iteration
    push ecx

    mov edx, [ebp + 16]
    cmp ecx, edx
    jl iterate_through_words

    leave
    ret

add_word:
    push ecx
    mov ecx, ebx

    ;; ebx - words array iterator | edx - counter
    mov ebx, [ebp + 12]
    xor edx, edx
;; gets to the position where should the characters be added
position_loop:
    ;; first position in words array
    cmp ecx, 0
    je add_on_first_position
    
    add ebx, 4
    inc edx

    cmp edx, ecx
    jl position_loop

add_on_first_position:
    ;; adds a character
    mov [ebx], eax
    
    mov ebx, ecx
    pop ecx
    jmp return_word

before_end_word:
    ;; gets to the next char
    add eax, 1

    mov dl, [eax]
    cmp dl, 0
    je before_end_word
    ;; readds no words' iterator
    push ebx
    jmp end_word

delete_delimiter:
    mov dl, [eax]
    cmp dl, ` `
    je delete_char

    cmp dl, `,`
    je delete_char

    cmp dl, `.`
    je delete_char

    cmp dl, `\n`
    je delete_char

return_after_char_del:
    ;; checks if the string is terminated
    mov dl, [eax]
    cmp dl, 0

    ;; gets back to the program
    je first

    ;; gets to next character
    inc eax
    jmp delete_delimiter
delete_char:
    mov byte [eax], 0
    inc eax
    jmp delete_delimiter
