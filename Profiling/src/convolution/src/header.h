#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>

#define IMG_DIM1 28
#define IMG_DIM2 28
#define IMG_DIM3 1

#define FILT1_DIM1 5
#define FILT1_DIM2 5
#define FILT1_DIM3 1
#define FILT1_DIM4 32

#define FILT2_DIM1 5
#define FILT2_DIM2 5
#define FILT2_DIM3 32
#define FILT2_DIM4 64

#define OUTPUT_SIZE 10
//----------------------
//Derived

#define  FILT1_SIZE  (FILT1_DIM1)*(FILT1_DIM2)*(FILT1_DIM3)*(FILT1_DIM4)
#define  FILT2_SIZE  (FILT2_DIM1)*(FILT2_DIM2)*(FILT2_DIM3)*(FILT2_DIM4)
#define  IMG_SIZE    (IMG_DIM1)*(IMG_DIM2)*(IMG_DIM3)

#define CONV1_DIM1 IMG_DIM1-FILT1_DIM1+1
#define CONV1_DIM2 IMG_DIM2-FILT1_DIM2+1
#define CONV1_DIM3 FILT1_DIM4

#define MAXPOOL1_DIM1 (CONV1_DIM1)/2
#define MAXPOOL1_DIM2 (CONV1_DIM2)/2
#define MAXPOOL1_DIM3 (CONV1_DIM3)

#define CONV2_DIM1 MAXPOOL1_DIM1-FILT2_DIM1+1
#define CONV2_DIM2 MAXPOOL1_DIM2-FILT2_DIM2+1
#define CONV2_DIM3 FILT2_DIM4

#define MAXPOOL2_DIM1 (CONV2_DIM1)/2
#define MAXPOOL2_DIM2 (CONV2_DIM2)/2
#define MAXPOOL2_DIM3 (CONV2_DIM3)

#define BIAS1_SIZE FILT1_DIM4
#define BIAS2_SIZE FILT2_DIM4


#define CONV1_SIZE (CONV1_DIM1)*(CONV1_DIM2)*(CONV1_DIM3)
#define CONV2_SIZE (CONV2_DIM1)*(CONV2_DIM2)*(CONV2_DIM3)
#define MAXPOOL1_SIZE (MAXPOOL1_DIM1) * (MAXPOOL1_DIM2) * (MAXPOOL1_DIM3)
#define MAXPOOL2_SIZE (MAXPOOL2_DIM1) * (MAXPOOL2_DIM2) * (MAXPOOL2_DIM3)
#define FC_INPUT_SIZE (MAXPOOL2_DIM1) * (MAXPOOL2_DIM2) * (MAXPOOL2_DIM3)
//---GLob Vars
extern float filt1[FILT1_SIZE];
extern float filt2[FILT2_SIZE];
extern float img[IMG_SIZE];
extern float bias1[BIAS1_SIZE];
extern float bias2[BIAS2_SIZE];
extern float w1[OUTPUT_SIZE];
extern float b1[OUTPUT_SIZE];

//Function Declarations
void conv2d_1(float img[], float filter[], float bias[], float output[]);
void conv2d_2(float img[], float filter[], float bias[], float output[]);
void maxpool2_1(float input[], float output[]);
void maxpool2_2(float input[], float output[]);
int perceptron(float input[]);
void vmatmul(float vect[], float mat[],int vdim, int mat_dim2, float res[]);
void vadd2(float a[],float b[],int dim,float y[]);
int get_max_idx(float input[]);
float max4(float e1, float e2, float e3, float e4);
float relu(float num);
void print3DMat(float mat[], int dim1_max, int dim2_max, int dim3_max);


#endif

