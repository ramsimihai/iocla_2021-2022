;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS
section .data
    offset dd 0
    counter dd 0

section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    mov dword [counter], 0 ; initialize counter for tests

    ;; get offset of address
    xor eax, eax
    and edx, 7
    mov dword [offset], edx

    ;; get tag of address
    xor edx, edx
    mov edx, [ebp + 20]
    shr edx, OFFSET_BITS

;; get to the tags line and add the tag to the right place
iterate_through_tags:
    ;; checks if the tag is found in the array
    ;; edx - the tag || ebx - tag vector
    cmp [ebx], edx
    je cache_hit
    add ebx, 4


    inc dword [counter]
    cmp dword [counter], CACHE_LINES
    jl iterate_through_tags

cache_miss:
    ;; restarts the counter to be to_replace
    mov edi, [ebp + 24]
    mov dword [counter], edi
    
    ;; gets to_replace index in tag array
    xor ecx, ecx
    mov ecx, dword [counter]
    imul ecx, 4
    mov ebx, [ebp + 12]
    add ebx, ecx
    
    ;; adds the tag in array
    mov [ebx], edx

    xor ecx, ecx
; add to cache 2d array every byte
add_bytes_in_cache:
    ;; gets to line index on cache array
    ;; eax - cache || ebx - helper register
    xor ebx, ebx
    xor eax, eax
    
    mov ebx, edi
    imul ebx, CACHE_LINE_SIZE

    mov eax, [ebp + 16]
    add eax, ebx
    add eax, ecx

    ;; regets the over-all address needed for adding on every cache column
    mov edx, [ebp + 20]
    shr edx, 3
    shl edx, 3

    ;; adds to array the byte corresponding to the index
    add edx, ecx
    mov bl, [edx]
    mov [eax], bl
    
    inc ecx
    cmp ecx, CACHE_LINE_SIZE
    jl add_bytes_in_cache

;; add the value of the corresponding index from the cache
;; to te reg pointer
 cache_hit:
    ;; counter has the line index of where to look in cache
    ;; ecx is the cache starting point
    xor ecx, ecx
    mov ecx, [ebp + 16]

    ;; gets to the address in the cache
    ;; eax is a helper register for moving to the wanted address
    xor eax, eax
    mov eax, CACHE_LINE_SIZE
    imul eax, dword [counter]
    add ecx, eax
    add ecx, [offset]
    

    ;; adds the value from the cache into reg
    xor ebx, ebx
    mov ebx, [ebp + 8]
    mov eax, [ecx]
    mov [ebx], eax


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


