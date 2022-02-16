%include "io.inc"

section .data
   word_num1 dd 0xff543210
   word_num2 dd 0x00111111
   result_word resd 2
   big_num1 dd 0x11111111, 0x22222222, 0x33333333
   big_num2 dd 0xffffffff, 0x22222222, 0x33333333
   result_4word resd 4
   num_array1 dd 0x11111111, 0x22222222, 0x33333333, 0x12111211, 0x22232242, 0xff333333, 0xff123456, 0xff123456, 0xff123456
   num_array2 dd 0xffffffff, 0x22922252, 0x33033338, 0x12111211, 0x22232242, 0xff333333, 0xff123456, 0xff123456, 0xff123456
   result_array resd 12
   length dd 3
   byte_length dd 0

section .text

;; python -c 'print "A" * 41 + "\xa6\x84\x04\x08" + "\xe5\x84\x04\x08"' | ./attack

carry_test:
    xor eax, eax
    mov al, 0xff
    add al, 11
    jc overboard
    jmp end
overboard:
    NEWLINE
    PRINT_STRING "carry "
    PRINT_HEX 2, ax
end:
    ret

global main
main:
    push ebp
    mov ebp, esp

    ;TODO a, b, c: Implement the array sum starting with double word sum incrementally solving subsequent task b and c.
    ;a
    mov eax, [word_num1]
    add eax, [word_num2]
    mov dword[result_word], eax
    PRINT_STRING "4oct res "
    PRINT_HEX 4, eax ;ok
    NEWLINE
    
    ;b. presupunem lsb first
    xor ecx, ecx
new:
    mov eax, [big_num1+ecx*4]
    add eax, [big_num2+ecx*4]
    jc carry
    add dword[result_4word+ecx*4], eax
    jmp next
carry:
    add dword[result_4word+ecx*4], eax
    add dword[result_4word+ecx*4+4], 1
next:
    inc ecx
    cmp ecx, 2
    jle new

    PRINT_STRING "4 res: "
    mov ecx, 3
    cmp dword[result_4word+ecx*4], 0
    jne print
    dec ecx
print:
    PRINT_HEX 4, [result_4word+ecx*4]
    dec ecx
    cmp ecx, 0
    jge print
    NEWLINE
    
    ;c
    mov eax, [length]
    dec eax
    mov ebx, 16
    mul ebx
    mov dword[byte_length], eax
    
    xor edx, edx
    xor ebx, ebx
for:
    xor ecx, ecx
new1:
    mov eax, [num_array1+ebx+ecx*4]
    add eax, [num_array2+ebx+ecx*4]
    jc carry1
    add dword[result_array+edx+ecx*4], eax
    jmp next1
carry1:
    add dword[result_array+edx+ecx*4], eax
    add dword[result_array+edx+ecx*4+4], 1
next1:
    inc ecx
    cmp ecx, 2
    jle new1

    PRINT_STRING "vec res: "
    mov ecx, 3
    cmp dword[result_array+edx+ecx*4], 0
    jne print1
    dec ecx
print1:
    PRINT_HEX 4, [result_array+edx+ecx*4]
    dec ecx
    cmp ecx, 0
    jge print1
    NEWLINE
    
    add ebx, 12
    add edx, 16
    cmp edx, [byte_length]
    jle for
    
   
    leave
    ret

