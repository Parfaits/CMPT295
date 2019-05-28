
#include <stdio.h>

unsigned times(unsigned, unsigned);

void main () {
    unsigned a = 5;
    unsigned b = 10;
    printf("The product of %u and %u is %u.\n", a, b, times(a,b));
    return;
}

