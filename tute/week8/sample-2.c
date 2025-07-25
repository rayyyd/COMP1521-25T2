#include <stdio.h>
#include <sys/stat.h>

int main() {
    // FILE *fp = fopen("alphabets.txt", "r");
    struct stat s;
    stat("alphabets.txt", &s);
    printf("%ld\n", s.st_size);

    mode_t mode = s.st_mode;
    if (S_ISDIR(mode)) {
        printf("d");
    } else {
        printf("-");
    }

    if (mode & S_IRUSR) {
        printf("r");
    } else {
        printf("-");
    }

    (mode & S_IWUSR) ? printf("w") : printf("-");
    (mode & S_IXUSR) ? printf("x") : printf("-");
    printf("\n");
    return 0;
}