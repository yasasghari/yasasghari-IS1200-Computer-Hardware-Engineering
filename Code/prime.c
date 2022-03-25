/*
   prime.c
   By David Broman.
   Last modified: 2020-01-30
   This file is in the public domain.
   Changed by A Hammarstrand
 */


#include <stdio.h>

int is_prime(int n){
    if (n == 2) return 1;

    if (n == 0 || n == 1 || n % 2 == 0)  return 0;     

    for (int i = 3; i*i <= n; i += 2)
        if (n % i == 0) return 0;
    
    return 1;
}

int main(void){
    printf("%d\n", is_prime(11));  // 11 is a prime.      Should print 1.
    printf("%d\n", is_prime(383)); // 383 is a prime.     Should print 1.
    printf("%d\n", is_prime(987)); // 987 is not a prime. Should print 0.
}
