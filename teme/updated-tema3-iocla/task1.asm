section .text
	global sort

struc node
   .val:    resd 1
   .next:    resd 1
endstruc
; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0

	;; ebx - iterator
	;; eax - minimum value address
	mov eax, [ebp + 12]
	mov ebx, [ebp + 12]
	xor ecx, ecx
    jmp get_head_node
return_head_node:
    push eax

    xor ecx, ecx
    push ecx
iterate_through_nodes:
    cmp ecx, 0
    je add_old_minimum

ret_old_min:
    ;; ebx - iterator
	;; eax - minimum value address
	mov eax, [ebp + 12]
	mov ebx, [ebp + 12]

    xor ecx, ecx
;; gets the lowest minimum value of the list from the next positions
get_minimum_node:
    push ecx
normal_mode:
    ;; second for iterator
    pop ecx
    ;; old minimum
    pop edx

    ;; we dont need the iterator yet
    push ecx

    ;; compares the value and the old minimum
    mov ecx, [edx]
    cmp [ebx], ecx
    jg swap_min

ret_last_swap:
    ;; readds the old minimum in stack
    pop ecx
    push edx

    ;; iterate next element
    add ebx, node_size

    ;; gets counter for get_minimum_node
    inc ecx

    mov edx, [ebp + 8]
    cmp ecx, edx
    jl get_minimum_node

    ;; adds the new minimum to the old minimum
    pop edx
    add edx, node.next

    mov [edx], eax
    ;; gets the iterator
    pop ecx
    inc ecx

    ;; push the iterator, then the old_minimum
    push ecx
    push eax

    ;; check for loop
    mov ebx, [ebp + 8]
    dec ebx
    cmp ecx, ebx
    jl iterate_through_nodes

    ;; retrieves the head of the list
    pop ecx
    pop ecx
    pop eax

	leave
	ret

swap_min:
    ;; checks if the value is really the minimum
    mov ecx, [edx]
    cmp [eax], ecx
    jle continue_swap

    mov ecx, [ebx]
    cmp [eax], ecx
    jge continue_swap

    jmp ret_last_swap

continue_swap:
    ;; actually swap the minimum with the node iterator
    xor eax, eax
    mov eax, ebx
    jmp ret_last_swap

;; adds the head of the list as the old minimum on stack
add_old_minimum:
    push eax
    jmp ret_old_min

;; gets the first minimum value of the list and adds it to the stack
;; as a "head" node
get_head_node:
	push ecx

    ;; compare elements with minimum value
	mov edx, [ebx]
	cmp [eax], edx
	jg swap_min_first_iter
ret_swap:
    add ebx, node_size
    ;; gets iterator & increments it
	pop ecx
	inc ecx

	;; checks for loop
	mov edx, [ebp + 8]
	cmp ecx, edx
	jl get_head_node

    jmp return_head_node
swap_min_first_iter:
	xor eax, eax
	mov eax, ebx

	jmp ret_swap
