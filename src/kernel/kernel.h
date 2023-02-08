#pragma once

#include <typedefs.h>

#include <stdio.h>
#include <debug.h>


#include "multiboot.h"

void main();

void kernel_entry(uint32_t magic, uint32_t address);
int kernel_setup(uint32_t magic, uint32_t address);

void draw_title();
