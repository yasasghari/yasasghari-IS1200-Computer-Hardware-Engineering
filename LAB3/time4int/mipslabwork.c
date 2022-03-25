/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */
#include "time4io.h"

#define io32(x) (*(volatile unsigned int *)(x))
#define addr1 (0xbf886100)
#define addr2 (0xbf886110)

//volatile unsigned int *pointer1 = (volatile unsigned int *) 0xbf886100;
//volatile unsigned int *pointer2 = (volatile unsigned int *) 0xbf886110;

int prime = 1234567;
int counter = 0;
int mytime = 0x0000;
int btns = 0b000;
int sw = 0b0000;

char textstring[] = "Start Timer:";
//char textstring = 0x3A;

/* Interrupt Service Routine */
void user_isr( void ) {

  int flagCheck = (IFS(0) & 0x100) >> 8;
  if (flagCheck) {
    if (counter == 10) {
      time2string(textstring, mytime);
      display_string(3, textstring);
      display_update();
      tick(&mytime);
      counter = 0;
    }
    counter++;
    IFSCLR(0) = 0x00000100; // Clear the timer interrupt status flag
  }

}

/* Lab-specific initialization goes here */
void labinit( void )
{

  io32(addr1) = 0x00;   // Initialises Port E so all bits are outputs
  io32(addr2) = 0x00;   // Sets each bit of Port E to 0

  TRISD &= 0b111111100000;

  T2CON = 0x0;
  T2CONSET = 0x0070;
  TMR2 = 0x0000;
  PR2 = 0x7A12; // 80MHz/256/10

  IPCSET(2) = 0x0000000D;

  IFSCLR(0) = 0x00000108;
  IECSET(0) = 0x00000100;

  T2CONSET = 0x8000;

  enable_interrupt();

  display_string( 0, "" );
  display_string( 1, "" );
  display_string( 2, "" );
  display_string( 3, "" );
  display_update();
  return;
}

/* This function is called repetitively from the main program */
void labwork( void ) {

  prime = nextprime(prime);
  display_string(0, itoaconv(prime));
  display_update();

}
