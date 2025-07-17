# printf("%d times %d is %d\n", 2, 3, 6);



# syscall -> $v0 -> $a0.
main:
	li	$v0, 1
	li	$a0, 2
	syscall

	li	$v0, 4
	la	$a0, str1
	syscall

	li	$v0, 1
	li	$a0, 3
	syscall

	li	$v0, 4
	la	$a0, str2
	syscall

	li	$v0, 1
	li	$a0, 6
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	jr	$ra

	.data
str1:
	.asciiz " times "
str2:
	.asciiz " is "