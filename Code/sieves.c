// Written by A Hammarstrand
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define COLUMNS 6
int col = 0;

void print_number(int n) {
    printf("%10d ", n);

    if (!(col = ++col % COLUMNS))
        printf("\n");
}


void print_sieves(int n){
    char primes[n]; 
    for (int i = 0; i < n; i++)
        primes[i] = 0;
 
  
    int roof = (int)sqrt((double)n);

    for (int i = 2; i <= roof; i++){
        if (!primes[i - 1]){
            for (int j = i*i; j <= n; j += i){
                primes[j - 1] = (char)1;
            }
        }
    }

    for (int i = 1; i < n; i++)
        if (!primes[i])
            print_number(i + 1);
    printf("\n");
}

// 'argc' contains the number of program arguments, and
// 'argv' is an array of char pointers, where each
// char pointer points to a null-terminated string.
int main(int argc, char *argv[]){
  if(argc == 2)
    print_sieves(atoi(argv[1]));
  else
    printf("Please state an interger number.\n");
  return 0;
}
