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
    Param1 l1;
    Param1 *layer1_param = &l1;
    
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
    
    //Define layer2_param
    Param2 l2;
    Param2 *layer2_param = &l2;
    //
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
    State1 t_0_layer1,t_1_layer1;
    State2 t_0_layer2,t_1_layer2;

    State1 *t0_layer1 = &t_0_layer1;
    State1 *t1_layer1 = &t_1_layer1;
    
    State2 *t0_layer2 = &t_0_layer2;
    State2 *t1_layer2 = &t_1_layer2;

    float h_0[HIDDEN_LAYER_SIZE];
    float c_0[HIDDEN_LAYER_SIZE];
    float h_1[HIDDEN_LAYER_SIZE];
    float c_1[HIDDEN_LAYER_SIZE];
    float h_2[LAYER2_SIZE];
    float c_2[LAYER2_SIZE];
    
    // The below for loop is common for initilllzing both LSTMS since dimensions are same
    for(int i=0;i<HIDDEN_LAYER_SIZE;i++)
    {
        h_0[i] = 0;
        c_0[i] = 0;

    }

    t0_layer1->h = &h_0;
    t0_layer1->c = &c_0;
    t0_layer2->h = &h_0;
    t0_layer2->c = &c_0;

    t1_layer1->h = &h_1;
    t1_layer1->c = &c_1;

    t1_layer2->h = &h_2;
    t1_layer2->c = &c_2;
    //Compute Forward Path
    lstm1(t0_layer1, input, layer1_param,t1_layer1);
    lstm2(t0_layer2, *(t1_layer1->h), layer2_param,t1_layer2);
    // MLP
    output =mlp_3(*(t1_layer2->h), LAYER2_SIZE, param_mlp);
   // printf("Output= %d\n",output);

    return 0;
}


