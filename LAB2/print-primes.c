/*
 print-prime.c
 By David Broman.
 Last modified: 2015-09-15
 This file is in the public domain.
*/


#include <stdio.h>
#include <stdlib.h>

#define COLUMNS 6
int currentColumns; 

int is_prime(int n){
  for(int i = n-2; i > 1; i = i-2){
    if(n%i == 0)
      return 0;
  }
  return 1;
}

void print_number(int num){
      currentColumns++;
    if(currentColumns > COLUMNS){
            printf("\n");
            currentColumns = 0;

    }
    printf("%d \t", num);

    //effect is the main return value 
    //everything else visible is side-effect

    
}


void print_primes(int n){
  // Should print out all prime numbers less than 'n'
  // with the following formatting. Note that
  // the number of columns is stated in the define
  // COLUMNS
    for(int i = 0; i <= n; i++){
        if(is_prime(i) == 1 ){
            print_number(i);
        }
    }


  printf("\n");
}

// 'argc' contains the number of program arguments, and
// 'argv' is an array of char pointers, where each
// char pointer points to a null-terminated string.
int main(int argc, char *argv[]){
  //if(argc == )
    print_primes(103); //it took about double the time for print-primes than heap option, because this is not using a good way to find primes
  /*else
    printf("Please state an interger number.\n");*/
  return 0;
}

 
