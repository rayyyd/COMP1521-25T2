#include <stdio.h>

int main() {
    FILE *fp = fopen("alphabets.txt", "r");
    char buffer1[13];
    char buffer2[13];
    fread(buffer1, 1, 13, fp);
    fread(buffer2, 1, 13, fp);
    fclose(fp);
    FILE *fp_w = fopen("alphabets.txt", "w");
    fwrite(buffer2, 1, 13, fp_w);
    fwrite(buffer1, 1, 13, fp_w);
    fclose(fp_w);
    return 0;
}