#include <stdio.h>

// swap the alphabets first 13 and last 13
int main() {
    FILE *fp = fopen("alphabets.txt", "r");
    if (fp == NULL) {
        perror("alphabetz.txt");
        exit(1);
    }
    char buffer_front[13];
    char buffer_back[13];

    //do back one first
    //need to start at position 13 (middle)
    int c;
    if (fseek(fp, 13, SEEK_SET) != 0) {
        fprintf(stderr, "failed to fseek");
    }
    
    // do our operation -> read the back 13
    for (int i = 0; i < 13; i++) {
        buffer_front[i] = fgetc(fp);
        if (buffer_front[i] == EOF) {
            fprintf(stderr, "failed fgetc");
            exit(1);
        }
    }
    //fp is now at the back of the file

    //do the front one
    fseek(fp, 0, SEEK_SET);
    fread(buffer_back, 1, 13, fp);
    fclose(fp);

    //write the reverse order back in

    FILE *fp2 = fopen("alphabets.txt", "w");
    fwrite(buffer_front, 1, 13, fp2);
    fwrite(buffer_back, 1, 13, fp2);
    fclose(fp2);



    return 0;
}