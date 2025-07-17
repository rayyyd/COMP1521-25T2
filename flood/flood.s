#######################################################################################
########################## COMP1521 25T2 ASSIGNMENT 1: Flood ##########################
##                                                                                   ##
## !!! IMPORTANT !!!                                                                 ##
## Before starting work on the assignment, make sure you set your tab-width to 8!    ##
## It is also suggested to indent with tabs only.                                    ##
## Instructions to configure your text editor can be found here:                     ##
##   https://cgi.cse.unsw.edu.au/~cs1521/current/resources/mips-editors.html         ##
## !!! IMPORTANT !!!                                                                 ##
##                                                                                   ##
## This program was written by YOUR-NAME-HERE (z55555555)                            ##
## on INSERT-DATE-HERE                                                               ##
##                                                                                   ##
## HEY! HEY YOU! Fill this header comment in RIGHT NOW!!! Don't miss out on that     ##
## precious style mark!!      >:O                                                    ##


########################################
## CONSTANTS: REQIURED FOR GAME LOGIC ##
########################################

TRUE = 1
FALSE = 0

UP_KEY = 'w'
LEFT_KEY = 'a'
DOWN_KEY = 's'
RIGHT_KEY = 'd'

FILL_KEY = 'e'

CHEAT_KEY = 'c'
HELP_KEY = 'h'
EXIT_KEY = 'q'

COLOUR_ONE = '='
COLOUR_TWO = 'x'
COLOUR_THREE = '#'
COLOUR_FOUR = '.'
COLOUR_FIVE = '*'
COLOUR_SIX = '`'
COLOUR_SEVEN = '@'
COLOUR_EIGHT = '&'

NUM_COLOURS = 8

MIN_BOARD_WIDTH = 3
MAX_BOARD_WIDTH = 12
MIN_BOARD_HEIGHT = 3
MAX_BOARD_HEIGHT = 12

BOARD_VERTICAL_SEPERATOR = '|'
BOARD_CROSS_SEPERATOR = '+'
BOARD_HORIZONTAL_SEPERATOR = '-'
BOARD_CELL_SEPERATOR = '|'
BOARD_SPACE_SEPERATOR = ' '
BOARD_CELL_SIZE = 3

SELECTED_ARROW_VERTICAL_LENGTH = 2

GAME_STATE_PLAYING = 0
GAME_STATE_LOST = 1
GAME_STATE_WON = 2

NUM_VISIT_DELTAS = 4
VISIT_DELTA_ROW = 0
VISIT_DELTA_COL = 1

MAX_SOLUTION_STEPS = 64

NOT_VISITED = 0
VISITED = 1
ADJACENT = 2

EXTRA_STEPS = 2

#################################################
## CONSTANTS: PLEASE USE THESE FOR YOUR SANITY ##
#################################################

SIZEOF_INT = 4
SIZEOF_PTR = 4
SIZEOF_CHAR = 1

##########################################################
## struct fill_in_progress {                            ##
##     int cells_filled;                                ##
##     char visited[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]; ##
##     char fill_with;                                  ##
##     char fill_onto;                                  ##
## };                                                   ##
##########################################################

CELLS_FILLED_OFFSET = 0
VISITED_OFFSET = CELLS_FILLED_OFFSET + SIZEOF_INT
FILL_WITH_OFFSET = VISITED_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR
FILL_ONTO_OFFSET = FILL_WITH_OFFSET + SIZEOF_CHAR

SIZEOF_FILL_IN_PROGRESS = FILL_ONTO_OFFSET + SIZEOF_CHAR

############################
## struct step_rating {   ##
##     int surface_area;  ##
##     int is_eliminated; ##
## };                     ##
############################

SURFACE_AREA_OFFSET = 0
IS_ELIMINATED_OFFSET = SURFACE_AREA_OFFSET + SIZEOF_INT

STEP_RATING_ALIGNMENT = 0

SIZEOF_STEP_RATING = IS_ELIMINATED_OFFSET + SIZEOF_INT + STEP_RATING_ALIGNMENT

###################################################################
## struct solver {                                               ##
##     struct step_rating step_rating_for_colour[NUM_COLOURS];   ##
##     int solution_length;                                      ##
##     char simulated_board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT];  ##
##     char future_board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT];     ##
##     char adjacent_to_cell[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]; ##
##     char optimal_solution[MAX_SOLUTION_STEPS];                ##
## };                                                            ##
###################################################################

STEP_RATING_FOR_COLOUR_OFFSET = 0
SOLUTION_LENGTH_OFFSET = STEP_RATING_FOR_COLOUR_OFFSET + SIZEOF_STEP_RATING * NUM_COLOURS
SIMULATED_BOARD_OFFSET = SOLUTION_LENGTH_OFFSET + SIZEOF_INT
FUTURE_BOARD_OFFSET = SIMULATED_BOARD_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR
ADJACENT_TO_CELL_OFFSET = FUTURE_BOARD_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR
OPTIMAL_SOLUTION_OFFSET = ADJACENT_TO_CELL_OFFSET + MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT * SIZEOF_CHAR

SIZEOF_SOLVER = OPTIMAL_SOLUTION_OFFSET + MAX_SOLUTION_STEPS * SIZEOF_CHAR

###################
## END CONSTANTS ##
###################

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

######################
## GLOBAL VARIABLES ##
######################

	.data

###############################################
## char selected_arrow_horizontal[] = "<--"; ##
###############################################

selected_arrow_horizontal:
	.asciiz "<--"

##################################################
## char selected_arrow_vertical[] = {'^', '|'}; ##
##################################################

selected_arrow_vertical:
	.ascii "^|"

################################
## char cmd_waiting[] = "> "; ##
################################

cmd_waiting:
	.asciiz "> "

############################################################
## char colour_selector[NUM_COLOURS] = {                  ##
##    COLOUR_ONE, COLOUR_TWO, COLOUR_THREE, COLOUR_FOUR,  ##
##    COLOUR_FIVE, COLOUR_SIX, COLOUR_SEVEN, COLOUR_EIGHT ##
## };                                                     ##
############################################################

colour_selector:
	.byte COLOUR_ONE, COLOUR_TWO, COLOUR_THREE, COLOUR_FOUR
	.byte COLOUR_FIVE, COLOUR_SIX, COLOUR_SEVEN, COLOUR_EIGHT

#########################################################
## char game_board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]; ##
#########################################################

game_board:
	.align 2
	.space MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT

##################################################################
## int visit_deltas[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}; ##
##################################################################

visit_deltas:
	.word -1, 0
	.word 1, 0
	.word 0, -1
	.word 0, 1

#######################
## int selected_row; ##
#######################

selected_row:
	.align 2
	.space 4

##########################
## int selected_column; ##
##########################

selected_column:
	.align 2
	.space 4

######################
## int board_width; ##
######################

board_width:
	.align 2
	.space 4

#######################
## int board_height; ##
#######################

board_height:
	.align 2
	.space 4

################################################
## char optimal_solution[MAX_SOLUTION_STEPS]; ##
################################################

optimal_solution:
	.align 2
	.space MAX_SOLUTION_STEPS * SIZEOF_CHAR

########################
## int optimal_steps; ##
########################

optimal_steps:
	.align 2
	.space 4

######################
## int extra_steps; ##
######################

extra_steps:
	.align 2
	.space 4

################
## int steps; ##
################

steps:
	.align 2
	.space 4


#####################
## int game_state; ##
#####################

game_state:
	.align 2
	.space 4

###############################
## unsigned int random_seed; ##
###############################

random_seed:
	.align 2
	.space 4

######################################################
## struct fill_in_progress global_fill_in_progress; ##
######################################################

global_fill_in_progress:
	.align 2
	.space SIZEOF_FILL_IN_PROGRESS

##################################
## struct solver global_solver; ##
##################################

global_solver:
	.align 2
	.space SIZEOF_SOLVER

## DO NOT MODIFY THE .DATA SECTION!!! ##

##########################
## END GLOBAL VARIABLES ##
##########################

####################
## STATIC STRINGS ##
####################

## DO NOT MODIFY THE .DATA SECTION!!! ##

	.data

str_print_welcome_1:
	.asciiz "Welcome to flood!\n"

str_print_welcome_2:
	.asciiz "To move your cursor up/down, use "

str_print_welcome_3:
	.asciiz "To move your cursor left/right, use "

str_print_welcome_4:
	.asciiz "To see this message again, use "

str_print_welcome_5:
	.asciiz "To perform flood fill on the grid, use "

str_print_welcome_6:
	.asciiz "To cheat and see the 'optimal' solution, use "

str_print_welcome_7:
	.asciiz "To exit, use "

str_game_loop_win:
	.asciiz "You win!\n"

str_game_loop_lose:
	.asciiz "You lose :(\n"

str_initialise_game_enter_width:
	.asciiz "Enter the grid width: "

str_initialise_game_enter_height:
	.asciiz "Enter the grid height: "

str_initialise_game_invalid_width:
	.asciiz "Invalid width!\n"

str_initialise_game_invalid_height:
	.asciiz "Invalid height!\n"

str_initialise_game_enter_seed:
	.asciiz "Enter a random seed: "

str_do_fill_filled_1:
	.asciiz "Filled "

str_do_fill_filled_2:
	.asciiz " cells!\n"

str_print_board_steps:
	.asciiz " steps\n"

str_process_command_unknown:
	.asciiz "Unknown command: "

## DO NOT MODIFY THE .DATA SECTION!!! ##

##############
## SUBSET 0 ##
##############

## int main(void); ##

	.text
main:

main__prologue:
	push 	$ra
main__body:
#use print_welcome:
	jal	print_welcome
#initialise_game:
	jal	initialise_game
#use game_loop:
	jal	game_loop
main__epilogue:
	pop	$ra
	li	$v0,0
	jr	$ra

## void print_welcome(); ##
	.text
print_welcome:

print_welcome__prologue:
print_welcome__body:
# welcome to flood
	li	$v0,4
	la	$a0,str_print_welcome_1
	syscall
#to move up down
	li	$v0,4
	la	$a0,str_print_welcome_2
	syscall

	li	$v0,11
	la	$a0,UP_KEY
	syscall

	li	$v0,11
	li	$a0,'/'
	syscall

	li	$v0,11
	la	$a0,DOWN_KEY
	syscall

	li	$v0,11
	li	$a0,'\n'
	syscall

#to move left right
	li	$v0,4
	la	$a0,str_print_welcome_3
	syscall

	li	$v0,11
	li	$a0,LEFT_KEY
	syscall

	li	$v0,11
	li	$a0,'/'
	syscall

	li	$v0,11
	li	$a0,RIGHT_KEY
	syscall

	li	$v0,11
	li	$a0,'\n'
	syscall

#to see...
	li	$v0,4
	la	$a0,str_print_welcome_4
	syscall
# HELP
	li	$v0,11
	li	$a0,HELP_KEY
	syscall
#newline
	li	$v0,11
	li	$a0,'\n'
	syscall

#to perform...
	li	$v0,4
	la	$a0,str_print_welcome_5
	syscall
# up
	li	$v0,11
	li	$a0,FILL_KEY
	syscall
#newline
	li	$v0,11
	li	$a0,'\n'
	syscall

#to cheat...
	li	$v0,4
	la	$a0,str_print_welcome_6
	syscall
#up
	li	$v0,11
	li	$a0,CHEAT_KEY
	syscall
#newline
	li	$v0,11
	li	$a0,'\n'
	syscall

#to exit...
	li	$v0,4
	la	$a0,str_print_welcome_7
	syscall
# up
	li	$v0,11
	li	$a0,EXIT_KEY
	syscall
#newline
	li	$v0,11
	li	$a0,'\n'
	syscall
print_welcome__epilogue:
	jr	$ra

## SUBSET 1 ##

## int in_bounds(int value, int minimum, int maximum); ##

	.text
in_bounds:
	
in_bounds__prologue:
in_bounds__body:
	blt	$a0,$a1,over_bounds
	bgt	$a0,$a2,over_bounds
	li	$v0,1
	jr	$ra

over_bounds:
	li	$v0,0
	jr	$ra

## void game_loop(); ##
	.text
game_loop:

game_loop__prologue:
	push 	$ra
	push	$s3
	la	$a0,game_board
	jal	print_board
game_loop__body:
process_command_loop_check:
	la	$s3,game_state
	lw	$t1,($s3)	#t1 = game_statement
	li	$t2,GAME_STATE_PLAYING	# t2 = game_state
	bne	$t1,$t2,process_command_loop_end
	jal	process_command
	j	process_command_loop_check
process_command_loop_end:

	la	$s3,game_state
	lw	$t1,($s3)	#t1 = game_statement
	
	li	$t2,GAME_STATE_WON	# t2 = game_won
	beq	$t1,$t2,print_win

	li	$t2,GAME_STATE_LOST
	beq	$t1,$t2,print_lose	# t2 = game_lose

	j	game_loop__epilogue
print_win:
	li	$v0,4
	la	$a0,str_game_loop_win
	syscall
	j	game_loop__epilogue
print_lose:
	li	$v0,4
	la	$a0,str_game_loop_lose
	syscall
	j	game_loop__epilogue

game_loop__epilogue:
	pop	$s3
	pop	$ra
	jr	$ra

## void initialise_game(); ##
	.text
initialise_game:
	# Subset:   1
	#
	# Frame:    [$ra]   <-- FILL THESE OUT!
	# Uses:     [$t1-$t9,$a0,$v0,]
	# Clobbers: [$v0]
	#
	# Locals:           <-- FILL THIS OUT!
	# 	- row:		$t1
	#	- col:		$t4
	#	- height:	$t3
	#	- width:	$t6
	#	- offset:	$t7
	#	- base:		$t8
	#	- colour:	$s3
	# Structure:        <-- FILL THIS OUT!
	#   game_finished
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]
initialise_game__prologue:
	push $ra
	push	$s3
initialise_game__body:
# grid widthand height input and check:
width_and_height_loop:
	li		$v0,4
	la		$a0,str_initialise_game_enter_width
	syscall

	li		$v0,5
	syscall
	move	$s3,$v0 	# s3 = user_width

	la		$t1,board_width
	sw		$s3,($t1)		# t1 = b-w = u-w

	move	$a0,$s3		# a0 = s3 = users
	li		$a1,MIN_BOARD_WIDTH
	li		$a2,MAX_BOARD_WIDTH
	jal		in_bounds

	beqz	$v0,width_wrong

	li		$v0,4
	la		$a0,str_initialise_game_enter_height
	syscall

	li		$v0,5
	syscall
	move	$t2,$v0 	# t2 = user_height

	la		$t3,board_height
	sw		$t2,($t3)	    # t3 = b-h = u-h

	move	$a0,$t2		# a0 = t2 = users
	li		$a1,MIN_BOARD_HEIGHT
	li		$a2,MAX_BOARD_HEIGHT
	jal		in_bounds

	beqz	$v0,height_wrong

	j		input_data
width_wrong:
	li		$v0,4
	la		$a0,str_initialise_game_invalid_width
	syscall

	j		width_and_height_loop
height_wrong:
	li		$v0,4
	la		$a0,str_initialise_game_invalid_height
	syscall

	j		width_and_height_loop
input_data:
	li		$v0,4
	la		$a0,str_initialise_game_enter_seed
	syscall

	li		$v0,5
	syscall
	la		$t4,random_seed
	sw		$v0,($t4)	# t4 = random_seed = users

	la		$t5,selected_row
	sw		$zero,($t5)	#selected_row = 0

	la		$t6,selected_column
	sw		$zero,($t6)	#selected_column = 0

	la		$t7,steps
	sw		$zero,($t7)	#steps = 0

	li		$s3,EXTRA_STEPS
	la		$t8,extra_steps
	sw		$s3,($t8)	#extra = EXTRA

	li		$s3,GAME_STATE_PLAYING
	la		$t9,game_state
	sw		$s3,($t9)	#game = GAME

	jal		initialise_board
	jal		find_optimal_solution

initialise_game__epilogue:
	pop		$s3
	pop		$ra
	jr		$ra

## int game_finished(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]); ##

	.text
game_finished:
	# Subset:   1
	#
	# Frame:    [ ]   <-- FILL THESE OUT!
	# Uses:     [a0]
	# Clobbers: [t1-t9,v0]
	#
	# Locals:           <-- FILL THIS OUT!
	# 	- row:		$t1
	#	- col:		$t4
	#	- height:	$t3
	#	- width:	$t6
	#	- offset:	$t7
	#	- base:		$t8
	#	- colour:	$s3
	# Structure:        <-- FILL THIS OUT!
	#   game_finished
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]
	# have the mistake in return value
game_finished__prologue:
	push	$ra
	push	$s3
game_finished__body:
	lb 	$s3,($a0)		# s3 = expect_colour = board[0][0]
row_loop_initial:
	li	$t1,0			# row = t1 = 0
	la	$t2,board_height
	lw	$t3,($t2)		# t3 = board_height
row_loop_cond:
	bge	$t1,$t3,game_finished__epilogue
row_loop_body:

col_loop_initial:
	li		$t4,0			# col = t4 = 0
	la		$t5,board_width
	lw		$t6,($t5)		# t6 = board_width
col_loop_cond:
	bge		$t4,$t6,row_loop_step
col_loop_body:
	mul		$t7,$t1, MAX_BOARD_WIDTH
	add		$t7,$t7,$t4		# offset
	add		$t8,$a0,$t7		# t8 = board[row][col]

	lb		$t9,($t8)
	bne		$t9,$s3,false	# board[row][col] != expected
col_loop_step:
	addi		$t4,$t4,1
	j		col_loop_cond
row_loop_step:
	addi		$t1,$t1,1
	j		row_loop_cond

false:
	li		$v0,FALSE
	j	game_finished__epilogue		#ray < was not j epilogues before

game_finished__epilogue:
	li		$v0,TRUE
	pop	$s3
	pop	$ra
	jr		$ra

## void do_fill(); ##
	.text
do_fill:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   do_fill
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

do_fill__prologue:
	push		$ra
	push	$s3
do_fill__body:
	la		$s3,selected_row
	lw		$t1,($s3)		# t1 = selected_row
	la		$t2,selected_column
	lw		$t3,($t2)		# t2 = selected_col
	la		$t4,game_board	
	mul		$t5,$t1,MAX_BOARD_WIDTH
	add		$t5,$t5,$t3
	add		$t6,$t4,$t5		

	lb		$t7,($t6)		# t7 = game_board[row][col]
	lb		$t8,($t4)		# t8 = game_board[0][0]

	la		$a0,global_fill_in_progress
	move		$a1,$t7
	move		$a2,$t8

	jal		initialise_fill_in_progress

	la		$a0,global_fill_in_progress
	la		$a1,game_board
	li		$a2,0
	li		$a3,0

	jal		fill

	la		$a0,str_do_fill_filled_1
	li		$v0,4
	syscall

	la		$s3,global_fill_in_progress
	lw		$a0,($s3)
	li		$v0,1
	syscall

	la		$a0,str_do_fill_filled_2
	li		$v0,4
	syscall

	la		$s3,steps
	lw		$t1,($s3)		# t1 = steps
	addi		$t1,$t1,1
	sw		$t1,($s3)		# s3 = steps

	la		$t2,game_board
	lw		$t3,($t2)
	move		$a0,$t2

	jal		game_finished

	beq		$v0,1,win_state

step_check:
	la		$t2,steps
	lw		$t3,($t2)		# t2 = steps
	la		$t4,optimal_steps
	lw		$t5,($t4)
	la		$t6,extra_steps
	lw		$t7,($t6)
	add		$t8,$t5,$t7

	ble		$t3,$t8,do_fill__epilogue
lose_statement:
	la		$s3,GAME_STATE_LOST
	la		$t1,game_state
	sw		$s3,($t1)
	j		do_fill__epilogue
win_state:
	la		$s3,GAME_STATE_WON
	la		$t1,game_state
	sw		$s3,($t1)

	j		step_check

do_fill__epilogue:
	pop	$s3
	pop 		$ra
	jr		$ra

##############
## SUBSET 2 ##
##############

########################################################################
## void initialise_fill_in_progress(struct fill_in_progress *init_me, ## 
##     char fill_with, char fill_onto);                               ##
########################################################################

################################################################################
# .TEXT <initialise_fill_in_progress>
	.text
initialise_fill_in_progress:
	# Subset:   2
	#
	# Frame:    [ ]   
	# Uses:     [$a0-$a1,$t1-$t6]
	# Clobbers: [$s3,$t2,$t4,$t6]
	#
	# Locals:   $a0 = struct fill_in_progress        
	#   	    $a1 = FILL_WITH_OFFSET
	#	    $a2 = FILL_ONTO_OFFSET
	#	    $s3 = int row
	# 	    $t2 = int col
	# 	    $t4 = adress of visited
	# Structure:        
	#   initialise_fill_in_progress
	#   -> [prologue]
	#       -> body
	#	-> row_loop
	#	-> col_loop
	#   -> [epilogue]

initialise_fill_in_progress__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2		#ray add push and pop
	push	$s3
initialise_fill_in_progress__body:
	sb	$a1,FILL_WITH_OFFSET($a0)	# fill_with
	sb	$a2,FILL_ONTO_OFFSET($a0)	# fill_onto
	sw	$zero,0($a0)

initialise_fill_row_loop_initial:
	li	$s3,0				# s3 = row = 0
	lw	$t1,board_height
initialise_fill_row_loop_cond:
	bge	$s3,$t1,initialise_fill_in_progress__epilogue
initialise_fill_row_loop_body:

initialise_fill_col_loop_initial:
	li	$t2,0				# t2 = col
	lw	$t3,board_width
initialise_fill_col_loop_cond:
	bge	$t2,$t3,initialise_fill_row_loop_step
initialise_fill_col_loop_body:
	mul	$t4,$s3,MAX_BOARD_WIDTH		# t4 = row * max_width
	add	$t4,$t4,$t2			# t4 = $t4 + col
	la	$t5,VISITED_OFFSET($a0)
	add	$t4,$t4,$t5			# t4 = adress of visited
	li	$t6,NOT_VISITED
	sb	$t6,($t4)
initialise_fill_col_loop_step:
	addi	$t2,$t2,1
	j	initialise_fill_col_loop_cond
initialise_fill_row_loop_step:
	addi	$s3,$s3,1
	j	initialise_fill_row_loop_cond
initialise_fill_in_progress__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra
##############################
## void initialise_board(); ##
##############################

################################################################################
# .TEXT <initialise_board>
	.text
initialise_board:
	# Subset:   2
	#
	# Frame:    [$ra,$s0,$s1]   <-- FILL THESE OUT!
	# Uses:     [$t1-$t6]
	# Clobbers: [ ]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t3 = address of colour_selecter[index]
	#   - $t6 = adress of game_board[row][col]
	# Structure:        <-- FILL THIS OUT!
	#   initialise_board
	#   -> [prologue]
	#       -> body
	#	   -> initialise_board_row_loop_initialise
	#	   -> initialise_board_row_loop_cond
	#	   -> initialise_board_row_loop_body
	#	   -> initialise_board_col_loop_initialise
	#	   -> initialise_board_col_loop_cond
	#	   -> initialise_board_col_loop_body
	#	   -> initialise_board_col_loop_step
	#	   -> initialise_board_row_loop_step
	#   -> [epilogue]

initialise_board__prologue:
        begin
	push	$ra
	push	$s0
	push	$s1
initialise_board__body:

initialise_board_row_loop_initialise:
	li	$s0,0		# s0 = row
initialise_board_row_loop_cond:
	bge	$s0,MAX_BOARD_HEIGHT,initialise_board__epilogue
initialise_board_row_loop_body:

initialise_board_col_loop_initialise:
	li	$s1,0		# s1 = col
initialise_board_col_loop_cond:
	bge	$s1,MAX_BOARD_WIDTH,initialise_board_row_loop_step
initialise_board_col_loop_body:

	li	$a0,0
	li	$a1,NUM_COLOURS-1

	jal	random_in_range	# v0 = colour_selector_index

	la	$t2,colour_selector
	add	$t3,$t2,$v0	# t3 = address of colour_selecter[index]
	lb	$t4,($t3)

	mul	$t5,$s0,MAX_BOARD_WIDTH
	add	$t5,$t5,$s1
	la	$t6,game_board
	add	$t6,$t6,$t5	# t6 = adress of game_board[row][col]
	sb	$t4,($t6)
initialise_board_col_loop_step:
	addi	$s1,$s1,1
	j	initialise_board_col_loop_cond
initialise_board_row_loop_step:
	addi	$s0,$s0,1
	j	initialise_board_row_loop_cond
initialise_board__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
        end
	jr	$ra

###################################
## void find_optimal_solution(); ##
###################################

################################################################################
# .TEXT <find_optimal_solution>
	.text
find_optimal_solution:
	# Subset:   2
	#
	# Frame:    [$ra]   <-- FILL THESE OUT!
	# Uses:     [$a0,$a1,$a2,$t1,$t2,$t4,$t5,$t6,$t7]
	# Clobbers: [$a0,$a1,$s3,$t5]
	#
	# Locals:           <-- FILL THIS OUT!
	#   	- $a0 = global_solver
	#	- $t1 = global_solver.simulated_board
	#	- $s3 = global_solver
	#	- $a1 = char optimal_solution
	#	- $a2 = global_solver.solution_length
	#
	# Structure:        <-- FILL THIS OUT!
	#   find_optimal_solution
	#   -> [prologue]
	#       -> body
	#	-> find_optimal_solution_loop_cond
	#	-> find_optimal_solution_loop_done
	#   -> [epilogue]

find_optimal_solution__prologue:
	push	$ra
find_optimal_solution__body:
	la	$a0,global_solver		# $s3 = adress of global_solver 
	jal	initialise_solver
find_optimal_solution_loop_cond:
	la	$s3,global_solver		
	addi	$t1,$s3,SIMULATED_BOARD_OFFSET	# t1 = global_solver.simulated_board
	
	move	$a0,$t1
	jal	game_finished			# $v0 = TURE || FALSE
	move	$t2,$v0

	bne	$t2,$zero,find_optimal_solution_loop_done

	la	$s3,global_solver
	move	$a0,$s3
	jal	solve_next_step

	j	find_optimal_solution_loop_cond
find_optimal_solution_loop_done:
	la	$s3,global_solver
	addi	$a0,$s3,OPTIMAL_SOLUTION_OFFSET
	la	$a1,optimal_solution
	lw	$a2,SOLUTION_LENGTH_OFFSET($s3)
	jal	copy_mem

	la	$s3,global_solver
	lw	$t4,SOLUTION_LENGTH_OFFSET($s3)
	la	$t5,optimal_solution
	add	$t5,$t5,$t4
	li	$t6,'\0'
	sb	$t6,($t5)

	la	$t7,optimal_steps
	sw	$t4,($t7)
find_optimal_solution__epilogue:
	pop	$ra
	jr	$ra
################################################################
## int invalid_step(struct solver *solver, int colour_index); ##
################################################################

################################################################################
# .TEXT <invalid_step>
	.text
invalid_step:
	# Subset:   2
	#
	# Frame:    [$ra,$s0.$s1.$s2]   <-- FILL THESE OUT!
	# Uses:     [$t1-$t9,$a0]
	# Clobbers: [$a0]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - s3 = solver->simulated_board[0][0]
	#   - s1 = colour_selector[colour_index]
	#   - t7 = s0 = solver->simulated_board[row][col]
	#   - s2 = solver->adjacent_to_cell[row][col]
	#
	# Structure:        <-- FILL THIS OUT!
	#   invalid_step
	#   -> [prologue]
	#       -> body
	#	   -> invalid_step_first_if_brench_end
	#	   -> invalid_step_row_loop_initial
	#	   -> invalid_step_row_loop_cond
	#	   -> invalid_step_col_loop_body
	#	   -> invalid_step_col_loop_step
	#	   -> invalid_step_row_loop_step
	#	   -> invalid_step_second_if_brench
	#	   -> invalid_step_true_statement
	#	   -> invalid_step_false_statement
	#   -> [epilogue]
invalid_step__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
invalid_step__body:
	move	$s0,$a0					# s0 = *solver
	lb	$s3,SIMULATED_BOARD_OFFSET($s0)		# s3 = solver->simulated_board[0][0]
	la	$t1,colour_selector
	add	$t1,$t1,$a1
	lb	$s1,($t1)				# s1 = colour_selector[colour_index]

	beq	$s3,$s1,invalid_step_true_statement			# if (solver->simulated_board[0][0] == colour_selector[colour_index])
invalid_step_first_if_brench_end:
	jal	initialise_solver_adjacent_cells
	
	move	$a0,$s0
	li	$a1,0
	li	$a2,0
	jal	find_adjacent_cells

	li	$t2,FALSE				# t2 = found = FALSE
invalid_step_row_loop_initial:
	li	$t3,0					# t3 = row = 0
invalid_step_row_loop_cond:
	lw	$t9,board_height
	bge	$t3,$t9,invalid_step_second_if_brench
invalid_step_col_loop_initial:
	li	$t4,0					# t4 = col = 0
invalid_step_col_loop_cond:
	lw	$t9,board_width
	bge	$t4,$t9,invalid_step_row_loop_step
invalid_step_col_loop_body:
	mul	$t5,$t3,MAX_BOARD_WIDTH			# t5 = row*max_width
	add	$t5,$t5,$t4				# t5 = row*max_width + col
	addiu	$t6,$s0,SIMULATED_BOARD_OFFSET		# t6 = adress of (solver->simulated_board)
	add	$t6,$t6,$t5	
	lb	$t7,($t6)				# t7 = s0 = solver->simulated_board[row][col] 
	bne	$t7,$s1,invalid_step_col_loop_step

	addiu	$t8,$s0,ADJACENT_TO_CELL_OFFSET		# t8 = adress of (solver->adjacent_to_cell)
	add	$t8,$t8,$t5
	lb	$s2,($t8)				# s2 = solver->adjacent_to_cell[row][col]
	bne	$s2,ADJACENT,invalid_step_col_loop_step

	li	$t2,TRUE
invalid_step_col_loop_step:
	addi	$t4,$t4,1
	j	invalid_step_col_loop_cond
invalid_step_row_loop_step:
	addi	$t3,$t3,1
	j	invalid_step_row_loop_cond
invalid_step_second_if_brench:
	beq	$t2,TRUE,invalid_step_false_statement

invalid_step_true_statement:
	li	$v0,TRUE
	j	invalid_step__epilogue
invalid_step_false_statement:
	li	$v0,FALSE
invalid_step__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra

	jr	$ra

####################################
## void print_optimal_solution(); ##
####################################

################################################################################
# .TEXT <print_optimal_solution>
	.text
print_optimal_solution:
	# Subset:   2
	#
	# Frame:    [$s0]   <-- FILL THESE OUT!
	# Uses:     [$t1,$t2,$t3,$t4,$t5,$a0,$v0]
	# Clobbers: [$a0,$v0]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $s0 = *s = optimal_solution
	#
	# Structure:        <-- FILL THIS OUT!
	#   print_optimal_solution
	#   -> [prologue]
	#       -> body
	#	   -> print_optimal_solution_loop_initial
	#	   -> print_optimal_solution_loop_cond
	#	   -> print_optimal_solution_loop_body
	#	   -> print_optimal_solution_new_line
	#	   -> print_optimal_solution_loop_end
	#	   -> print_optimal_solution_loop_two
	#	   -> print_optimal_solution_print_space
	#	   -> print_optimal_loop_if_end
	#   -> [epilogue]
print_optimal_solution__prologue:
	push	$s0
print_optimal_solution__body:
	la	$s0,optimal_solution		# s0 = *s = optimal_solution
print_optimal_solution_loop_initial:
	lb	$s3,($s0)			# s3 = *s
print_optimal_solution_loop_cond:
	beq	$s3,$zero,print_optimal_solution_loop_end
print_optimal_solution_loop_body:
	move	$a0,$s3
	li	$v0,11
	syscall

	addi	$s0,$s0,1			# s++

	lb	$t1,($s0)			# t1 = s3 = *s++
	beq	$t1,$zero,print_optimal_solution_new_line

	li	$a0,','
	li	$v0,11
	syscall

	li	$a0,' '
	li	$v0,11
	syscall
	j	print_optimal_solution_loop_initial
print_optimal_solution_new_line:
	li	$a0,'\n'
	li	$v0,11
	syscall
	j	print_optimal_solution_loop_initial
print_optimal_solution_loop_end:
	la	$s0,optimal_solution		# s0 = adress of optimal_solution
	li	$t2,0				# i = 0
	lw	$t3,steps			# t3 = steps
	lw	$t4,optimal_steps		# t4 = optimal_steps

	ble	$t3,$t4,print_optimal_solution_loop_two
	li	$a0,10
	li	$v0,11
	syscall
	j	print_optimal_solution__epilogue
print_optimal_solution_loop_two:
	lb	$t5,($s0)			# t5 = *s
	beq	$t5,$zero,print_optimal_solution__epilogue

	bne	$t2,$t3,print_optimal_solution_print_space

	li	$a0,'^'
	li	$v0,11
	syscall
	j	print_optimal_loop_if_end
print_optimal_solution_print_space:
	li	$a0,' '
	li	$v0,11
	syscall
print_optimal_loop_if_end:
	li	$a0,' '
	li	$v0,11
	syscall

	li	$a0,' '
	li	$v0,11
	syscall

	addi	$s0,$s0,1
	addi	$t2,$t2,1

	lb	$t5,($s0)
	bne	$t5,$zero,print_optimal_solution_loop_two

	li	$a0,'\n'
	li	$v0,11
	syscall
	j	print_optimal_solution_loop_two
print_optimal_solution__epilogue:
	pop	$s0
	jr	$ra

##############
## SUBSET 3 ##
##############

################################################################
## void rate_choice(struct solver *solver, int colour_index); ##
################################################################

################################################################################
# .TEXT <rate_choice>
	.text
rate_choice:
	# Subset:   3
	#
	# Frame:    [$s0,$s1,$s2]   <-- FILL THESE OUT!
	# Uses:     [$a0,$a1,$a2,$t1-$t9]
	# Clobbers: [ ]
	#
	# Locals:           <-- FILL THIS OUT!
	#   
	# 	- s0 = struct solver *solver
	# 	- s3 = colour_index
	# 	- t1 = solver->step_rating_for_colour[colour_index].is_eliminated
	# 	- t3 = solver->step_rating_for_colour[colour_index].surface_area
	# 	- s2 = colour_selecter[colour_index]
	# 	- t8 = solver->simulated_board[row][col]
	# 	- t8 = solver->adjacent_to_cell[row][col]
	# Structure:        <-- FILL THIS OUT!
	#   rate_choice
	#   -> [prologue]
	#       -> body
	#	   -> rate_choice_row_loop_initial
	#	   -> rate_choice_row_loop_cond
	#	   -> rate_choice_col_loop_initial
	#	   -> rate_choice_col_loop_cond
	#	   -> rate_choice_col_loop_body
	#	   -> rate_choice_first_if_end:
	#	   -> rate_choice_else_if
	#	   -> rate_choice_col_loop_step
	#	   -> rate_choice_row_loop_step
	#	   -> rate_choice_row_loop_end
	#   -> [epilogue]

rate_choice__prologue:
	push	$s0
	push	$s1
	push	$s2
	push	$s3
rate_choice__body:	
	move	$s0,$a0					# s0 = struct solver *solver
	move	$s3,$a1					# s3 = colour_index

	add	$t1,$s0,STEP_RATING_FOR_COLOUR_OFFSET	# solver->step_rating_for_colour
	mul	$t2,$s3,SIZEOF_STEP_RATING
	add	$t1,$t1,$t2				# solver->step_rating_for_colour[colour_index]
	add	$t1,$t1,IS_ELIMINATED_OFFSET		# t1 = solver->step_rating_for_colour[colour_index].is_eliminated
	li	$t2,TRUE				
	sb	$t2,($t1)				

	add	$t3,$s0,STEP_RATING_FOR_COLOUR_OFFSET	# solver->step_rating_for_colour
	mul	$t2,$s3,SIZEOF_STEP_RATING
	add	$t3,$t3,$t2				# solver->step_rating_for_colour[colour_index]
	add	$t3,$t3,SURFACE_AREA_OFFSET		# t3 = solver->step_rating_for_colour[colour_index].surface_area
	li	$t2,0
	sb	$t2,($t3)				

	li	$s1,FALSE				# s1 = seen = False
rate_choice_row_loop_initial:
	li	$t4,0					# t4 = row = 0
rate_choice_row_loop_cond:
	lw	$t5,board_height
	bge	$t4,$t5,rate_choice_row_loop_end
rate_choice_col_loop_initial:
	li	$t6,0					# t6 = col = 0
rate_choice_col_loop_cond:
	lw	$t5,board_width
	bge	$t6,$t5,rate_choice_row_loop_step
rate_choice_col_loop_body:
	mul	$t7,$t4,MAX_BOARD_WIDTH
	add	$t7,$t7,$t6				# t7 = row*width + col
	
	add	$t8,$s0,SIMULATED_BOARD_OFFSET
	add	$t8,$t8,$t7				# t8 = solver->simulated_board[row][col]
	la	$s2,colour_selector
	add	$s2,$s2,$s3				# s2 = colour_selecter[colour_index]
	
	lb	$t9,($t8)
	lb	$t2,($s2)

	bne	$t9,$t2,rate_choice_first_if_end
	li	$s1,TRUE
rate_choice_first_if_end:
	add	$t8,$s0,ADJACENT_TO_CELL_OFFSET
	add	$t8,$t8,$t7				# t8 = solver->adjacent_to_cell[row][col]
	lb	$t9,($t8)
	bne	$t9,NOT_VISITED,rate_choice_else_if
	li	$t2,FALSE
	sb	$t2,($t1)
	j	rate_choice_col_loop_step
rate_choice_else_if:
	bne	$t9,ADJACENT,rate_choice_col_loop_step
	lb	$t2,($t3)
	addi	$t2,$t2,1
	sb	$t2,($t3)
rate_choice_col_loop_step:
	addi	$t6,$t6,1
	j	rate_choice_col_loop_cond
rate_choice_row_loop_step:
	addi	$t4,$t4,1
	j	rate_choice_row_loop_cond
rate_choice_row_loop_end:
	bne	$s1,$zero,rate_choice__epilogue
	li	$t2,FALSE
	sb	$t2,($t1)
rate_choice__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	jr	$ra
########################################################################
## void find_adjacent_cells(struct solver *solver, int row, int col); ##
########################################################################

################################################################################
# .TEXT <find_adjacent_cells>
	.text
find_adjacent_cells:
	# Subset:   3
	#
	# Frame:    [$ra,$s0,$s1,$s2,$s2,$s4,$s5]   <-- FILL THESE OUT!
	# Uses:     [$t1-$t9,$a0,$a1,$a2,$a3]
	# Clobbers: [$a0,$a1,$a2,$a3]
	#
	# Locals:           <-- FILL THIS OUT!
	#   -  $s5 = *solver
	#   -  $s0 = solver->simulated_board[0][0]
	#   -  $s1 = solver->adjacent_to_cell[row][col]
	#   -  $s0 = solver->simulated_board[row][col]
	# Structure:        <-- FILL THIS OUT!
	#   find_adjacent_cells
	#   -> [prologue]
	#       -> body
	#	   -> find_adjacent_cells_else
	#	   -> find_adjacent_cells_loop_initial
	#	   -> find_adjacent_cells_loop_cond
	#	   -> find_adjacent_cells_loop_body
	#	   -> find_adjacent_cells_loop_step
	#   -> [epilogue]

find_adjacent_cells__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
	push	$s4
	push	$s5
find_adjacent_cells__body:
	move	$s5,$a0					# s5 = *solver
	move	$s3,$a1					# s3 = row
	move	$s4,$a2		

	
	
				# s4 = col

	add	$s0,$a0,SIMULATED_BOARD_OFFSET		# s0 = solver->simulated_board[0][0]
	lb	$s3,($s0)				# s3 = fill_region_colour

	mul	$t1,$s3,MAX_BOARD_WIDTH
	add	$t1,$t1,$s4				# t1 = row*MAX_WIDTH + col
	add	$s1,$a0,ADJACENT_TO_CELL_OFFSET
	add	$s1,$s1,$t1				# s1 = solver->adjacent_to_cell[row][col]
	lb	$t2,($s1)
	li	$a0, '^'
	li	$v0, 11
	syscall
	bne	$t2,NOT_VISITED,find_adjacent_cells__epilogue

	add	$s0,$s0,$t1				# s0 = solver->simulated_board[row][col]
	lb	$t2,($s0)

	beq	$t2,$s3,find_adjacent_cells_else
	li	$t3,ADJACENT
	sb	$t3,($s1)
	j	find_adjacent_cells__epilogue
find_adjacent_cells_else:
	li	$t3,VISITED
	sb	$t3,($s1)
find_adjacent_cells_loop_initial:
	li	$t4,0					# t4 = i = 0
find_adjacent_cells_loop_cond:
	bge	$t4,NUM_VISIT_DELTAS,find_adjacent_cells__epilogue
find_adjacent_cells_loop_body:
	la	$s2,visit_deltas
	mul	$t5,$t4,2
	add	$t6,$t5,VISIT_DELTA_ROW
	mul	$t7,$t6,SIZEOF_INT
	add	$t8,$s2,$t7
	lw	$t2,($t8)				# t2 = row_delta
	add	$t6,$t5,VISIT_DELTA_COL
	mul	$t7,$t6,SIZEOF_INT
	add	$t8,$s2,$t7
	lw	$t3,($t8)				# t3 = col_delta

	add	$a0,$s3,$t2
	li	$a1,0
	lw	$t8,board_height
	addi	$a2,$t8,-1
	jal	in_bounds

	beq	$v0,$zero,find_adjacent_cells_loop_step

	add	$a0,$s4,$t3
	li	$a1,0
	lw	$t8,board_width
	addi	$a2,$t8,-1
	jal	in_bounds

	beq	$v0,$zero,find_adjacent_cells_loop_step

	move	$a0,$s5
	add	$a1,$s3,$t2
	add	$a2,$s4,$t3
	jal	find_adjacent_cells
find_adjacent_cells_loop_step:
	addi	$t4,$t4,1
	j	find_adjacent_cells_loop_cond
find_adjacent_cells__epilogue:
	pop	$s5
	pop	$s4
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra
##########################################################################
## void fill(struct fill_in_progress *fill_in_progress,                 ##
##    char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT], int row, int col); ##
##########################################################################

################################################################################
# .TEXT <fill>
	.text
fill:
	# Subset:   3
	#
	# Frame:    [$ra,$s0,$s1,$s2,$s2,$s4]   <-- FILL THESE OUT!
	# Uses:     [$t1-$t8,$a0,$a1,$a2,$a3]
	# Clobbers: [$a0,$a1,$a2,$a3]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $s0 = *fill_in_progress
	#   - $s1 = board[max][max]
	#   - $s4 = fill_in_progress->visited[row][col]
	#   - $t1 = board[row][col]
	#   - $t3 = fill_in_progress->fill_onto
	#   - $t5 = fill_in_progress->fill_with
	#   - $t3 = fill_in_progress->cells_filled
	#
	# Structure:        <-- FILL THIS OUT!
	#   fill
	#   -> [prologue]
	#       -> body
	#	   -> fill_jump_if
	#	   -> fill_loop_initial
	#	   -> fill_loop_cond
	#	   -> fill_loop_body
	#	   -> fill_loop_step
	#   -> [epilogue]
fill__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
	push	$s4
fill__body:
	move	$s0,$a0				# s0 = fill_in_progress
	move	$s1,$a1				# s1 = board[max][max]
	move	$s2,$a2				# s2 = row
	move	$s3,$a3				# s3 = col

	mul	$s3,$s2,MAX_BOARD_WIDTH
	add	$s3,$s3,$s3			# s3 = row*max_width + col
	add	$s4,$s0,VISITED_OFFSET
	add	$s4,$s4,$s3			# s4 = fill_in_progress->visited[row][col]
	lb	$t1,($s4)

	beq	$t1,VISITED,fill__epilogue

	li	$t1,VISITED
	sb	$t1,($S4)

	add	$t1,$s1,$s3			# t1 = board[row][col]
	lb	$t2,($t1)
	add	$t3,$s0,FILL_ONTO_OFFSET	# t3 = fill_in_progress->fill_onto
	lb	$t4,($t3)

	bne	$t2,$t4,fill__epilogue

	add	$t5,$s0,FILL_WITH_OFFSET	# t5 = fill_in_progress->fill_with
	lb	$t6,($t5)
	
	beq	$t2,$t6,fill_jump_if

	add	$t3,$s0,CELLS_FILLED_OFFSET	# t3 = fill_in_progress->cells_filled
	lw	$t4,($t3)
	addi	$t4,$t4,1
	sw	$t4,($t3)			# save new step
fill_jump_if:
	sb	$t6,($t1)
fill_loop_initial:
	li	$s3,0				# s3 = i = 0
fill_loop_cond:
	bge	$s3,NUM_VISIT_DELTAS,fill__epilogue
fill_loop_body:
	la	$t1,visit_deltas		

	mul	$t2,$s3,2
	add	$t3,$t2,VISIT_DELTA_ROW
	mul	$t4,$t3,SIZEOF_INT
	add	$t5,$t1,$t4
	lw	$t6,($t5)			# t6 = row_delta

	add	$t3,$t2,VISIT_DELTA_COL
	mul	$t4,$t3,SIZEOF_INT
	add	$t7,$t1,$t4
	lw	$t8,($t7)			# t8 = col_delta

	add	$a0,$s2,$t6
	li	$a1,0
	lw	$t2,board_height
	addi	$a2,$t2,-1
	jal	in_bounds

	beq	$v0,$zero,fill_loop_step

	add	$a0,$s3,$t8
	li	$a1,0
	lw	$t2,board_width
	addi	$a2,$t2,-1
	jal	in_bounds

	beq	$v0,$zero,fill_loop_step

	move	$a0,$s0
	move	$a1,$s1
	add	$a2,$s2,$t6
	add	$a3,$s3,$t8
	jal	fill
fill_loop_step:
	add	$s3,$s3,1
	j	fill_loop_cond
fill__epilogue:
	pop	$s4
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra

##################################################
## void solve_next_step(struct solver *solver); ##
##################################################

################################################################################
# .TEXT <solve_next_step>
	.text
solve_next_step:
	# Subset:   3
	#
	# Frame:    [$ra,$s0,$s1,$s2]   <-- FILL THESE OUT!
	# Uses:     [$t1-$t9,$a0,$a1,$a2]
	# Clobbers: [$a0,$a1,$a2]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - $t3 = solver->step_rating_for_colour[i].is_eliminated
	#   - $t5 = solver->step_rating_for_colour[i].surface_area
	#   - $t2 = solver->solution_length

	# Structure:        <-- FILL THIS OUT!
	#   solve_next_step
	#   -> [prologue]
	#       -> body
	#	   -> solve_next_step_count_new_area_loop_initial
	#	   -> solve_next_step_count_new_area_loop_cond
	#	   -> solve_next_step_count_new_area_loop_body
	#	   -> solve_next_step_jump_this_if
	#	   -> solve_next_step_count_new_area_loop_step
	#	   -> solve_next_step_count_new_area_loop_end
	#	   -> solve_next_step_see_eliminate_colour_initial
	#	   -> solve_next_step_see_eliminate_colour_cond
	#	   -> solve_next_step_see_eliminate_colour_body
	#	   -> solve_next_step_see_eliminate_colour_step
	#	   -> solve_next_step_choose_largest_area_loop_end
	#   -> [epilogue]
solve_next_step__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
solve_next_step__body:
	move	$s0,$a0					 	# s0 = *solver

	li	$a0, '&'
	li	$v0, 11
	syscall

	addi	$a0,$s0,SIMULATED_BOARD_OFFSET
	addi	$a1,$s0,FUTURE_BOARD_OFFSET
	li	$t0,MAX_BOARD_WIDTH
	mul	$a2,$t0,MAX_BOARD_HEIGHT
	jal	copy_mem

solve_next_step_count_new_area_loop_initial:
	li	$s3,0						# s3 = 0
solve_next_step_count_new_area_loop_cond:
	bge	$s3,NUM_COLOURS,solve_next_step_count_new_area_loop_end
solve_next_step_count_new_area_loop_body:
	addi	$a0,$s0,FUTURE_BOARD_OFFSET
	addi	$a1,$s0,SIMULATED_BOARD_OFFSET
	li	$t1,MAX_BOARD_WIDTH
	mul	$a2,$t1,MAX_BOARD_HEIGHT
	jal	copy_mem

	move	$a0,$s0
	move	$a1,$s3
	jal	invalid_step

	beq	$v0,$zero,solve_next_step_jump_this_if

	addi	$t1,$s0,STEP_RATING_FOR_COLOUR_OFFSET		# solver->step_rating_for_colour
	mul	$t2,$s3,SIZEOF_STEP_RATING
	add	$t1,$t1,$t2					# solver->step_rating_for_colour[i]
	addi	$t3,$t1,IS_ELIMINATED_OFFSET			# t3 = solver->step_rating_for_colour[i].is_eliminated
	li	$t4,FALSE
	sw	$t4,($t3)

	addi	$t5,$t1,SURFACE_AREA_OFFSET			# t5 = solver->step_rating_for_colour[i].surface_area
	li	$t4,-1
	sw	$t4,($t5)
	j	solve_next_step_count_new_area_loop_step
solve_next_step_jump_this_if:
	move	$a0,$s0
	move	$a1,$s3
	jal	simulate_step

	move	$a0,$s0
	jal	initialise_solver_adjacent_cells

	move	$a0,$s0
	li	$a1,0
	li	$a2,0
	jal	find_adjacent_cells

	move	$a0,$s0
	move	$a1,$s3
	jal	rate_choice
solve_next_step_count_new_area_loop_step:
	addi	$s3,$s3,1
	j	solve_next_step_count_new_area_loop_cond
solve_next_step_count_new_area_loop_end:
	addi	$a0,$s0,FUTURE_BOARD_OFFSET
	addi	$a1,$s0,SIMULATED_BOARD_OFFSET
	li	$s3,MAX_BOARD_WIDTH
	mul	$a2,$s3,MAX_BOARD_HEIGHT

	jal	copy_mem
solve_next_step_see_eliminate_colour_initial:
	li	$s3,0						# s3 = i = 0
solve_next_step_see_eliminate_colour_cond:
	bge	$s3,NUM_COLOURS,solve_next_step_see_eliminate_colour_end
solve_next_step_see_eliminate_colour_body:
	addi	$t1,$s0,STEP_RATING_FOR_COLOUR_OFFSET		# solver->step_rating_for_colour
	mul	$t2,$s3,SIZEOF_STEP_RATING
	add	$t1,$t1,$t2					# solver->step_rating_for_colour[i]
	addi	$t3,$t1,IS_ELIMINATED_OFFSET			# t3 = solver->step_rating_for_colour[i].is_eliminated
	lw	$t4,($t3)

	beq	$t4,$zero,solve_next_step_see_eliminate_colour_step

	add	$t1,$s0,OPTIMAL_SOLUTION_OFFSET  #ray			
	add	$t2,$s0,SOLUTION_LENGTH_OFFSET			# t2 = solver->solution_length
	lw	$t3,($t2)					# t3 = length
	add	$t1,$t1,$t3					# t1 = solver->optimal_solution[solver->solution_length]
	la	$t5,colour_selector
	add	$t5,$t5,$s3					# t5 = colour_selector[i]
	lb	$t6,($t5)
	sb	$t6,($t1)

	addi	$t3,$t3,1
	sw	$t3,($t2)
	
	move	$a0,$s0
	move	$a1,$s3
	jal	simulate_step

	add	$a1,$s0,FUTURE_BOARD_OFFSET     ## ray - swapped positions.
	add	$a0,$s0,SIMULATED_BOARD_OFFSET
	li	$t1,MAX_BOARD_WIDTH
	mul	$a2,$t1,MAX_BOARD_HEIGHT
	jal	copy_mem

	j	solve_next_step__epilogue
solve_next_step_see_eliminate_colour_step:
	addi	$s3,$s3,1
	j	solve_next_step_see_eliminate_colour_cond
solve_next_step_see_eliminate_colour_end:
	li	$s1,-1						# best_surface_area = -1;
	li	$s2,-1						# best_solution = -1;
solve_next_step_choose_largest_area_loop_initial:
	li	$s3,0						# s3 = i = 0
solve_next_step_choose_largest_area_loop_cond:
	bge	$s3,NUM_COLOURS,solve_next_step_choose_largest_area_loop_end
solve_next_step_choose_largest_area_loop_body:
	add	$t1,$s0,STEP_RATING_FOR_COLOUR_OFFSET		# solver->step_rating_for_colour
	mul	$t2,$s3,SIZEOF_STEP_RATING
	add	$t1,$t1,$t2					# solver->step_rating_for_colour[i]
	add	$t3,$t1,SURFACE_AREA_OFFSET			# t3 = solver->step_rating_for_colour[i].surface_area
	lw	$t4,($t3)

	ble	$t4,$s1,solve_next_step_choose_largest_area_loop_step
	move	$s2,$s3
	move	$s1,$t4
solve_next_step_choose_largest_area_loop_step:
	addi	$s3,$s3,1
	j	solve_next_step_choose_largest_area_loop_cond
solve_next_step_choose_largest_area_loop_end:
	add	$t1,$s0,OPTIMAL_SOLUTION_OFFSET			
	add	$t2,$s0,SOLUTION_LENGTH_OFFSET			# t2 = solver->solution_length
	lw	$t3,($t2)					# t3 = length
	add	$t1,$t1,$t3					# t1 = solver->optimal_solution[solver->solution_length]
	la	$t5,colour_selector
	add	$t5,$t5,$s2					# t5 = colour_selector[i]
	lb	$t6,($t5)
	sb	$t6,($t1)
	addi	$t3,$t3,1
	sw	$t3,($t2)

	move	$a0,$s0
	move	$a1,$s2
	jal	simulate_step

	add	$a0,$s0,SIMULATED_BOARD_OFFSET
	add	$a1,$s0,FUTURE_BOARD_OFFSET
	li	$s3,MAX_BOARD_WIDTH
	mul	$a2,$s3,MAX_BOARD_HEIGHT
	jal	copy_mem
solve_next_step__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra

#########################################################
## void copy_mem(void *src, void *dst, int num_bytes); ##
#########################################################

################################################################################
# .TEXT <copy_mem>
	.text
copy_mem:
	# Subset:   3
	#
	# Frame:    [$ra,$s0,$s1,$s2]   <-- FILL THESE OUT!
	# Uses:     [$s3,$t1,$t2,$t3,$t4,$a0,$a1,$a2]
	# Clobbers: [ ]
	#
	# Locals:           <-- FILL THIS OUT!
	#      - s0 = *src
	#      - s1 = *dst
	# Structure:        <-- FILL THIS OUT!
	#   copy_mem
	#   -> [prologue]
	#       -> body
	#	   -> copy_mem_one_loop_initial
	#	   -> copy_mem_one_loop_cond
	#	   -> copy_mem_one_loop_body
	#	   -> copy_mem_one_loop_step
	#	   -> copy_mem_one_loop_end
	#	   -> copy_mem_two_loop_intial
	#	   -> copy_mem_two_loop_cond
	#	   -> copy_mem_two_loop_body
	#	   -> copy_mem_two_loop_step
	#   -> [epilogue]

copy_mem__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
copy_mem__body:
	move	$s0,$a0			#  s0 = *src
	move	$s1,$a1			#  s1 = *dst
	move	$s2,$a2			#  s2 = num_bytes
copy_mem_one_loop_initial:
	li	$t3,0			# t3 = i = 0
copy_mem_one_loop_cond:
	li	$s3,SIZEOF_INT
	div	$t4,$s2,$s3
	bge	$t3,$t4,copy_mem_one_loop_end
copy_mem_one_loop_body:
	lw	$t5,($s0)
	sw	$t5,($s1)
	addi	$s0,$s0,SIZEOF_INT
	addi	$s1,$s1,SIZEOF_INT
copy_mem_one_loop_step:
	addi	$t3,$t3,1
	j	copy_mem_one_loop_cond
copy_mem_one_loop_end:
	
copy_mem_two_loop_intial:
	li	$t3,0			# t3 = i = 0
copy_mem_two_loop_cond:
	rem	$t4,$s2,SIZEOF_INT
	bge	$t3,$t4,copy_mem__epilogue
copy_mem_two_loop_body:
	lb	$s3,($s0)		# s3 = *src_char_ptr
	sb	$s3,($s1)
	addi	$s0,$s0,SIZEOF_CHAR
	addi	$s1,$s1,SIZEOF_CHAR
copy_mem_two_loop_step:
	addi	$t3,$t3,1
	j	copy_mem_two_loop_cond
copy_mem__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra
##############
## PROVIDED ##
##############

#######################################################################
## unsigned int random_in_range(unsigned int min, unsigned int max); ##
#######################################################################

################################################################################
# .TEXT <random_in_range>
	.text
random_in_range:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$s3, $t1, $t2, $v0]
	# Clobbers: [$s3, $t1, $t2, $v0]
	#
	# Locals:
	#   - $s3: int a;
	#   - $t1: int m;
	#   - $t2: (a * random_seed) % m
	#   - $v0: min + random_seed % (max - min + 1);
	#
	# Structure:
	#   initialise_solver
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]
random_in_range__prologue:
random_in_range__body:
	li	$s3, 16807		# int a = 16807;
	li	$t1, 2147483647		# int m = 2147483647;
	lw	$t2, random_seed	# ... random_seed
	
	mul	$t2, $t2, $s3		# ... a * random_seed

	remu	$t2, $t2, $t1		# ... (a * random_seed) % m

	sw	$t2, random_seed	# random_seed = (a * random_seed) % m;

	move	$v0, $a1		# ... max
	sub	$v0, $v0, $a0		# ... max - min
	add	$v0, $v0, 1		# ... max - min + 1

	rem	$v0, $t2, $v0		# ... random_seed % (max - min + 1)
	add	$v0, $v0, $a0		# return min + random_seed % (max - min + 1);
random_in_range__epilogue:
	jr	$ra

####################################################
## void initialise_solver(struct solver *solver); ##
####################################################

################################################################################
# .TEXT <initialise_solver>
	.text
initialise_solver:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$a0, $a1, $a2]
	# Clobbers: [$a0, $a1, $a2]
	#
	# Locals:
	#   - $a0: game_board
	#   - $a1: solver->simulated_board
	#   - $a2: MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT
	#
	# Structure:
	#   initialise_solver
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

initialise_solver__prologue:
	push	$ra
initialise_solver__body:
	sw	$zero, SOLUTION_LENGTH_OFFSET($a0)	# solver->solution_length = 0;

	la	$a1, SIMULATED_BOARD_OFFSET($a0)	# copy_mem(game_board, solver->simulated_board, MAX_BOARD_WIDTH * MAX_BOARD_HEIGHT);
	la	$a0, game_board				#
	li	$a2, MAX_BOARD_WIDTH			#
	mul	$a2, $a2, MAX_BOARD_HEIGHT		#
	jal	copy_mem				#

initialise_solver__epilogue:
	pop	$ra
	jr	$ra					# return;

##################################################################
## void simulate_step(struct solver *solver, int colour_index); ##
##################################################################

################################################################################
# .TEXT <simulate_step>
	.text
simulate_step:
	# Subset:   provided
	#
	# Frame:    [$s0]
	# Uses:     [$s0, $a0, $a1, $a2, $a3]
	# Clobbers: [$a0, $a1, $a2, $a3]
	#
	# Locals:
	#   - $s0: save argument struct solver *solver
	#   - $a0: &global_fill_in_progress
	#   - $a1: argument 2
	#   - $a2: 0
	#   - $a3: 0
	#
	# Structure:
	#   simulate_step
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

simulate_step__prologue:
	push	$ra
	push	$s0
	push	$s3
simulate_step__body:
	move	$s0, $a0

	lb	$a2, SIMULATED_BOARD_OFFSET($a0)#
	la	$a0, global_fill_in_progress	# initialise_fill_in_progress(&global_fill_in_progress, 
	lb	$a1, colour_selector($a1)	#     colour_selector[colour_index], solver->simulated_board[0][0]);
	jal	initialise_fill_in_progress	#

	la	$a0, global_fill_in_progress	# fill(&global_fill_in_progress, solver->simulated_board, 0, 0);
	la	$a1, SIMULATED_BOARD_OFFSET($s0)#
	li	$a2, 0				#
	li	$a3, 0				#
	jal	fill				#
simulate_step__epilogue:
	pop	$s3
	pop	$s0
	pop	$ra
	jr	$ra				# return;

###################################################################
## void initialise_solver_adjacent_cells(struct solver *solver); ##
###################################################################

################################################################################
# .TEXT <initialise_solver_adjacent_cells>
	.text
initialise_solver_adjacent_cells:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$s3, $t1, $t2, $t3]
	# Clobbers: []
	#
	# Locals:
	#   - $s3: int row;
	#   - $t1: int col;
	#   - $t2: address calculation & reading globals
	#   - $t3: value storage for sw
	#
	# Structure:
	#   initialise_solver_adjacent_cells
	#   -> [prologue]
	#       -> body
	#       -> row
	#           -> row_init
	#           -> row_cond
	#           -> row_body
	#           -> column
	#               -> column_init
	#               -> column_cond
	#               -> column_body
	#               -> column_step
	#               -> column_end
	#           -> row_step
	#           -> row_end
	#   -> [epilogue]

initialise_solver_adjacent_cells__prologue:
	push	$s3
initialise_solver_adjacent_cells__body:
initialise_solver_adjacent_cells__row_init:
	li	$s3, 0				# int row = 0;
initialise_solver_adjacent_cells__row_cond:
	lw	$t2, board_height		# while (row < board_height) {
	bge	$s3, $t2, initialise_solver_adjacent_cells__row_end
						#
initialise_solver_adjacent_cells__row_body:
initialise_solver_adjacent_cells__column_init:
	li	$t1, 0				#     int col = 0;
initialise_solver_adjacent_cells__column_cond:
	lw	$t2, board_width		#     while (col < board_width) {
	bge	$t1, $t2, initialise_solver_adjacent_cells__column_end
						#
initialise_solver_adjacent_cells__column_body:
	mul	$t2, $s3, MAX_BOARD_WIDTH	#         ... &[row]
	add	$t2, $t2, $t1			#         ... &[row][col]
	add	$t2, $t2, $a0			#         ... &solver[row][col]
	li	$t3, NOT_VISITED		#
	sb	$t3, ADJACENT_TO_CELL_OFFSET($t2)
						#         solver->adjacent_to_cell[row][col] = NOT_VISITED;
initialise_solver_adjacent_cells__column_step:
	add	$t1, $t1, 1			#         col++;
	b	initialise_solver_adjacent_cells__column_cond
						#     }
initialise_solver_adjacent_cells__column_end:
initialise_solver_adjacent_cells__row_step:
	add	$s3, $s3, 1			#     row++;
	b	initialise_solver_adjacent_cells__row_cond
						# }
initialise_solver_adjacent_cells__row_end:

initialise_solver_adjacent_cells__epilogue:
	pop	$s3
	jr	$ra				# return;
######################################################################
## void print_board(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]); ##
######################################################################

################################################################################
# .TEXT <print_board>
	.text
print_board:
	# Subset:   provided
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$s0, $s1, $s3, $a0, $v0]
	# Clobbers: [$s3, $a0, $v0]
	#
	# Locals:
	#   - $s0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $s1: int i;
	#   - $s3: loading globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board
	#   -> [prologue]
	#       -> body
	#       -> row
	#           -> row_init
	#           -> row_cond
	#           -> row_body
	#           -> row_step
	#           -> row_end
	#   -> [epilogue]

print_board__prologue:
	push	$ra
	push	$s0
	push	$s1
print_board__body:
	move	$s0, $a0
print_board__print_row_init:
	li	$s1, 0				# int i = 0;
print_board__print_row_cond:
	lw	$s3, board_height		# while (i < board_height) {
	bge	$s1, $s3, print_board__print_row_end
						#
print_board__print_row_body:
	move	$a0, $s0			#     print_board_row(board, i);
	move	$a1, $s1			#
	jal	print_board_row			#
print_board__print_row_step:
	add	$s1, $s1, 1			#     i++;
	b	print_board__print_row_cond	# }
print_board__print_row_end:
	jal	print_board_seperator_line	# print_board_seperator_line();
	jal	print_board_bottom		# print_board_bottom();

	lw	$a0, steps			# printf("%d", steps);
	li	$v0, 1				#
	syscall					#

	li	$a0, '/'			# putchar('/');
	li	$v0, 11				#
	syscall					#

	lw	$a0, optimal_steps		# printf("%d", optimal_steps + EXTRA_STEPS);
	add	$a0, $a0, EXTRA_STEPS		#
	li	$v0, 1				#
	syscall					#

	la	$a0, str_print_board_steps	# printf(" steps\n);
	li	$v0, 4				#
	syscall					#
print_board__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra				# return;

################################
## void print_board_bottom(); ##
################################

################################################################################
# .TEXT <print_board_bottom>
	.text
print_board_bottom:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$s3, $t1, $t2, $t3, $a0, $v0]
	# Clobbers: [$s3, $t1, $t2, $t3, $a0, $v0]
	#
	# Locals:
	#   - $s3: int i;
	#   - $t1: int j;
	#   - $t2: int k;
	#   - $t3: arithmetic & loading globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board_bottom
	#   -> [prologue]
	#       -> body
	#       -> down
	#           -> down_init
	#           -> down_cond
	#           -> down_body
	#           -> down_step
	#           -> down_end
	#           -> across
	#               -> across_init
	#               -> across_cond
	#               -> across_body
	#               -> not_selected
	#                   -> not_selected_init
	#                   -> not_selected_cond
	#                   -> not_selected_body
	#                   -> not_selected_step
	#                   -> not_selected_end
	#               -> selected
	#                   -> selected1
	#                       -> selected1_init
	#                       -> selected1_cond
	#                       -> selected1_body
	#                       -> selected1_step
	#                       -> selected1_end
	#                   -> i
	#                       -> i_nonzero
	#                       -> i_end
	#                   -> selected2
	#                       -> selected2_init
	#                       -> selected2_cond
	#                       -> selected2_body
	#                       -> selected2_step
	#                       -> selected2_end
	#               -> across_step
	#               -> across_end
	#   -> [epilogue]

print_board_bottom__prologue:
print_board_bottom__body:
print_board_bottom__down_init:
	li	$s3, 0				# int i = 0;
print_board_bottom__down_cond:
	bge	$s3, SELECTED_ARROW_VERTICAL_LENGTH + 1, print_board_bottom__down_end
						# while (i < SELECTED_ARROW_VERTICAL_LENGTH + 1) {
print_board_bottom__down_body:
	li	$v0, 11				#     putchar(BOARD_SPACE_SEPERATOR);
	li	$a0, BOARD_SPACE_SEPERATOR	#
	syscall					#
print_board_bottom__across_init:
	li	$t1, 0				#     int j = 0;
print_board_bottom__across_cond:
	lw	$t3, board_width		#     while (j < board_width) {
	bge	$t1, $t3, print_board_bottom__across_end
						#
print_board_bottom__across_body:

	lw	$t3, selected_column		#         if (j != selected_column) {
	beq	$t1, $t3, print_board_bottom__across_selected
						#

print_board_bottom__not_selected_init:
	li	$t2, 0				#             int k = 0;
print_board_bottom__not_selected_cond:
	bge	$t2, BOARD_CELL_SIZE + 3, print_board_bottom__not_selected_end
						#             while (k < BOARD_CELL_SIZE + 3) {
print_board_bottom__not_selected_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#
print_board_bottom__not_selected_step:
	add	$t2, $t2, 1			#                 k++;
	b	print_board_bottom__not_selected_cond
						#             }
print_board_bottom__not_selected_end:
	b	print_board_bottom__across_step	#         } else {
print_board_bottom__across_selected:
print_board_bottom__across_selected1_init:
	li	$t2, 0				#             int k = 0;
print_board_bottom__across_selected1_cond:
	li	$t3, BOARD_CELL_SIZE + 1	#             while (k < (BOARD_CELL_SIZE + 1) / 2) {
	div	$t3, $t3, 2			#
	bge	$t2, $t3, print_board_bottom__across_selected1_end
						#
print_board_bottom__across_selected1_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#
print_board_bottom__across_selected1_step:
	add	$t2, $t2, 1			#                 k++;
	b	print_board_bottom__across_selected1_cond
						#             }
print_board_bottom__across_selected1_end:

	bnez	$s3, print_board_bottom__across_i_nonzero
						#             if (i == 0) {

	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	b	print_board_bottom__across_i_end
						#             } else {
print_board_bottom__across_i_nonzero:

	sub	$a0, $s3, 1			#                 putchar(selected_arrow_vertical[i - 1]);
	lb	$a0, selected_arrow_vertical($a0)
						#
	li	$v0, 11				#
	syscall					#

print_board_bottom__across_i_end:		#             }

print_board_bottom__across_selected2_init:
	li	$t2, 0				#             k = 0;
print_board_bottom__across_selected2_cond:
	li	$t3, BOARD_CELL_SIZE + 1	#             while (k < ((BOARD_CELL_SIZE + 1) / 2)) {
	div	$t3, $t3, 2			#
	bge	$t2, $t3, print_board_bottom__across_selected2_end
						#
print_board_bottom__across_selected2_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#                 putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_bottom__across_selected2_step:
	add	$t2, $t2, 1			#                 k++;
	b	print_board_bottom__across_selected2_cond
						#             }
print_board_bottom__across_selected2_end:

print_board_bottom__across_step:
	add	$t1, $t1, 1			#         j++;
	b	print_board_bottom__across_cond	#     }
print_board_bottom__across_end:

	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	li	$a0, '\n'			#     putchar('\n');
	syscall					#

print_board_bottom__down_step:
	add	$s3, $s3, 1			#     i++;
	b	print_board_bottom__down_cond	# }
print_board_bottom__down_end:
print_board_bottom__epilogue:
	jr	$ra				# return;

#########################################################################
## void print_board_row(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT], ##
##     int row);                                                       ##
#########################################################################

################################################################################
# .TEXT <print_board_row>
	.text
print_board_row:
	# Subset:   provided
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$s0, $s1, $s2, $s3, $t1, $a0, $a1, $a2]
	# Clobbers: [$s3, $t1, $a0, $a1, $a2]
	#
	# Locals:
	#   - $s0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $s1: int row
	#   - $s2: int i
	#   - $s3: i == BOARD_CELL_SIZE / 2
	#   - $t1: row == selected_row
	#   - $a0: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $a1: int row
	#   - $a2: i == BOARD_CELL_SIZE / 2 && row == selected_row
	#
	# Structure:
	#   print_board_row
	#   -> [prologue]
	#       -> body
	#       -> each_row
	#           -> each_row_init
	#           -> each_row_cond
	#           -> each_row_body
	#           -> each_row_step
	#           -> each_row_end
	#   -> [epilogue]

print_board_row__prologue:
	push	$ra
	push	$s0
	push	$s1
	push	$s2
print_board_row__body:
	move	$s0, $a0
	move	$s1, $a1

	jal	print_board_seperator_line	# print_board_seperator_line();

print_board_row__each_row_init:
	li	$s2, 0				# int i = 0;
print_board_row__each_row_cond:
	bge	$s2, BOARD_CELL_SIZE, print_board_row__each_row_end
						# while (i < BOARD_CELL_SIZE) {
print_board_row__each_row_body:
	move	$a0, $s0			#
	move	$a1, $s1			#

	li	$s3, BOARD_CELL_SIZE		#
	div	$s3, $s3, 2			#
	seq	$s3, $s3, $s2			# ... i == BOARD_CELL_SIZE / 2

	lw	$t1, selected_row		#
	seq	$t1, $s1, $t1			# ... row == selected_row
	and 	$a2, $s3, $t1			# ... i == BOARD_CELL_SIZE / 2 && row == selected_row

	jal	print_board_inner_line		# print_board_inner_line(board, row, i == BOARD_CELL_SIZE / 2 && row == selected_row);
print_board_row__each_row_step:
	add	$s2, $s2, 1			#     i++;
	b	print_board_row__each_row_cond	# }
print_board_row__each_row_end:

print_board_row__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	jr	$ra				# return;

################################################################################
## void print_board_inner_line(char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT], ##
##     int row, int row_is_selected);                                         ##
################################################################################

################################################################################
# .TEXT <print_board_inner_line>
	.text
print_board_inner_line:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$s3, $t1, $t2, $t3, $a0, $v0]
	# Clobbers: [$s3, $t1, $t2, $t3, $a0, $v0]
	#
	# Locals:
	#   - $s3: char board[MAX_BOARD_WIDTH][MAX_BOARD_HEIGHT]
	#   - $t1: int i;
	#   - $t2: int j;
	#   - $t3: loading globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board_inner_line
	#   -> [prologue]
	#       -> body
	#       -> cells
	#           -> cells_init
	#           -> cells_cond
	#           -> cells_body
	#           -> inner_cell
	#               -> inner_cell_init
	#               -> inner_cell_cond
	#               -> inner_cell_body
	#               -> inner_cell_step
	#               -> inner_cell_end
	#           -> cells_step
	#           -> cells_end
	#   -> [epilogue]

print_board_inner_line__prologue:
print_board_inner_line__body:
	move	$s3, $a0

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_inner_line__cells_init:
	li	$t1, 0				# int i = 0;
print_board_inner_line__cells_cond:
	lw	$t3, board_width		# while (i < board_width) {
	bge	$t1, $t3, print_board_inner_line__cells_end
						#
print_board_inner_line__cells_body:
	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_inner_line__inner_cell_init:
	li	$t2, 0				#     int j = 0;
print_board_inner_line__inner_cell_cond:
	bge	$t2, BOARD_CELL_SIZE, print_board_inner_line__inner_cell_end
						#     while (j < BOARD_CELL_SIZE) {
print_board_inner_line__inner_cell_body:
	mul	$a0, $a1, MAX_BOARD_WIDTH	#         ... &[row]
	add	$a0, $a0, $s3			#         ... &board[row]
	add	$a0, $a0, $t1			#         ... &board[row][col]
	lb	$a0, ($a0)			#         putchar(board[row][i]);
	li	$v0, 11				#
	syscall
print_board_inner_line__inner_cell_step:
	add	$t2, $t2, 1			#         j++;
	b	print_board_inner_line__inner_cell_cond
						#     }
print_board_inner_line__inner_cell_end:

	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	lw	$t3, board_width		#     if (i != board_width - 1) {
	sub	$t3, $t3, 1			#
	beq	$t1, $t3, print_board_inner_line__cells_step
						#

	li	$a0, BOARD_CELL_SEPERATOR	#         putchar(BOARD_CELL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_inner_line__cells_step:		#     }
	add	$t1, $t1, 1			#     i++;
	b	print_board_inner_line__cells_cond
						# }
print_board_inner_line__cells_end:

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	beqz	$a2, print_board_inner_line__last_newline
						# if (row_is_selected) {

	li	$a0, BOARD_SPACE_SEPERATOR	#     putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	la	$a0, selected_arrow_horizontal	#     printf("%s", selected_arrow_horizontal);
	li	$v0, 4				#
	syscall					#

print_board_inner_line__last_newline:		# }
	li	$a0, '\n'			#
	li	$v0, 11				#
	syscall					#
print_board_inner_line__epilogue:
	jr	$ra				# return;

########################################
## void print_board_seperator_line(); ##
########################################

################################################################################
# .TEXT <print_board_seperator_line>
	.text
print_board_seperator_line:
	# Subset:   provided
	#
	# Frame:    []
	# Uses:     [$s3, $t1, $t2, $a0, $v0]
	# Clobbers: [$s3, $t1, $t2, $a0, $v0]
	#
	# Locals:
	#   - $s3: int i;
	#   - $t1: int j;
	#   - $t2: globals
	#   - $a0: syscall argument 
	#   - $v0: syscall number
	#
	# Structure:
	#   print_board_seperator_line
	#   -> [prologue]
	#       -> body
	#       -> line
	#           -> line_init
	#           -> line_cond
	#           -> line_body
	#           -> line_step
	#           -> line_end
	#           -> inner_line
	#               -> inner_line_init
	#               -> inner_line_cond
	#               -> inner_line_body
	#               -> inner_line_step
	#               -> inner_line_end
	#   -> [epilogue]

print_board_seperator_line__prologue:
print_board_seperator_line__body:
	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_seperator_line__line_init:
	li	$s3, 0				# int i = 0;
print_board_seperator_line__line_cond:
	lw	$t2, board_width		#
	bge	$s3, $t2, print_board_seperator_line__line_end
						# while (i < board_width) {
print_board_seperator_line__line_body:

print_board_seperator_line__inner_line_init:
	li	$t1, 0				#     int j = 0;
print_board_seperator_line__inner_line_cond:
	bge	$t1, BOARD_CELL_SIZE + 2, print_board_seperator_line__inner_line_end
						#     while (j < BOARD_CELL_SIZE + 2) {
print_board_seperator_line__inner_line_body:
	li	$a0, BOARD_HORIZONTAL_SEPERATOR	#         putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#
print_board_seperator_line__inner_line_step:
	add	$t1, $t1, 1			#         j++;
	b	print_board_seperator_line__inner_line_cond
						#     }
print_board_seperator_line__inner_line_end:
	lw	$t2, board_width		#     if (i != board_width - 1) {
	sub	$t2, $t2, 1			#
	beq	$t2, $s3, print_board_seperator_line__line_step
						#

	li	$a0, BOARD_CROSS_SEPERATOR	#         putchar(BOARD_CROSS_SEPERATOR);
	li	$v0, 11				#
	syscall					#

print_board_seperator_line__line_step:		#     }
	add	$s3, $s3, 1			#     i++;
	b	print_board_seperator_line__line_cond
						# }
print_board_seperator_line__line_end:

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11				#
	syscall					#

	li	$a0, '\n'			# putchar('\n');
	syscall					#

print_board_seperator_line__epilogue:
	jr	$ra				# return;

#############################
## void process_command(); ##
#############################

################################################################################
# .TEXT <process_command>
	.text
process_command:
	# Subset:   provided
	#
	# Frame:    [$ra]
	# Uses:     [$s3, $t1, $a0, $v0]
	# Clobbers: [$s3, $t1, $a0, $v0]
	#
	# Locals:
	#   - $s3: char command;
	#   - $t1: globals
	#   - $a0: syscall argument
	#   - $v0: syscall number
	#
	# Structure:
	#   process_command
	#   -> [prologue]
	#       -> body
	#       -> good_parsing
	#           -> good_parsing_cond
	#           -> good_parsing_end
	#       -> up
	#           -> up
	#           -> up_in_bounds
	#       -> down
	#           -> down
	#           -> down_in_bounds
	#       -> right
	#           -> right
	#           -> right_in_bounds
	#       -> left
	#           -> left
	#           -> left_in_bounds
	#       -> quit
	#       -> fill
	#       -> help
	#       -> cheat
	#       -> unknown
	#       -> end_switch
	#   -> [epilogue]

process_command__prologue:
	push	$ra
process_command__body:
	la	$a0, cmd_waiting
	li	$v0, 4
	syscall

	li	$v0, 12
	syscall
	move	$s3, $v0
process_command__good_parsing_cond:
	bne	$s3, '\n', process_command__good_parsing_end
	li	$v0, 12
	syscall
	move	$s3, $v0
	b	process_command__good_parsing_cond
process_command__good_parsing_end:
	beq	$s3, 'w', process_command__up		# switch (command) {
	beq	$s3, 's', process_command__down		#
	beq	$s3, 'd', process_command__right	#
	beq	$s3, 'a', process_command__left		#
	beq	$s3, 'q', process_command__quit		#
	beq	$s3, 'e', process_command__fill		#
	beq	$s3, 'h', process_command__help		#
	beq	$s3, 'c', process_command__cheat	#
	b	process_command__unknown		#
process_command__up:					#     case 'w':
	lw	$s3, selected_row			#         selected_row = MAX(selected_row - 1, 0);
	sub	$s3, $s3, 1				#
	bge	$s3, 0, process_command__up_in_bounds	#
	li	$s3, 0					#
process_command__up_in_bounds:
	sw	$s3, selected_row			#
	b	process_command__end_switch		#         break;
process_command__down:					#     case 's':
	lw	$s3, selected_row			#         selected_row = MIN(selected_row + 1, board_height - 1);
	add	$s3, $s3, 1				#
	lw	$t1, board_height			#
	sub	$t1, $t1, 1				#
	ble	$s3, $t1, process_command__down_in_bounds
							#
	move	$s3, $t1				#
process_command__down_in_bounds:			#
	sw	$s3, selected_row			#
	b	process_command__end_switch		#         break;
process_command__right:					#     case 'd':
	lw	$s3, selected_column			#         selected_column = MIN(selected_column + 1, board_width - 1)
	add	$s3, $s3, 1				#
	lw	$t1, board_width			#
	sub	$t1, $t1, 1				#
	ble	$s3, $t1, process_command__right_in_bounds
							#
	move	$s3, $t1				#
process_command__right_in_bounds:			#
	sw	$s3, selected_column			#
	b	process_command__end_switch		#         break;
process_command__left:					#     case 'a':
	lw	$s3, selected_column			#         selected_column = MAX(selected_column - 1, 0);
	sub	$s3, $s3, 1				#
	bge	$s3, 0, process_command__left_in_bounds	#
	li	$s3, 0					#
process_command__left_in_bounds:			#
	sw	$s3, selected_column			#
	b	process_command__end_switch		#         break;
process_command__quit:					#     case 'q':
	li	$v0, 10					#         exit(0);
	syscall						#
process_command__fill:					#     case 'e':
	jal	do_fill					#         do_fill();
	b	process_command__end_switch		#         break;
process_command__help:					#     case 'h':
	jal	print_welcome				#         print_welcome();
	b	process_command__epilogue		#         return;
process_command__cheat:					#     case 'c':
	jal	print_optimal_solution			#         print_optimal_solution();
	b	process_command__epilogue		#         return;
process_command__unknown:				#     default:
	la	$a0, str_process_command_unknown	#         printf("Unknown command: ");
	li	$v0, 4					#
	syscall						#

	move	$a0, $s3				#         putchar(command);
	li	$v0, 11					#
	syscall						#

	li	$a0, '\n'				#         putchar('\n')
	syscall						#
	b	process_command__epilogue		#         return;
process_command__end_switch:				# }

	la	$a0, game_board
	jal	print_board				# print_board(game_board);

process_command__epilogue:
	pop	$ra
	jr	$ra					# return;
