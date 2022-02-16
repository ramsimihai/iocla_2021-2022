%include "utils/printf32.asm"

extern printf

section .data
    num dd 55555123
;;  TODO d: declare byte_array so that PRINT_HEX shows babadac 
byte_array db 0  
	
section .text
global main

; TODO b: implement array_reverse
array_reverse:

; TODO c: implement pow_arraypowArray
pow_array:

main:
    push ebp
    mov ebp, esp

    ;TODO a: allocate on array of 20 byte elements and initializate it incrementally starting from 'A'

    ;TODO b: call array_reverse and print reversed array

    ;TODO c: call pow_array and print the result array

	;;  TODO d: this print of an uint32_t should print babadac 
	PRINTF32 `%x\n\x0`, byte_array 

    xor eax, eax
    leave
    ret
