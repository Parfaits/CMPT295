	.globl conv
conv:
	movb $0, %al
	movl $0, %ecx
	# movq $0, %r9
	# movq $0, %r10
	# movq $0, %r11
	# movl $8, %r8d
	# movl %edx, %r11d
	# decl %r11d					# n-1
	cmpl $0, %edx					# case: n=0
	je empty
while:
	cmpl %ecx, %edx
	je bypass
	# imull %ecx, %r8d
	movl %edx, %r8d					# ]
	subl %ecx, %r8d					# ] r8d= n-m-1
	decl %r8d						# ]
	leaq (%rdi, %rcx, 1), %r9 		# x[m]
	leaq (%rsi, %r8, 1), %r10		# h[n-m-1]
	# movb (%r9), %r9b				# dereferencing
	# movb (%r10), %r10b
	movb (%r9), %r9b
	imulq (%r10), %r9
	# pushq %r10
	addb %r9b, %al					# reseult += r9
	incl %ecx
	jmp while
empty:
	movb $0, %al
	ret
# dot:
# 	movq (%rdi), %rax
# 	imulq (%rsi), %rax
# 	pushq %rbx
# 	movq $8(%rdi), %rbx
# 	imulq $8(%rsi), %rbx
# 	addq %rbx, rax
# 	popq %rbx
# 	ret
# sum_prep:
# 	# popq %rax
# 	decl %ecx
# 	jmp sum
# sum:
# 	cmpl $0, %ecx
# 	je bypass
# 	popq %r11
# 	add %r11b, %al
# 	decl %ecx
# 	jmp sum
bypass:
	ret