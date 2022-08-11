#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#define INPUT_SIZE 784
#define PCA_SIZE 100
#define LAYER1_SIZE 32 
#define LAYER2_SIZE 16 
#define LAYER3_SIZE 10
 

extern float layer1[LAYER1_SIZE];
extern float layer2[LAYER2_SIZE];
extern float output_probs[LAYER3_SIZE];
extern float eigen_vectors[INPUT_SIZE][PCA_SIZE];
extern float feature_mean[INPUT_SIZE];
extern float feature_sd[INPUT_SIZE];
extern float w1[PCA_SIZE][LAYER1_SIZE];
extern float w2[LAYER1_SIZE][LAYER2_SIZE];
extern float w3[LAYER2_SIZE][LAYER3_SIZE];
extern float b2[LAYER2_SIZE];
extern float b3[LAYER3_SIZE];
extern float b1[LAYER1_SIZE];
extern float img[INPUT_SIZE];

float activation(float val);
int get_max_idx(float input_arr[LAYER3_SIZE]);
void pca(float img[],float out[]);
void scaler(float inp[],float scaled[]);
int perceptron(float input[]);
#endif
