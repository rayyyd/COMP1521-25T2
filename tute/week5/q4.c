#include <stdio.h>
#include <stdint.h>

int six_middle_bits(uint32_t num) {
    // make a mask -> 1's in the bits that we are interested in.
    // 0b 0000000000000 111111 0000000000000
    uint32_t mask = 0b111111 << 13;
    // perform the operation
    uint32_t result = num & mask;         //and is "read/copy" operation.
    // 0b 0001010101001 101101 0110100100100    num
    // 0b 0000000000000 111111 0000000000000    mask
    //---------------------------------------- &
    // 0b 0000000000000 101101 0000000000000
    // shift if required.
    result = result >> 13;
    return result;

}

int main() {
    uint32_t number = 0b00010101010011011010110100100100;
    // if our program is working, then it should print out "101101"
    printf("0b%b\n", six_middle_bits(number));
    return 0;
}