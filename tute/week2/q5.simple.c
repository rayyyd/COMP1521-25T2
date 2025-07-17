#define SQUARE_MAX 46340

int main(void) {
    int x, y;

    printf("Enter a number: ");
    scanf("%d", &x);

    if (x <= SQUARE_MAX) goto main__else;
    //inside of if statement
    printf("square too big for 32 bits\n");
    goto main__epilogue;
main__else:
    y = x * x;
    printf("%d\n", y);
main__epilogue:
    return 0;
}