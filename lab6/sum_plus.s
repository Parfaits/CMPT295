	.globl sum_plus
sum_plus:
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	testl	%esi, %esi
	jle	done
	xorl	%edx, %edx
	shl     $2, %rsi
loop:
	movl	(%rdi,%rdx), %ecx
	testl	%ecx, %ecx
	cmovle %r8d, %ecx
	addl	%ecx, %eax
endif:
	addq	$4, %rdx
	cmpq	%rsi, %rdx
	jne	loop
done:
	ret
