%include "io.inc"

section .data
    ; TODO a: Define arr1, arr2 and res arrays.
arr1 dd 1,2,3,4,5,6,7,8,9,10
arr2 dd 10,9,8,7,6,5,4,3,2,1
num dd 10

section .bss
    res resd 10

section .text
%macro disp 2
    mov eax, %1
    PRINT_STRING %2
    call disp_func
%endmacro

disp_func:
    xor ecx, ecx
print:
    PRINT_UDEC 4, [eax+ecx*4]
    PRINT_CHAR ' ' 
    inc ecx
    cmp ecx, [num]
    jl print
    NEWLINE
    ret
    
global main

main:
    push ebp
    mov ebp, esp


    ; TODO b: Compute res[0] and res[n-1].
    xor ecx, ecx
    mov eax, [num]
    dec eax
    shl eax, 2
for:
    mov edx, dword[arr1+ecx*4]
    mov dword[res+ecx*4], edx ; bytes
    neg ecx
    mov edx, dword[arr1+eax+ecx*4]
    neg ecx
    add dword[res+ecx*4], edx;
    inc ecx
    cmp ecx, [num]
    jl for

    ; List first and last item in each array.
    PRINT_UDEC 4, [arr1]
    NEWLINE
    PRINT_UDEC 4, [arr2]
    NEWLINE
    PRINT_UDEC 4, [res]
    NEWLINE

    PRINT_UDEC 4, [arr1+36]
    NEWLINE
    PRINT_UDEC 4, [arr2+36]
    NEWLINE
    PRINT_UDEC 4, [res+36]
    NEWLINE


    ; TODO d: Compute cross sums in res[i].
    


    ; TODO c: List arrays.
    disp arr1, "arr1: "
    disp arr2, "arr2: "
    disp res, "res: "

    ; Return 0.    
    xor eax, eax
    leave
    ret