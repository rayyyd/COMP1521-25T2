#include <stdio.h>
#include <sys/stat.h>

//  Print out the file size and permissions of alphabets.txt
int main() {
    //get stats
    struct stat s;
    stat("alphabets.txt", &s);

    // print file size
    printf("size: %ld\n", s.st_size);

    //  get permissions
    mode_t perms = s.st_mode;
    //print permissions
    if (S_ISDIR(perms)) {
        printf("d");
    } else {
        printf("-");
    }

    if (S_IRUSR & perms) {
        printf("r");
    } else {
        printf("-");
    }

    (S_IWUSR & perms) ? printf("w") : printf("-");
    (S_IXUSR & perms) ? printf("x") : printf("-");

    (S_IRGRP & perms) ? printf("r") : printf("-");
    (S_IWGRP & perms) ? printf("w") : printf("-");
    (S_IXGRP & perms) ? printf("x") : printf("-");

    (S_IROTH & perms) ? printf("r") : printf("-");
    (S_IWOTH & perms) ? printf("w") : printf("-");
    (S_IXOTH & perms) ? printf("x") : printf("-");
    printf("\n");

    return 0;
}