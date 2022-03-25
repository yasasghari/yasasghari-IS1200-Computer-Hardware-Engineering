/* mipslabwork.c
    Questions for assignment 2: 
    1. When the event flag is a 1, our code resets to 0 from line 71 and forwards.
    at line 79 we further reset the the event flag. 
    2. If were to not use the reset line, then after the first 10 interrupts we would constantly be in the loop
    3. No fuckign clue 
    4. we check buttons 10 times as often because we check it after we failed the 2nd if statement 
*/

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */
#include "time4io.h"

#define io32(x) (*(volatile unsigned int *)(x))
#define addr1 (0xbf886100)
#define addr2 (0xbf886110)

//volatile unsigned int *pointer1 = (volatile unsigned int *) 0xbf886100;
//volatile unsigned int *pointer2 = (volatile unsigned int *) 0xbf886110;

int timeoutcount = 0;
int mytime = 0x0000;
int btns = 0b000;
int sw = 0b0000;

char textstring[] = "Start Timer:";
//char textstring = 0x3A;

/* Interrupt Service Routine */
void user_isr( void )
{
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{

  io32(addr1) = 0x00;   // Initialises Port E so all bits are outputs
  io32(addr2) = 0x00;   // Sets each bit of Port E to 0

  TRISD &= 0b111111100000;

  //T2CON = 0x0;        // Stop timer and clear control register,
                        // set prescaler at 1:1, internal clock source
  //TMR2 = 0x0;         // Clear timer register
  //PR2 = 0xFFFF;       // Load period register
  //T2CONSET = 0x8000;  // Start timer

  T2CON = 0x0;
  T2CONSET = 0x0070;
  TMR2 = 0x0000;
  PR2 = 0x7A12;

  IFSCLR(0) = 0x00000108;

  T2CONSET = 0x8000;


  display_string( 0, "LAB3 Ass2" );
  display_string( 1, "Yas & Edvin" );
  display_string( 2, "UWU PLS BUY" );
  display_string( 3, "" );
  display_update();
  return;
}

/* This function is called repetitively from the main program */
void labwork( void ) {

  sw = (getsw() & 0xf);
  btns = (getbtns() & 0x7);
  int flagCheck = (IFS(0) & 0x100) >> 8;
  if (flagCheck) {
    if (timeoutcount == 10) {
      time2string( textstring, mytime);
      display_string( 3, textstring );
      display_update();
      tick( &mytime );
      io32(addr2)++;
      display_image(96, icon);
      timeoutcount = 0;
    }
    timeoutcount++;
    IFSCLR(0) = 0x00000100; // Clear the timer interrupt status flag
  }
  //time2string( textstring, mytime );
  //display_string( 3, textstring );
  //display_update();
  //tick( &mytime );
  //io32(addr2)++;
  //display_image(96, icon);

  // Add sw to seconds tens position
  if (btns == 0x1 || btns == 0x3 || btns == 0x5 || btns == 0x7) {
    mytime = (mytime & 0xff0f);
    mytime = (mytime | (sw << 4));
  }

  // Add sw to minutes ones position
  if (btns == 0x2 || btns == 0x3 || btns == 0x6 || btns == 0x7) {
    mytime = (mytime & 0xf0ff);
    mytime = (mytime | (sw << 8));
  }

  // Add sw to minutes tens position
  if (btns == 0x4 || btns == 0x5 || btns == 0x6 || btns == 0x7) {
    mytime = (mytime & 0x0fff);
    mytime = (mytime | (sw << 12));
  }

}
