	.text
# code goes here!!

# #include <stdio.h>


# int main(void) {
main:
#     int x, y;
# $t0 = x
# $t1 = y



#     printf("Enter a number: ");
li	$v0, 4    #load integer
la	$a0, string
syscall
#     scanf("%d", &x);
li	$v0, 5
syscall
move	$t0, $v0

#     y = x * x;
mul	$t1, $t0, $t0


#     printf("%d\n", y);
li	$v0, 1
move	$a0, $t1     #we put y into a0.
syscall

li	$v0, 11
li	$a0, '\n'
syscall

li	$v0, 0
jr	$ra
#     return 0;
# }




	.data
#global and strin gliterals
string:
	.asciiz "Enter a number: "