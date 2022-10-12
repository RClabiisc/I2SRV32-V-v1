#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) expected_output[16] = {
0, 80, 160, 240, 320, 400, 480, 560,
640, 720, 160, 240, 320, 400, 480, 560};
