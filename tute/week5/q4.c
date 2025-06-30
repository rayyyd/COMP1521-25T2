#include <stdio.h>
#include <stdint.h>

int six_middle_bits(uint32_t num) {
    // make a mask -> mask is just which bits we are interested in.
    uint32_t mask = 0b111111 << 13;    // we are interested in 6 bits in the middle
                                        // so our mask is 6 bits long, and in the middle.
    // perform the relevant operation
    uint32_t result = mask & num;
    // 0b 0001010101001 101101 0110100100100
    // 0b 0000000000000 111111 0000000000000     << mask, 1 bits where we are interested.
    // --------------------------------------    &
    // 0b 0000000000000 101101 0000000000000
    // shift it back
    result = result >> 13;
    return result;
}

int main() {
    uint32_t number = 0b00010101010011011010110100100100;
    // if our program is working, then it should print out "101101"
    printf("%b\n", six_middle_bits(number));
    return 0;
}