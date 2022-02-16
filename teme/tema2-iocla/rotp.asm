section .text
    global rotp
    extern printf

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implement rotp
    ;; FREESTYLE STARTS HERE

    xor ebx, ebx
    mov ebx, ecx
;; makes xor on every character from the plaintext starting from the right
;; and the character from the key text starting from the left
apply_rotp:
    xor eax, eax

    ;; eax is the register used to get the plaintext character
    mov al, byte [esi + ecx - 1]
    sub ebx, ecx

    ;; now making xor with the key character
    xor al, byte [edi + ebx]
    add ebx, ecx

    ;; moves the new character to the ciphertext
    mov [edx + ecx - 1], al

    loop apply_rotp

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY