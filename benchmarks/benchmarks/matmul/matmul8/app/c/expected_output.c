#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) expected_output[64] = {
130, 158, 116, 144, 82, 110, 108, 136,
142, 174, 76, 108, 90, 122, 144, 176,
174, 210, 156, 192, 118, 154, 100, 136,
126, 166, 156, 196, 166, 206, 176, 216,
198, 242, 176, 220, 134, 178, 172, 216,
130, 158, 116, 144, 82, 110, 108, 136,
142, 174, 76, 108, 90, 122, 144, 176,
174, 210, 156, 192, 118, 154, 100, 136};
