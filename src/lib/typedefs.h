#pragma once

typedef char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
typedef enum {false, true} bool;
typedef unsigned long size_t;

#define UNUSED __attribute((unused))

#define BASE_BIN 2
#define BASE_DEC 10
#define BASE_HEX 16

#define NULL (void*)0

#define ASSERT(x...)                                                     \
  if (!(x)) {                                                            \
      printf ("Error: '%s' [%s:%i]\n", #x, __FILE__, __LINE__);          \
      halt();   					                                     \
    }
