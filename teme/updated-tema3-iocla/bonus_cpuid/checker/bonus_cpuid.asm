%include "../../io.mac"
section .text
	extern printf
	global cpu_manufact_id
	global features
	global l2_cache_info

;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter 	0, 0
	pushad

	mov eax, 0
	cpuid

	mov eax, [ebp + 8]
	mov [eax], ebx
	mov [eax + 4], edx
	mov [eax + 8], ecx

	popad
	leave
	ret

;; void features(char *vmx, char *rdrand, char *avx)
;
;  checks whether vmx, rdrand and avx are supported by the cpu
;  if a feature is supported, 1 is written in the corresponding variable
;  0 is written otherwise
features:
	enter 	0, 0
	pushad

	;; guess that every option is by default 0
	mov edx, [ebp + 8]
	mov dword [edx], 0
	mov edx, [ebp + 12]
	mov dword [edx], 0
	mov edx, [ebp + 16]
	mov dword [edx], 0

	mov eax, 1
	cpuid
	mov edx, ecx

	;; checks the bit for vmx
	mov ebx, 1
	shl ebx, 5
	and ebx, edx
	shr ebx, 5

	cmp ebx, 1
	je found_vmx

;; checks the bit for avx
check_avx:
	mov edx, ecx
	mov ebx, 1
	shl ebx, 28
	and ebx, edx
	shr ebx, 28

	cmp ebx, 1
	je found_avx

;; checks the bit for rdrand
check_rdrand:
	mov edx, ecx

	mov ebx, 1
	shl ebx, 30
	and ebx, edx
	shr ebx, 30

	cmp ebx, 1

	je found_rdrand

final:
	popad
	leave
	ret

found_vmx:
	mov edx, [ebp + 8]
	mov dword [edx], 1
	jmp check_avx

found_avx:
	mov edx, [ebp + 16]
	mov dword [edx], 1
	jmp check_rdrand
found_rdrand:
	mov edx, [ebp + 12]
	mov dword [edx], 1
	jmp final
;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 	0, 0
	pushad

	mov eax, 80000006h
	cpuid
	
	;; l2 cache infos are stored in ecx after cpuid
	mov edx, ecx
	and edx, 0xff

	;; gets the line size 
	mov ebx, [ebp + 8]
	mov dword [ebx], edx 

	mov edx, ecx
	shr edx, 16
	and edx, 0xffff

	;; gets the cache size
	mov ebx, [ebp + 12]
	mov dword [ebx], edx 

	popad
	leave
	ret
