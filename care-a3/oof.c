
#include <stdio.h>

char conv(char *, char *, int);
// char conv(char *x, char *h, int n);

#define N 2
#define M 2

char signal[N] = { 1, 1 };

char h[M] = { 1, 1 };

int main(int argc, char const *argv[])
{
	int i;

    puts("Original signal:  ");
    for (i = 0; i < N; i++) {
        printf("%4d", signal[i]);
    }
    putchar('\n');

    puts("Convolved signal: ");
    printf("%4d", conv(signal, h, N));
    putchar('\n');
	return 0;
}