	.text

main:
	#$t0 = number
	#t1 = i

	#print
	li	$v0, 4    #load integer
	la	$a0, number  #load address
	syscall


	li	$v0, 5
	syscall
	move	$t0, $v0


	li	$t1, 1

while_condition:
	bge	$t1, $t0, while_end
while_body:
 	# if (i % 7 == 0 || i % 11 == 0) {
	rem	$t2, $t1, 7
	beq	$t2, $zero, while_if_body
	rem	$t2, $t1, 11
	beq	$t2, $zero, while_if_body
	b	while_if_end
while_if_body:
	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

while_if_end:
	addi	$t1, $t1, 1
	b	while_condition
while_end:
	li	$v0, 0
	jr	$ra



	.data
number:
	.asciiz "Enter a number: "