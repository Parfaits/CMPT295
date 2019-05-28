	.file	"oof.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Original signal:  "
.LC1:
	.string	"%4d"
.LC2:
	.string	"Convolved signal: "
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$.LC0, %edi
	call	puts
	movsbl	signal(%rip), %edx
	movl	$.LC1, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movsbl	signal+1(%rip), %edx
	movl	$.LC1, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	call	_IO_putc
	movl	$.LC2, %edi
	call	puts
	movl	$2, %edx
	movl	$h, %esi
	movl	$signal, %edi
	call	conv
	movl	$.LC1, %esi
	movsbl	%al, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	call	_IO_putc
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	h
	.data
	.type	h, @object
	.size	h, 2
h:
	.byte	1
	.byte	1
	.globl	signal
	.type	signal, @object
	.size	signal, 2
signal:
	.byte	1
	.byte	1
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
