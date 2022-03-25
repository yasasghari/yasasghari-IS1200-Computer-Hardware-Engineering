/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by YOU! So you must
   add comment(s) here with your name(s) and date(s):

  uwu edvin frosterud and yas asghari 

  1. If you press two buttons at once, both numbers change to whatever is specified on our 4-digit binary number. 

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

  //TRISE &= ~0x00;
  //PORTE &= ~0xff;

  io32(addr1) = 0x00;   // Initialises Port E so all bits are outputs
  io32(addr2) = 0x00;   // Sets each bit of Port E to 0

  TRISD &= 0b111111100000;

  delay( 2000 );

  display_string( 0, "LAB3 Assignment 1" );
  display_string( 1, "Yas & Edvin" );
  display_string( 2, "(UwU)");
  display_string( 3, "" );
  display_update();
  return;
}

/* This function is called repetitively from the main program */
void labwork( void )
{
  delay( 1000 );


  sw = (getsw() & 0xf);
  btns = (getbtns() & 0x7);

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

  time2string( textstring, mytime );
  display_string( 3, textstring );
  display_update();
  tick( &mytime );
  io32(addr2)++;
  display_image(96, icon);
}
