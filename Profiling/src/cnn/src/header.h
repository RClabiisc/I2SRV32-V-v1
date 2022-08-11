#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define  FILT1_SIZE  800
#define  FILT2_SIZE  51200
#define  BIAS1_SIZE  32
#define  BIAS2_SIZE  64
#define  IMG_SIZE    784
#define  OUTPUT_SIZE 10

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


extern float filt1[FILT1_SIZE];
extern float filt2[FILT2_SIZE];
extern float img[IMG_SIZE];
extern float bias1[BIAS1_SIZE];
extern float bias2[BIAS2_SIZE];
extern float w1[][OUTPUT_SIZE];
extern float b1[OUTPUT_SIZE];

extern const int image_dim1;
extern const int image_dim2;
extern const int image_dim3;

extern const int filter1_dim1;
extern const int filter1_dim2;
extern const int filter1_dim3;
extern const int filter1_dim4;

extern const int filter2_dim1;
extern const int filter2_dim2;
extern const int filter2_dim3;
extern const int filter2_dim4;

//extern float output[OUTPUT_SIZE];

Matrix3D* conv2d(Matrix3D *img, Matrix4D *filter, float bias[]);
float relu(float val);
float max(float *e1, float *e2, float *e3, float *e4);
Matrix3D* maxpool2(Matrix3D* input);
void print3DMat(Matrix3D* mat);
int perceptron(float input[], int input_size);
int get_max_idx(float input_arr[OUTPUT_SIZE]);
int compute_offset3D(int x1, int x2, int x3, int d1, int d2, int d3);
int compute_offset4D(int x1, int x2, int x3, int x4, int d1, int d2, int d3, int d4);
float mac_op(float sum, float a, float b);


#endif

