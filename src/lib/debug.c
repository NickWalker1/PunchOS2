#include "debug.h"

/* Halt the system by disabling interrupts and halting execution.*/
void halt(){
    __asm__ volatile("cli;hlt");
}

/* Used to create a breakpoint exception */
void breakpoint(){
    __asm__ volatile("int $3");
}
