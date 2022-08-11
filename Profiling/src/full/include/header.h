#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct{
	int dim1;
	int dim2;
	int dim3;
	float data[];
}Matrix3D;

typedef struct{
        int dim1;
        int dim2;
        int dim3;
        int dim4;
        float data[];
}Matrix4D;

extern float filt1[800];
extern float filt2[51200];
extern float img[784];
extern float bias1[32];
extern float bias2[64];

Matrix3D *conv2d(Matrix3D *img, Matrix4D *filter, float bias[32]);
float relu(float val);
float max(float *e1, float *e2, float *e3, float *e4);
Matrix3D* maxpool2(Matrix3D* input);
void print3DMat(Matrix3D* mat);
#endif

