	.text
# your code goes here!

SQUARE_MAX = 46340

main:
	#$t0 = x
	#$t1 = y 

	#     printf("Enter a number: ");


	li	$v0, 4    #load integer
	la	$a0, number  #load address
	syscall

    	# scanf("%d", &x);

	li	$v0, 5
	syscall
	move	$t0, $v0

	# if statmenet
	ble	$t0, SQUARE_MAX, main__else

	#printf statement
	li	$v0, 4    #load integer
	la	$a0, square  #load address
	syscall

	b	main__epilogue


main__else:
             #   y = x  *  x
	mul	$t1, $t0, $t0
	# printf("%d\n", y);

	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

main__epilogue:
	li	$v0, 0
	jr	$ra




	.data
# string literals and globals
number:
	.asciiz "Enter a number: "
square:
	.asciiz "square too big for 32 bits\n"