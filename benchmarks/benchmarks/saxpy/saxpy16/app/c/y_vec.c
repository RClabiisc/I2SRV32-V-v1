#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) y_vec[16] = {
0, 16, 32, 48, 64, 80, 96, 112,
128, 144, 160, 176, 192, 208, 224, 240};
