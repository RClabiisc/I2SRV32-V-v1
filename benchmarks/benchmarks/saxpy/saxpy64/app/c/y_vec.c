#include "header.h" 
int __attribute__((aligned(32))) __attribute__((section(".vmem_data"))) y_vec[64] = {
0, 64, 128, 192, 256, 320, 384, 448,
512, 576, 640, 704, 768, 832, 896, 960,
1024, 1088, 1152, 1216, 1280, 1344, 1408, 1472,
1536, 1600, 1664, 1728, 1792, 1856, 1920, 1984,
2048, 2112, 2176, 2240, 2304, 2368, 2432, 2496,
2560, 2624, 2688, 2752, 2816, 2880, 2944, 3008,
3072, 3136, 3200, 3264, 3328, 3392, 3456, 3520,
3584, 3648, 3712, 3776, 3840, 3904, 3968, 4032};
