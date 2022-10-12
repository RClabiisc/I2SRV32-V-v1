#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) y_vec[8] = {
0, 8, 16, 24, 32, 40, 48, 56};
