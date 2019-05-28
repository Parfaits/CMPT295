	.globl sum_float

	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer)
	#   %rsi:   n
	#   %rbp:   endptr

sum_float:
	push	%rbp				# } create the stack frame
	movq %rsp, %rbp				# }

	movq $0x7F800000, (%rbp)	# 0x7F800000 = +inf. Case: head of empty Q is +inf
	xorps	%xmm0, %xmm0            # total <- 0.0
	leaq (%rdi, %rsi, 4), %rdx	# rdx <- tail of F
	xorps %xmm1, %xmm1
	xorps %xmm2, %xmm2
	xorps %xmm3, %xmm3
	xorq %r8, %r8
	xorq %r9, %r9

	movq $0x7F800000, %r9		# r9 <- +inf
	movss (%rdi), %xmm3			# xmm3 <- copy of F[] at the current address
	movq %rbp, %r8				# r8 <- top of stack frame while rbp will be the head of Q
	movl $1, %ecx				# i = 1
loop:
	cmpl	%ecx, %esi             
	jle	endloop                 # while i from 1 to n-1 {
	# cmpq %rdi, %rdx
	# jle endloop

	movss %xmm3, %xmm1
	minss (%rbp), %xmm1			# (x) xmm1 <- min(head(F), head(Q))
	ucomiss %xmm3, %xmm1		
	je deque_F					# if F has the min dequeue F else dequeue Q
	leaq -4(%rbp), %rbp
	cmpq %rbp, %rsp
	jne get_y					# case: rbp=rsp (head=tail) Q is empty; then head(Q) <- +inf
	movq $0x7F800000, (%rbp)
	jmp get_y
deque_F:
	add	$4, %rdi
	movss (%rdi), %xmm3 		# update 
	cmpq %rdi, %rdx
	jne get_y					# case: rdi=rdx (head=tail) F is empty; then head(F) <- +inf
	movq %r9, %xmm3
get_y:
	movss %xmm3, %xmm2
	minss (%rbp), %xmm2			# (y) xmm2 <- min(head(F), head(Q))
	ucomiss %xmm3, %xmm2
	je deque_F2					# if F has the min dequeue F else dequeue Q
	leaq -4(%rbp), %rbp
	cmpq %rbp, %rsp
	jne sum_it					# case: rbp=rsp (head=tail) Q is empty; then head(Q) <- +inf
	movq $0x7F800000, (%rbp)
	jmp sum_it
deque_F2:
	add	$4, %rdi				
	movss (%rdi), %xmm3			# update
	cmpq %rdi, %rdx
	jne sum_it					# case: rdi=rdx (head=tail) F is empty; then head(F) <- +inf
	movq %r9, %xmm3
sum_it:
	addss %xmm2, %xmm1			# x+y
	movss %xmm1, (%rsp)			# enqueue(x+y) -> Q
	leaq -4(%rsp), %rsp			# tail(Q)->next

	incl %ecx					# i++
	jmp	loop                    # }

endloop:
	movss (%rbp), %xmm0			# return head(Q)
	movq %r8, %rsp				# cleanup{
	pop	%rbp					# }
	ret

# sum_float:
# 	push	%rbp

# 	xorps	%xmm0, %xmm0            # total <- 0.0
# 	leaq	(%rdi, %rsi, 4), %rbp   # endptr <- F + n

# loop:
# 	cmpq	%rdi, %rbp             
# 	jle	endloop                 # while (F < endptr) {
# 	addss	(%rdi), %xmm0           #    total += F[0]
# 	add	$4, %rdi                #    F++
# 	jmp	loop                    # }

# endloop:
# 	pop	%rbp
# 	ret

