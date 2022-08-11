#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#include "header.h"
int main()
{
    //Define Layer1_param
    //Define layer2_param
    Param l1,l2;
    Param *layer1_param = &l1;
    Param *layer2_param = &l2;
    
    layer1_param->w_ix= &w_ix_1;
    layer1_param->w_fx= &w_fx_1;
    layer1_param->w_ox= &w_ox_1;
    layer1_param->w_gx= &w_gx_1;
    
    layer1_param->w_ih= &w_ih_1;
    layer1_param->w_fh= &w_fh_1;
    layer1_param->w_oh= &w_oh_1;
    layer1_param->w_gh= &w_gh_1;
    
    layer1_param->b_i = &b_ix_1;
    layer1_param->b_f = &b_fx_1;
    layer1_param->b_o = &b_ox_1;
    layer1_param->b_g = &b_gx_1;
    
    layer2_param->w_ix= &w_ix_2;
    layer2_param->w_fx= &w_fx_2;
    layer2_param->w_ox= &w_ox_2;
    layer2_param->w_gx= &w_gx_2;
    
    layer2_param->w_ih= &w_ih_2;
    layer2_param->w_fh= &w_fh_2;
    layer2_param->w_oh= &w_oh_2;
    layer2_param->w_gh= &w_gh_2;
    
    layer2_param->b_i = &b_ix_2;
    layer2_param->b_f = &b_fx_2;
    layer2_param->b_o = &b_ox_2;
    layer2_param->b_g = &b_gx_2;
    
    //Define mlp_param
    Param_mlp mlp_weights;
    Param_mlp *param_mlp = &mlp_weights;
    param_mlp->w1 = &w3;
    param_mlp->w2 = &w4;
    param_mlp->b1 = &b3;
    param_mlp->b2 = &b4;

    int output;
    //Initiallize All Inputs and Parameters
    State t_0,t_1,t_2;
    State *t0 = &t_0;
    State *t1 = &t_1;
    State *t2 = &t_2;

    float h_0[HIDDEN_LAYER_SIZE];
    float c_0[HIDDEN_LAYER_SIZE];
    float h_1[HIDDEN_LAYER_SIZE];
    float c_1[HIDDEN_LAYER_SIZE];
    float h_2[HIDDEN_LAYER_SIZE];
    float c_2[HIDDEN_LAYER_SIZE];
    
    for(int i=0;i<HIDDEN_LAYER_SIZE;i++)
    {
        h_0[i] = 0;
        c_0[i] = 0;
    }

    t0->h = &h_0;
    t0->c = &c_0;

    t1->h = &h_1;
    t1->c = &c_1;

    t2->h = &h_2;
    t2->c = &c_2;
    //Compute Forward Path
    t1 = lstm(t0, input, layer1_param);

    t2 = lstm(t1, input, layer2_param);
    // MLP
    output =mlp_3(h_2,INPUT_SIZE, mlp_param);
    //printf("Output= %d\n",output);

    return 0;
}


