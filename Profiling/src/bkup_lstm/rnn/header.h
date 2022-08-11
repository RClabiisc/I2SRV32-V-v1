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
    int dim;
    float data[];
}Vec;

typedef struct
{
    int dim1;
    int dim2;
    float data[];
}Matrix2D;

typedef struct
{
    Vec *h;
    Vec *c;
}State;

typedef struct
{
    Matrix2D *w_ix;
    Matrix2D *w_fx;
    Matrix2D *w_ox;
    Matrix2D *w_gx;

    Matrix2D *w_ih;
    Matrix2D *w_fh;
    Matrix2D *w_oh;
    Matrix2D *w_gh;
    
    Vec *b_i;
    Vec *b_f;
    Vec *b_o;
    Vec *b_g;
}Param;

typedef struct
{
    Matrix2D *w1;
    Matrix2D *w2;
    Vec *b1;
    Vec *b2;
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
extern Matrix2D *wix1, *wfx1,  *wox1, *wgx1;
extern Matrix2D *wix2, *wfx2,  *wox2, *wgx2;
extern Matrix2D *wih1, *wfh1,  *woh1, *wgh1;
extern Matrix2D *wih2, *wfh2,  *woh2, *wgh2;
extern Matrix2D *wp1,  *wp2;

extern Vec      *bp1,  *bp2;
extern Vec      *bi1,  *bf1,   *bo1,  *bg1;
extern Vec      *bi2,  *bf2,   *bo2,  *bg2;
extern Vec      *x_0,  *x_1,   *h_0,  *h_1, *h_2, *c_0,  *c_1, *c_2;
extern State    *t0,   *t1,    *t2;
extern Param    *layer1_param, *layer2_param;
extern Param_mlp *mlp_param;

//-----------------------------Function Declaration----------------------------
Vec *gate(Vec *x, Vec *h, Matrix2D *w_x, Matrix2D *w_h, Vec *bias, int activator);
Vec* vmatmul(Vec *vect, Matrix2D *mat);
Matrix2D* matmul(Matrix2D *a, Matrix2D *b);
Vec* vadd2(Vec *a,Vec *b);
Vec* sigmoid(Vec *x);
Vec* tanhyp(Vec *x);
int compute_offset2D(int dim2,int a,int b);
int get_max_idx(Vec *input);
Vec* hadamard_product(Vec *a, Vec *b);
State* lstm(State *prev_state, Vec *input, Param *params);
void init();
int mlp_3(Vec *input, Param_mlp *weights);
void free_mem();

#endif
