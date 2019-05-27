	.globl times
times:
	#mov %edi, %eax      #  remove these two lines before
	#imull %esi, %eax    #  you start writing your code
# 	movq %rdi, %rdx      #rdx a
# 	movq %rsi, %rcx		#rcx b
# 	movq $10, %r8
# 	movq $10, %r9
# 	movq $0, %r10
# base10_cmp:
# 	cmpq %r8, %rdx
# 	jle base10_cmp2
# 	mulq %r8, $10
# 	jmp base10_cmp
# base10_cmp2:
# 	cmpq %r9, %rcx
# 	jle found_both_base10
# 	mulq %r9, $10
# 	jmp base10_cmp2
# found_both_base10:
# 	cmpq %r8, %r9
# 	jl 
# 	divq %r9, $10
# 	movq %r9, %r10
# r8_isgreater:
# 	divq %r8, $10
# 	movq %r8, %r10

# 	movq %rdx, %rax

	ret

