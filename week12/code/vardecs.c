# include <stdio.h>

int main(void)
{
    // breaks int x = 3000000000;
    int x = 200000000;

    char y;
    float z;
    double a;

    printf("The value of x: %i\n", x);
    printf("The value of y: %c\n", y);
    printf("The value of z: %f\n", z);
    printf("The value of a: %e\n", a);


    return x;
}
