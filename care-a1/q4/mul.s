	.globl times
times:
	#mov %edi, %eax      #  remove these two lines before
	#imull %esi, %eax    #  you start writing your code
	#mov $0, %rcx
	movl $1, %ecx
	movl %edi, %eax
	#mov %esi, %rsi


	cmpl $0, %edi
	jne or
	movl $0, %eax
	ret
or:
	cmpl $0, %esi
	jne loop
	movl $0, %eax
	ret

loop:
	cmpl %esi, %ecx
	jge endloop
	incl %ecx
	addl %edi, %eax
	jmp loop

endloop:
	ret

