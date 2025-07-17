	.text

FLAG_ROWS = 6
FLAG_COLS = 12

main:
main__for_outer_init:
	li	$t0, 0		#row = $t0
main__for_outer_cond:
	bge	$t0, FLAG_ROWS, main__for_outer_end
main__for_outer_body:


main__for_inner_init:
	li	$t1, 0	      #col  =0 
main__for_inner_cond:
	bge	$t1, FLAG_COLS, main__for_inner_end
main__for_inner_body:
	#get flag[row][cols]
	# find out offset -> row * total_cols + cols
	mul	$t2, $t0, FLAG_COLS   #row * total_cols
	add	$t2, $t2, $t1          # + cols
	mul	$t2, $t2, 1       #t2 is offset
	# we are interested in the value of flag[row][cols]
		

	lb	$t3, flag($t2)

	move	$a0, $t3
	li	$v0, 11
	syscall


main__for_inner_it:
	addi	$t1, $t1, 1
	j	main__for_inner_cond
main__for_inner_end:
	li	$a0, '\n'
	li	$v0, 11
	syscall

main__for_outer_it:
	addi	$t0, $t0, 1
	j	main__for_outer_cond
main__for_outer_end:
	jr	$ra
	.data
#global variables, string literals, arrays
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
