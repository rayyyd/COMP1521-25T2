	.text

N_SIZE = 10
main:
	# $t0 = i
	li	$t0, 0	#i = 0
main__while_cond:
	bge	$t0, N_SIZE, main__while_end  #while (i < N_SIZE) {
main__if_cond:
	#we need to get numbers[i]:
	# calculate the address of numbers[i]  = numbers + i * 4
	la	$t1, numbers
	mul	$t2, $t0, 4			# i * 4
	add	$t1, $t1, $t2		# numbers[i] address
	# get the value of numbers[i]
	lw	$t2, ($t1)     #value of numbers[i] is in $t2

	bge	$t2, 0, main__if_end	#if (numbers[i] < 0) {
	#  numbers[i] += 42;  -> numbers[i] = numbers[i] + 42
	#                          ^^^
	#                     make sure to save it back to memory!!
	add	$t2, $t2, 42
	sw	$t2, ($t1)    #t2 is value of numbers[i] + 42
				# t1 is address of numbers[i]

main__if_end:
	addi	$t0, $t0, 1
	b	main__while_cond
main__while_end:
	jr	$ra

	.data
# string literals, and global variables
# and also arrays!!! <- cheating
numbers:
	.word	0, 1, 2, -3, 4, -5, 6, -7, 8, 9