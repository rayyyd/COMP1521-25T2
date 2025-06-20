    .data
# 0x10010020	a:  .word   42   # 4 bytes, value = 42.
# 0x10010024	b:  .space  4    # 4 bytes, unitialized. 
# 0x10010024	c:  .asciiz "abcde"   #'a', 'b', 'c', 'd', 'e', \0'
		.align  2      # next label (d) -> must be 2^2 aligned

# 0x1001002C	d:  .byte   1, 2, 3, 4    # 4x1 bytes long, value = 1,2,3,4

# 0x10010030	e:  .word   1, 2, 3, 4    # word requires its address to be 4-aligned!!
#		4 x 4 long = 16, value = 1,2,3,4
		f:  .space  1       # 1 byte, unitialized.