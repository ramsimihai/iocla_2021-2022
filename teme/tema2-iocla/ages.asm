; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .data
    vect_counter dd 0
    age dd 0
    length dd 0

section .text
    global ages
    extern printf

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    ;; saves the length of the friends & and initialize the vect_counter
    mov dword [length], edx
    mov dword [vect_counter], 0


    xor edx, edx
;; adds to the vector of friends ages
add_to_vector:
    xor eax, eax
    xor ebx, ebx

    ;; eax - actual year || ebx - birth year
    mov eax, [esi + my_date.year]

    mov edx, dword [vect_counter]
    mov ebx, [edi + edx * my_date_size + my_date.year]

    ;; checks if the difference the person wasnt born yet
    cmp eax, ebx
    jle get_no_year

    ;; calculates the supposed age and then sub cause of corner case
    sub eax, ebx
    mov dword [age], eax

    xor eax, eax
    xor ebx, ebx

    ;; ax - present month || bx - birth month
    mov ax, [esi + my_date.month]

    mov edx, dword [vect_counter] 
    mov bx, [edi + edx * my_date_size + my_date.month]

    ;; gets the difference between months
    sub bx, ax
    xor eax, eax
    mov eax, dword [age]

    cmp bx, 0

    jg birthday_didnt_happend
    jl return_date

    xor eax, eax
    ;; ax - present day || bx - birth day
    mov ax, [esi + my_date.day]

    mov edx, dword [vect_counter] 
    mov bx, [edi + edx * my_date_size + my_date.day]

    
    cmp ax, bx
    jl birthday_didnt_happend

    xor eax, eax
    xor edx, edx

    ;; puts the age and the counter into registers
    mov eax, dword [age]
    mov edx, dword [vect_counter]

;; just put in the vector at the specified position the age
return_date:
    ;; adds to the vector of ages eax which is the age in every case
    mov dword [ecx + 4 * edx], eax
    
    inc dword [vect_counter]

    ;; reinitialize the vector length and counter and 
    mov eax, dword [vect_counter]
    mov edx, dword [length]
    
    cmp eax, edx
    jl add_to_vector

    jmp final

;; decrease the age because the birthday party didnt happen
;; in that year yet
birthday_didnt_happend:
    xor eax, eax
    mov eax, dword [age]
    dec eax

    xor edx, edx
    mov edx, dword [vect_counter]

    jmp return_date

;; the person isnt born yet
get_no_year:
    xor edx, edx
    mov edx, dword [vect_counter]
    xor eax, eax

    jmp return_date

final:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
