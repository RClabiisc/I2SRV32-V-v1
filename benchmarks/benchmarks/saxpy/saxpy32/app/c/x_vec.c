#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) x_vec[32] = {
0, 1, 2, 3, 4, 5, 6, 7,
8, 9, 0, 1, 2, 3, 4, 5,
6, 7, 8, 9, 0, 1, 2, 3,
4, 5, 6, 7, 8, 9, 0, 1};