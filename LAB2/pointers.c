


#include <stdio.h>

char* text1 = "This is a string.";
char* text2 = "Yet another thing.";

int list1[80/4];
int list2[80/4]; //we're diving by 4 because each int is 32 bits, while a register is 8 

int count = 0; 

void copycodes();

void work(){
  copycodes(text1, list1, &count);
  copycodes(text2, list2, &count);
}
 

void copycodes(char* string, int* inList, int* count){
  while(*string != 0){
    *inList = *string; //we're taking our CURRENT pointed char and saving it to the current position of the pointer of inlist
    //in assembly, this was done by adding 4 and adding 1 to the respective
    // becuz we're in C we dont need to do that, c handles it for us and assumes we're adding a 
    string++;
    inList++;
    //
    (*count)++; //derefrencing here

  }
}
//####################################
void printlist(const int* lst){
  printf("ASCII codes and corresponding characters.\n");
  while(*lst != 0){
    printf("0x%03X '%c' ", *lst, (char)*lst);
    lst++;
  }
  printf("\n");
}

void endian_proof(const char* c){
  printf("\nEndian experiment: 0x%02x,0x%02x,0x%02x,0x%02x\n", 
         (int)*c,(int)*(c+1), (int)*(c+2), (int)*(c+3));
  
}

int main(void){
  work();

  printf("\nlist1: ");
  printlist(list1);
  printf("\nlist2: ");
  printlist(list2);
  printf("\nCount = %d\n", count);

  endian_proof((char*) &count);
}
