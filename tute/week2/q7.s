	.text
main:

main__init:
	#$t0 = x
	li	$t0, 24
main__cond:
	bge 	$t0, 42, main__for_end
main__body:
	#printf statement
	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall
main__increment:
	addi	$t0, $t0, 3       # x = x + 3
	b	main__cond
main__for_end:
	jr	$ra         #return 
	.data


