#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) expected_output[8] = {
0, 72, 144, 216, 288, 360, 432, 504};
