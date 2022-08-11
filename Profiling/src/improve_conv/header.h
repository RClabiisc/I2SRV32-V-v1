#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern double filter[][5][1][32];
extern double img[][28][1];
extern double bias[];
double ***conv2d_1( double **img, double ***filter, double bias);
//double ***conv2d_1( double (*img)[28][1], double (*filter)[5][1][32], double *bias);
//double ***conv2d_1(double*** img, double**** filter, double* bias);
double relu(double val);
#endif
