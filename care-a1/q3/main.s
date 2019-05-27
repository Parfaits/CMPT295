	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"The return value was:  %d.\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	str(%rip), %rdi
	xorl	%esi, %esi
	call	mystery
	movl	$.LC0, %esi
	movl	%eax, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	__printf_chk
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	str
	.section	.rodata.str1.1
.LC1:
	.string	"Good mood food."
	.data
	.align 8
	.type	str, @object
	.size	str, 8
str:
	.quad	.LC1
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
