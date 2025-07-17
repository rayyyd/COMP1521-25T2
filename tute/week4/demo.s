	.text
sum:	
	#a0 = value
sum__prologue:
	push	$ra
	push	$s0

sum__body:
	li	$s0, 5		#i

	move	$a1, $a0
	move	$a0, $t0
	jal max
	
	jal	get_num
	# $v0 = j

	li	$t1, 5

	add	$v0, $v0, $s0
	add	$v0, $v0, $t1

sum__epilogue:
	pop	$s0
	pop	$ra
	jr	$ra

max:
	push	$ra
	bge	$a0, $a1, max_return_1
	j	max_return_2
max_return_1:
	move	$v0, $a0
	j	max__epilogue
max_return_2:
	move	$v0, $a1
max__epilogue:
	pop	$ra
	jr	$ra

get_num:
	push	$ra
	li	$v0, 4
	pop	$ra
	jr	$ra



	.data