max:
    # Frame:    [$ra, $s0]   <- anything you push and pop
    # Uses:     [$ra, $s0, $a0, $a1, $v0]       <- anything you used
    # Clobbers: [$a0, $a1, $v0]        <- uses - frame
    #
    # Locals:           <-- FILL THIS OUT!
    #	$a0 -> array
    #   $a1 -> length
    #   $s0 -> first_element
    #   $v0 -> max_so_far
    # Structure:        <-- FILL THIS OUT!
    #   max
    #   -> [prologue]
    #	-> body
    #	-> if_1
    # 	-> if_1_end
    #		-> if_2
    #		-> if_2_end
    #   -> [epilogue]
max__prologue:
	begin
	push	$ra
	push	$s0
max__body:
	lw	$s0, ($a0)      #first_element needs to be in S
max__if_1:
	bne	$a1, 1, max__if_1_end
	move	$v0, $s0
	
	j	max__epilogue
max__if_1_end:
	add	$a0, $a0, 4       #inputs in a0, a1....
	add	$a1, $a1, -1
	jal	max
	#output of a function in $v0
	# max_so_Far is in $v0
max__if_2:
	ble	$s0, $v0, max__if_2_end
	move	$v0, $s0   #max_so_far = first_element;

max__if_2_end:

max__epilogue:
	pop	$s0
	pop	$ra
	end
	jr	$ra


main:
	push	$ra

	la	$a0, array
	li	$a1, 5
	jal	max

	move	$a0, $v0	#moving the result of max
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

	pop	$ra
	jr	$ra

	.data
array:
	.word 1,4,5,6,2

