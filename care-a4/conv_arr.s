	.globl conv_arr
conv_arr:
	# di = char *x, si = int n, dx = char *h, cx = int m, r8 = char *result
	xorq %rax, %rax
	xorq %r9, %r9
	xorq %r10, %r10
	xorq %r11, %r11
	pushq %rbx
	pushq %r12
	xorq %rbx, %rbx
	xorq %r12, %r12

	movl %esi, %r9d
	addl %ecx, %r9d
	decl %r9d
	decl %r9d				# n+m-2
loop:
	cmpl %r10d, %r9d		# i = 0 to n+m-2
	jl	end

	incl %r10d				# i+1
	pushq %rdi
	pushq %rsi				# x, n on stack
	movl %r10d, %edi		
	movl %ecx, %esi			
	call min 				# min(i+1, m)
							
	movl %eax, %r11d		# (ladj)	r11d now has result of min(i+1, m)
	popq %rdi				# n in di, x still on stack
	pushq %rdi				# n back on stack but the copy is still there in rdi
	addl %ecx, %edi			# n+m
	subl %r10d, %edi		# n+m-(i+1)
	movl %ecx, %esi
	call min				# min(m+n-(i+1), m)

	movl %ecx, %ebx
	subl %eax, %ebx			# (radj) m - min(m+n-(i+1), m) -> ebx
	popq %rsi
	popq %rdi
	pushq %rdi
	pushq %rsi
	pushq %rdx
	pushq %rcx
	movl %r10d, %r12d
	subl %r11d, %r12d		# i+1-ladj -> r12d
	addq %r12, %rdi			# x +  i+1-ladj -> first param
	movq %rbx, %rsi
	addq %rdx, %rsi			# h + radj -> 2nd param
	movl %r11d, %edx
	subl %ebx, %edx			# ladj-radj -> 3rd param
	call conv

	popq %rcx
	popq %rdx
	popq %rsi
	popq %rdi
	decl %r10d
	movb %al, (%r8, %r10) 	# result[i] <- conv(x + (i+1-ladj), h + radj, ladj-radj)
	incl %r10d
	jmp loop
end:
	popq %r12
	popq %rbx
	ret
