#include <stdio.h>
#include <stdint.h>

int reverseBits(uint32_t num) {
    // reverse the bits of num.
    // loop through the bits of the number
    uint32_t result = 0;
    for (int i = 0; i < 32; i++) {
       
        uint32_t read_mask = 1u << i;   //size of mask we want
        uint32_t write_mask = (1u << 31) >> i;

        // get the relevant bit -> read operation
        uint32_t read = (num & read_mask) ; // either 0, or non-zero
        // write it into a new number at the reverse position.
        if (read != 0) {
            result |= write_mask;     // | -> write operation.
        }


    }
    return result;


}

int main() {
    uint32_t w = 0x01234567;
    printf("0x%x\n", reverseBits(w));
}