#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) expected_output[32] = {
0, 96, 192, 288, 384, 480, 576, 672,
768, 864, 320, 416, 512, 608, 704, 800,
896, 992, 1088, 1184, 640, 736, 832, 928,
1024, 1120, 1216, 1312, 1408, 1504, 960, 1056};