#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern float filter[][5][1][32];
extern float img[][28][1];
extern float bias[];
//float ***conv2d_1( (float (img *)[28][1], float (filter *)[5][1][32], float *bias);
float ***conv2d_1(float img[][28][1], float filter[][5][1][32], float bias[32]);
//float ***conv2d_1(float*** img, float**** filter, float* bias);
float relu(float val);
#endif
