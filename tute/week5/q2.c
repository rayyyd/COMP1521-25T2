convert the betlow into binary, octal and hex.

0b1111 -> binary
0x1111 -> hex    -> 0b 0001 0001 0001 0001 (binary form)
0o1111  -> octal
1111   -> decimal

0      -> octal
// convert decimal -> binary -> octal/hex


g)127

128 is a power of 2, 2^7
127 = 128 - 1

1000 0000 - 1 = 0111 1111
   ^                ^
   128             127
0b 0111 1111
0x   7    F
0x7F

0b 01 111 111
0   1  7   7
0177


h) 200
200 = 128 + 64 + 8
    =  2^7 + 2^6 + 2^3

    0b 1100 1000
      7654 3210

    0x  C   8
    0xC8
    
    0b  11 001 000
    0    3   1   0


a) 1
//decompose into powers of 2
1 = 2^0
//put it into the 1's position

0b 0000 0001
   7654 3210
0b1
//hex -> convert binary to hex by splitting into groups of 4, then counting em up.
0b 0000 0001
0x   0    1
0x1
0x01
//oct -> convert binary to oct by splitting into groups of 3, then counting em up.
0b 00 000 001
0   0   0   1
01

d) 15
15 -> 8 + 4 + 2 + 1
    = 2^3 + 2^2 + 2^1 + 2^0

0b 0000 1111
   7654 3210

0b 0000 1111           //  1111 -> 1 + 2 = 4 + 8 = 15
     0    F            /// 0123456789 A  B  C  D  E  F
                       //             10,11,12,13,14,15
0xF

0b 00 001 111
0   0   1   7
017
