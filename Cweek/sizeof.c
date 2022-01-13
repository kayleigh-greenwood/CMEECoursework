# include <stdio.h>

int main (void)
{
    
    unsigned long x = sizeof(float);

    printf("The size of float is %lu\n", x);

    unsigned long y = sizeof(double);

    printf("The size of double is %lu\n", y);

    unsigned long z = sizeof(long double);

    printf("The size of long double is %lu\n", z);
    

    unsigned long a = sizeof(long);

    printf("The size of long is %lu\n", a);


    unsigned long c = sizeof(char);

    printf("The size of char is %lu\n", c);


    unsigned long d = sizeof(short);

    printf("The size of short is %lu\n", d);

    return 0;   // Everything went OK. Return 0 to the OS

}