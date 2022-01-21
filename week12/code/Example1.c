# include <stdio.h>

int main(void)
{
    int a = 7;
    int b = 2;
    int c = 0;
    float d = 0;

    c = a / b;
    d = a / b;

    printf("The result of %i/%i: %i\n", a, b, c);
    printf("The result of %i/%i: %f\n", a, b, d);


    return 0;
}


