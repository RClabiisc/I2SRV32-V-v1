#ifndef HEADERFILE_H
#define HEADERFILE_H

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#define INPUT_SIZE 28
#define HIDDEN_LAYER_SIZE 128
#define LAYER3_SIZE 64
#define OUTPUT_SIZE 10

typedef struct
{
    float (*w_x)[HIDDEN_LAYER_SIZE*INPUT_SIZE];
    float (*w_h)[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
    float (*bias)[HIDDEN_LAYER_SIZE];
}Param_gate;

typedef struct
{
    float (*h)[HIDDEN_LAYER_SIZE];
    float (*c)[HIDDEN_LAYER_SIZE];
}State;

typedef struct
{
    float (*w_ix)[INPUT_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_fx)[INPUT_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_ox)[INPUT_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_gx)[INPUT_SIZE*HIDDEN_LAYER_SIZE];

    float (*w_ih)[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_fh)[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_oh)[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_gh)[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
    
    float (*b_i)[HIDDEN_LAYER_SIZE];
    float (*b_f)[HIDDEN_LAYER_SIZE];
    float (*b_o)[HIDDEN_LAYER_SIZE];
    float (*b_g)[HIDDEN_LAYER_SIZE];
}Param;

typedef struct
{
    float (*w1)[HIDDEN_LAYER_SIZE*LAYER3_SIZE];
    float (*w2)[LAYER3_SIZE*OUTPUT_SIZE];
    float (*b1)[LAYER3_SIZE];
    float (*b2)[OUTPUT_SIZE];
}Param_mlp;

extern float w_ix_1[INPUT_SIZE*HIDDEN_LAYER_SIZE];
extern float w_fx_1[INPUT_SIZE*HIDDEN_LAYER_SIZE];
extern float w_ox_1[INPUT_SIZE*HIDDEN_LAYER_SIZE];
extern float w_gx_1[INPUT_SIZE*HIDDEN_LAYER_SIZE];

extern float w_ih_1[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_fh_1[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_oh_1[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_gh_1[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];

extern float w_ix_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_fx_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_ox_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_gx_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];

extern float w_ih_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_fh_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_oh_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
extern float w_gh_2[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];

extern float b_ix_1[HIDDEN_LAYER_SIZE];
extern float b_fx_1[HIDDEN_LAYER_SIZE];
extern float b_ox_1[HIDDEN_LAYER_SIZE];
extern float b_gx_1[HIDDEN_LAYER_SIZE];

extern float b_ih_1[HIDDEN_LAYER_SIZE];
extern float b_fh_1[HIDDEN_LAYER_SIZE];
extern float b_oh_1[HIDDEN_LAYER_SIZE];
extern float b_gh_1[HIDDEN_LAYER_SIZE];

extern float b_ix_2[HIDDEN_LAYER_SIZE];
extern float b_fx_2[HIDDEN_LAYER_SIZE];
extern float b_ox_2[HIDDEN_LAYER_SIZE];
extern float b_gx_2[HIDDEN_LAYER_SIZE];

extern float b_ih_2[HIDDEN_LAYER_SIZE];
extern float b_fh_2[HIDDEN_LAYER_SIZE];
extern float b_oh_2[HIDDEN_LAYER_SIZE];
extern float b_gh_2[HIDDEN_LAYER_SIZE];

extern float w3[HIDDEN_LAYER_SIZE*LAYER3_SIZE];
extern float w4[LAYER3_SIZE*OUTPUT_SIZE];
extern float b3[LAYER3_SIZE];
extern float b4[OUTPUT_SIZE];
extern float input[INPUT_SIZE];
//-----------------------------------GlobVars---------------------------------
//extern Param     l1,l2;
//extern Param    *layer1_param, *layer2_param;
//extern Param_mlp *mlp_param;

//-----------------------------Function Declaration----------------------------

void lstm(State *prev_state, float input[], Param *params, State *curr_state);
void gate(float x[], int x_dim, float h[], int h_dim, Param_gate *weights, int activator, float gate_output[]);
int mlp_3(float input[],int input_dim, Param_mlp *weights);
void vmatmul(float vect[], float mat[],int vdim, int mat_dim2, float res[]);
void vadd2(float a[],float b[],int dim,float y[]);
int compute_offset2D(int dim2,int a,int b);
void sigmoid(float x[], int dim, float y[]);
void tanhyp(float x[], int dim, float y[]);
void hadamard_product(float a[], float b[], int dim, float y[]);
int get_max_idx(float input[], int dim);

#endif
