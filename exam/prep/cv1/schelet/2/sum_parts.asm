extern scanf
extern printf


section .data
    uint_format    db "%zu", 0
    uint_format_newline    db "%zu", 10, 0
    pos1_str    db "Introduceti prima pozitie: ", 0
    pos2_str   db "Introduceti a doua pozitie: ", 0
    sum_str db "Suma este: %zu", 10, 0
    sum_interval_str db "Suma de la pozitia %zu la pozitia %zu este %zu", 10, 0
    arr     dd 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400


section .text
global main


sum:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum() to compute sum for array.
    mov ebx, dword[ebp + 8]
    mov ecx, dword[ebp + 12]
    ; mov ebx, arr
    ; mov ecx, 14

    mov eax, 0              ; accumulator for the sum (32 bits are enough for the sum)

    loop_vector:
        add eax, dword[ebx + (ecx - 1) * 4]
        loop loop_vector

    leave
    ret


sum_interval:
    push ebp
    mov ebp, esp

    ; TODO b: Implement sum_interval() to compute sum for array between two positions.
    mov eax, dword[ebp + 8]             ; start of the array
    mov ebx, dword[ebp + 12]            ; pos1
    mov ecx, dword[ebp + 16]            ; pos2 ([pos1, pos2))

    xor edx, edx                        ; sum
    
start_to_end:
    dec ecx

    add edx, dword[eax + ecx * 4]

    cmp ecx, ebx
    jne start_to_end

    mov eax, edx

    leave
    ret


main:
    push ebp
    mov ebp, esp


    push dword 14
    push arr
    call sum
    add esp, 8

    push eax
    push sum_str
    call printf
    add esp, 8


    ; TODO b: Call sum_interval() and print result.    
    push 5
    push 3
    push arr
    call sum_interval

    add esp, 12

    push eax
    push 5
    push 3
    push sum_interval_str
    call printf
    add esp, 16


    ; TODO c: Use scanf() to read positions from standard input.
    push pos1_str
    call printf
    add esp, 4



    push eax                ; push eax on the stack (it will be modified through esp)

    push esp
    push uint_format
    call scanf
    add esp, 8

    pop eax                 ; get the eax updated after scan call
    mov ecx, eax

    push eax
    push ecx

    push pos2_str
    call printf
    add esp, 4
    

    push eax
    push esp
    push uint_format
    call scanf
    add esp, 8
    pop eax
    mov edx, eax            ; this can be replaced by (pop edx) directly

    pop ecx
    pop eax


    push ecx                ; take care of this used registers
    push edx

    push edx
    push ecx
    push arr
    call sum_interval
    add esp, 12

    pop edx                 ; saaaame
    pop ecx

    push eax
    push edx
    push ecx
    push sum_interval_str
    call printf
    add esp, 16


    ; Return 0.
    xor eax, eax
    leave
    ret
