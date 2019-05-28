	.globl get_byte_by_addr
get_byte_by_addr:
	movl $0, %eax   
	
	# place your code for Part 3 here
	# leal (%rdi, %esi, 4), %al
	# movl $4, eax
	# imull %esi, %eax 
	# shl %eax, %rdi
	mov (%edi, %esi), %al
	# end of Part 3

	ret
