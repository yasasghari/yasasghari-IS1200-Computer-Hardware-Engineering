/*
 sieves.c
 This file is in the public domain.
*/


#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>

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
    bool* list = malloc(n * sizeof(bool)); //malloc() puts on heap for later freeing. 
    int temp = (int)(sqrt(n)+0.5);         // turn out, [] is not the same as a pointer because we cant use [] array for this we need to use pointed array
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

        free(list); //freeing is technically not needed, as the calls to the pointer can still be used
                //below, but this is technically bad. not freeing the memory will mean it will cannot be used til its free, 
                // which in practice is wasting memory. 
    printf("\n");
}

// 'argc' contains the number of program arguments, and
// 'argv' is an array of char pointers, where each
// char pointer points to a null-terminated string.
int main(int argc, char *argv[]){
  //if(argc == )
    print_sieves(100000); //we can do a 100k on heap with 10 seconds, about 10 times slower than non-heap 
                        // 
  /*else
    printf("Please state an interger number.\n");*/
  return 0;
}

 
