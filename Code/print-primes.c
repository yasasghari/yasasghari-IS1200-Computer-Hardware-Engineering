/*
 print-prime.c
 By David Broman.
 Last modified: 2019-02-01
 Modified by: A Hammarstrand
 This file is in the public domain.
*/


#include <stdio.h>
#include <stdlib.h>

#define COLUMNS 6
int col = 0;

void print_number(int n) {
    printf("%10d ", n);

    if (!(col = ++col % COLUMNS))
        printf("\n");
}

int is_prime(int n){
    if (n == 2) return 1;

    if (n == 0 || n == 1 || n % 2 == 0)  return 0;     

    for (int i = 3; i*i <= n; i += 2)
        if (n % i == 0) return 0;
    
    return 1;
}

void print_primes(int n){
  // Should print out all prime numbers less than 'n'
  // with the following formatting. Note that
  // the number of columns is stated in the define
  // COLUMNS
    
    for (int i = 2; i <= n; i++)
        if (is_prime(i))
            print_number(i);
    printf("\n");
}

// 'argc' contains the number of program arguments, and
// 'argv' is an array of char pointers, where each
// char pointer points to a null-terminated string.
int main(int argc, char *argv[]){
  if(argc == 2)
    print_primes(atoi(argv[1]));
  else
    printf("Please state an interger number.\n");
  return 0;
}

 
