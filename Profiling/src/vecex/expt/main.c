#include <stddef.h>
#include "header.h"
//void bcd2ascii(void* dst, const void* src, size_t n);

const unsigned char inp[] = {
    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10,
    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
};

#include <stdio.h>

int main()
{
    char out[sizeof inp * 2 + 1] = {0};
    // expected output:
    // out = { '0', '1', '2', '3', ... }

    bcd2ascii(out, inp, sizeof inp);
    puts(out);
    return 0;
}


