	.globl sqrt
sqrt:		# Called the Fast Inverse Square Root algorithm
	movl $0, %eax   # place your code for Q3 here
	movl $15, %ecx
	movl $0x8000, %edx	# bit 16 = 1
	movl %edx, %r8d
	movl %r8d, %r9d
	# movl $0, %r9d
while:
	cmpl $0, %ecx
	jl bypass	# cannot = 0 account for edx = 1
# for:
	imull %r9d, %r9d   # r9d = r9d*r9d result = result * result
	cmpl %edi, %r9d    # r9d - edi > 0 result > x
	jle keep_bit
	xorl %edx, %r8d
	shr $1, %edx
	xorl %edx, %r8d
	# shr $1, %edx	# edx shift right 1 case edi > r9d
	# xorl %edx, %r8d	# keep 1 in current bit col and insert 1 next bit col
	# xorl %r9d, %r8d
	# loop for
	jmp continue
continue:
	movl %r8d, %r9d
	decl %ecx
	jmp while
keep_bit:				# case edi <= r9d
	shr $1, %edx
	xorl %edx, %r8d
	# xorl %edx, %r8d	# remove current 1 in current bit col
	# shr $1, %edx	# then edx shift right 1
	# xorl %edx, %r8d
	# loop for

	# movl %r8d, %r9d
	# decl %ecx
	# jmp while
	jmp continue
bypass:

	movl %r8d, %eax
	ret
