# include <stdio.h>

// int myints[3]; : integer array of length 3. Ints are 4 bytes, so 12 bytes of memory have been reserved total [4] [4] [4]

int main(void)
{
    int i; // initilise integer
    char chars[256]; // declare character array of 256 chars (1 byte per char)
    unsigned long longs[2]; // declares array that is 2 'longs' wide (amount of bytes in long depends on computer but is typically 8)

    longs[0] = 0UL; // set the first element/long in longs to all zeros
    longs[1] = ~0UL; // set second element/long in longs to all 1's (inverse of 0)

    memcpy(chars, longs, sizeof(unsigned long)*2) 
    // copies information INTO chars, FROM longs, of size = double length of an unsigned long 

    // chars and long are now identical byte for byte up to equivalent of second element of long.
    // chars is bigger so there is other stuff after, can ignore that
    // difference is in the way the program will read chars and long
    // longs is read (usually) 8 bytes at a time, longs[x] = 8 bytes
    // chars is read 1 byte at a time, chars[x] = 1 byte
    // safe to write char into long but converse is not safe

    i = 0; // set integer i to 0
    while (chars[i] == 0) {
        ++i;
    } // will loop as long as the byte contains 0
    // in this case will stop at chars[8]

    printf("The value of i: %i\n", i);
    printf("The size of unsigned long: %lu\n", sizeof(unsigned long));


    return 0;

}
