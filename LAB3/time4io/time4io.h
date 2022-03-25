#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

extern int getsw(void) {
	return (PORTD >> 8);
}

extern int getbtns(void) {
	return (PORTD >> 5);
}