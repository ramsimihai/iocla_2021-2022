	.file	"overflow_in_binary.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"Great success!"
	.text
	.type	success, @function
success:
.LFB6:
	.cfi_startproc
	endbr32
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	ebx
	sub	esp, 4
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	sub	esp, 12
	lea	edx, .LC0@GOTOFF[eax]
	push	edx
	mov	ebx, eax
	call	puts@PLT
	add	esp, 16
	nop
	mov	ebx, DWORD PTR -4[ebp]
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	success, .-success
	.section	.rodata
.LC1:
	.string	"Epic failure!"
	.text
	.type	fail, @function
fail:
.LFB7:
	.cfi_startproc
	endbr32
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	ebx
	sub	esp, 4
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	sub	esp, 12
	lea	edx, .LC1@GOTOFF[eax]
	push	edx
	mov	ebx, eax
	call	puts@PLT
	add	esp, 16
	nop
	mov	ebx, DWORD PTR -4[ebp]
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	fail, .-fail
	.type	check_string, @function
check_string:
.LFB8:
	.cfi_startproc
	endbr32
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	push	ebx
	sub	esp, 52
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	DWORD PTR -12[ebp], 305419896
	sub	esp, 8
	push	DWORD PTR 8[ebp]
	lea	edx, -44[ebp]
	push	edx
	mov	ebx, eax
	call	strcpy@PLT
	add	esp, 16
	mov	eax, DWORD PTR 8[ebp]
	movzx	eax, BYTE PTR 1[eax]
	mov	BYTE PTR -29[ebp], al
	cmp	DWORD PTR -12[ebp], 1311789648
	jne	.L4
	call	success
	jmp	.L6
.L4:
	call	fail
.L6:
	nop
	mov	ebx, DWORD PTR -4[ebp]
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	check_string, .-check_string
	.section	.rodata
.LC2:
	.string	"Usage: %s <string>\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	endbr32
	lea	ecx, 4[esp]
	.cfi_def_cfa 1, 0
	and	esp, -16
	push	DWORD PTR -4[ecx]
	push	ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	mov	ebp, esp
	push	ebx
	push	ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	call	__x86.get_pc_thunk.bx
	add	ebx, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	eax, ecx
	cmp	DWORD PTR [eax], 2
	je	.L8
	mov	eax, DWORD PTR 4[eax]
	mov	edx, DWORD PTR [eax]
	mov	eax, DWORD PTR stderr@GOT[ebx]
	mov	eax, DWORD PTR [eax]
	sub	esp, 4
	push	edx
	lea	edx, .LC2@GOTOFF[ebx]
	push	edx
	push	eax
	call	fprintf@PLT
	add	esp, 16
	sub	esp, 12
	push	1
	call	exit@PLT
.L8:
	mov	eax, DWORD PTR 4[eax]
	add	eax, 4
	mov	eax, DWORD PTR [eax]
	sub	esp, 12
	push	eax
	call	check_string
	add	esp, 16
	mov	eax, 0
	lea	esp, -8[ebp]
	pop	ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	pop	ebx
	.cfi_restore 3
	pop	ebp
	.cfi_restore 5
	lea	esp, -4[ecx]
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB10:
	.cfi_startproc
	mov	eax, DWORD PTR [esp]
	ret
	.cfi_endproc
.LFE10:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB11:
	.cfi_startproc
	mov	ebx, DWORD PTR [esp]
	ret
	.cfi_endproc
.LFE11:
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 4
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 4
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 4
4:
