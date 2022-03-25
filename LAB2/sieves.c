/*
 sieves.c
 This file is in the public domain.
*/


#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

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

    
}


void print_sieves(int n){
  // Should print out all prime numbers less than 'n'
  //true is false and false is true cause we dont know how to initialize an array of bools to all be true

  //sieves pseudocode can be seen @https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes#Pseudocode
    bool list[n];
    
    int temp = (int)(sqrt(n)+0.5);        
    for(int i = 2; i <= temp; i++)
    {
        if(list[i] == false){
            for(int j = i*i; j < n; j = j+i){
                list[j] = true;
            }
        }
    }

    for(int i = 2; i < n; i++){
        if(list[i] == false){
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
    print_sieves(10000); // we can do slightly larger than 100 000 numbers in 2 seconds. this is a however, very dependant on ur ram/cpu
  /*else                    //we can do slightly above 1 mil with 10 seconds. i would assume this 
    printf("Please state an interger number.\n");*/
  return 0;
}

 
