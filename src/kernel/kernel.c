#include "kernel.h"


void main(){
    draw_title();
}


/* OS entry point */
void kernel_entry(uint32_t magic, uint32_t addr){

    ASSERT(!kernel_setup(magic, addr));

    main();
    
    return;
}

int kernel_setup(uint32_t magic, uint32_t addr){
    if(magic!=MULTIBOOT_BOOTLOADER_MAGIC){
        printf("MULTIBOOT MAGIC FAILURE");
    }

    return 0;
}

void draw_title(){
    printf("Welcome to...\n\
  _____                  _      ____   _____     ___ \n\  
 |  __ \\                | |    / __ \\ / ____|   |__ \\\n\
 | |__) _   _ _ __   ___| |__ | |  | | (___ ______ ) |\n\
 |  ___| | | | '_ \\ / __| '_ \\| |  | |\\___ |______/ / \n\
 | |   | |_| | | | | (__| | | | |__| |____) |    / /_ \n\
 |_|    \\__,_|_| |_|\\___|_| |_|\\____/|_____/    |____|\n"
    );
}