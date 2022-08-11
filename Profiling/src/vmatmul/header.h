#ifndef HEADERFILE_H
#define HEADERFILE_H
#include <stdio.h>
#define VEC_SIZE 3
#define MAT_DIM_1 VEC_SIZE
#define MAT_DIM_2 3
#define MAT_SIZE (MAT_DIM_1)*(MAT_DIM_2)

void vmatmul(float vect[], float mat[],int vdim, int mat_dim2, float res[]);
float multiplication(float a, float b);
int compute_offset2D(int dim2,int a,int b);

#endif
/*
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#define INPUT_SIZE 28
#define HIDDEN_LAYER_SIZE 128
#define LAYER2_SIZE 128
#define LAYER3_SIZE 64
#define OUTPUT_SIZE 10

typedef struct
{
    float (*w_x)[HIDDEN_LAYER_SIZE*INPUT_SIZE];
    float (*w_h)[HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE];
    float (*bias)[HIDDEN_LAYER_SIZE];
}Param1_gate;

typedef struct
{
    float (*w_x)[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_h)[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
    float (*bias)[LAYER2_SIZE];
}Param2_gate;

typedef struct
{
    float (*h)[HIDDEN_LAYER_SIZE];
    float (*c)[HIDDEN_LAYER_SIZE];
}State1;

typedef struct
{
    float (*h)[LAYER2_SIZE];
    float (*c)[LAYER2_SIZE];
}State2;


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
}Param1;

typedef struct
{
    float (*w_ix)[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_fx)[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_ox)[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
    float (*w_gx)[LAYER2_SIZE*HIDDEN_LAYER_SIZE];

    float (*w_ih)[LAYER2_SIZE*LAYER2_SIZE];
    float (*w_fh)[LAYER2_SIZE*LAYER2_SIZE];
    float (*w_oh)[LAYER2_SIZE*LAYER2_SIZE];
    float (*w_gh)[LAYER2_SIZE*LAYER2_SIZE];
    
    float (*b_i)[LAYER2_SIZE];
    float (*b_f)[LAYER2_SIZE];
    float (*b_o)[LAYER2_SIZE];
    float (*b_g)[LAYER2_SIZE];
}Param2;

typedef struct
{
    float (*w1)[LAYER2_SIZE*LAYER3_SIZE];
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

extern float w_ix_2[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
extern float w_fx_2[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
extern float w_ox_2[LAYER2_SIZE*HIDDEN_LAYER_SIZE];
extern float w_gx_2[LAYER2_SIZE*HIDDEN_LAYER_SIZE];

extern float w_ih_2[LAYER2_SIZE*LAYER2_SIZE];
extern float w_fh_2[LAYER2_SIZE*LAYER2_SIZE];
extern float w_oh_2[LAYER2_SIZE*LAYER2_SIZE];
extern float w_gh_2[LAYER2_SIZE*LAYER2_SIZE];

extern float b_ix_1[HIDDEN_LAYER_SIZE];
extern float b_fx_1[HIDDEN_LAYER_SIZE];
extern float b_ox_1[HIDDEN_LAYER_SIZE];
extern float b_gx_1[HIDDEN_LAYER_SIZE];

extern float b_ih_1[HIDDEN_LAYER_SIZE];
extern float b_fh_1[HIDDEN_LAYER_SIZE];
extern float b_oh_1[HIDDEN_LAYER_SIZE];
extern float b_gh_1[HIDDEN_LAYER_SIZE];

extern float b_ix_2[LAYER2_SIZE];
extern float b_fx_2[LAYER2_SIZE];
extern float b_ox_2[LAYER2_SIZE];
extern float b_gx_2[LAYER2_SIZE];

extern float b_ih_2[LAYER2_SIZE];
extern float b_fh_2[LAYER2_SIZE];
extern float b_oh_2[LAYER2_SIZE];
extern float b_gh_2[LAYER2_SIZE];

extern float w3[LAYER2_SIZE*LAYER3_SIZE];
extern float w4[LAYER3_SIZE*OUTPUT_SIZE];
extern float b3[LAYER3_SIZE];
extern float b4[OUTPUT_SIZE];

extern float input[INPUT_SIZE];
//-----------------------------------GlobVars---------------------------------
//extern Param     l1,l2;
//extern Param    *layer1_param, *layer2_param;
//extern Param_mlp *mlp_param;

//-----------------------------Function Declaration----------------------------
void lstm1(State1 *prev_state, float input[], Param1 *params, State1 *curr_state);
void lstm2(State2 *prev_state, float input[], Param2 *params, State2 *curr_state);

void gate1(float x[], float h[], Param1_gate *weights, int activator, float gate_output[]);
void gate2(float x[], float h[], Param2_gate *weights, int activator, float gate_output[]);

int mlp_3(float input[],int input_dim, Param_mlp *weights);
void vmatmul(float vect[], float mat[],int vdim, int mat_dim2, float res[]);
void vadd2(float a[],float b[],int dim,float y[]);
int compute_offset2D(int dim2,int a,int b);
void sigmoid(float x[], int dim, float y[]);
void tanhyp(float x[], int dim, float y[]);
void hadamard_product(float a[], float b[], int dim, float y[]);
int get_max_idx(float input[]);
float multiplication(float a, float b);
#endif

*/
