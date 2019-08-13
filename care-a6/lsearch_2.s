	# var map:
	#    %rdi - int *A
	#    %esi - int n
	#    %edx - int target
	#    %ecx - int i
	#    %eax - int val
	#    %r8d - int m
	#	 %r9d - int tmp
	.globl	lsearch_2
lsearch_2:
	testl	%esi, %esi
	jle	empty_array						# if (n <= 0) return -1;
	movslq	%esi, %rax					# val = n;
	leaq	-4(%rdi,%rax,4), %rax		# val = A + n - 1;
	movl	(%rax), %r9d				# tmp = *val;
	movl	%edx, (%rax)				# *val = target;
	cmpl	(%rdi), %edx				# if (val[i] != target) { 
	je	skip_while						# 
	movl	$1, %ecx					# i = 1
do_while:								# do {
	movl	%ecx, %r8d					# m = i;
	addq	$1, %rcx					# i++; }
	cmpl	%edx, -4(%rdi,%rcx,4)		# while (A[i] != target);}
	jne	do_while
if:
	movl	%r9d, (%rax)				# *val = tmp;
	leal	-1(%rsi), %eax				# val = n-1;
	cmpl	%r8d, %eax					# if (val > m) return m;
	jg	else_if			
	cmpl	%edx, %r9d					# else if (tmp != target) return -1;
	jne	empty_array
	rep ret 							# else return val;
else_if:
	movl	%r8d, %eax					# val = m;
	ret 								
skip_while:
	xorl	%r8d, %r8d					# m = 0;
	jmp	if
empty_array:
	movl	$-1, %eax					# return -1;
	ret
