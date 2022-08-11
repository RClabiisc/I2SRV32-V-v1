#include "header.h"

void gate(float x[], int x_dim, float h[], int h_dim, Param_gate *weights, int activator, float gate_output[])
{
    //This unit performs 
    // y = activation(w_x * x(t) + w_h * h(t-1) + bias)

    float x_w[HIDDEN_LAYER_SIZE];    //x*w
    float h_w[HIDDEN_LAYER_SIZE];    //h*w
    float sum[HIDDEN_LAYER_SIZE];    //
    float pre_activation[HIDDEN_LAYER_SIZE];
    // Gate Computation
    // 1. M * x
    vmatmul(x, *(weights->w_x), INPUT_SIZE, HIDDEN_LAYER_SIZE, x_w ) ;
    // 2. W * h
    vmatmul(h, *(weights->w_h), HIDDEN_LAYER_SIZE, HIDDEN_LAYER_SIZE, h_w );
    // 3. Wx + Wh
    vadd2(x_w,h_w, HIDDEN_LAYER_SIZE, sum);
    // 4. Wx + Wh + b
    vadd2(sum, *(weights->bias), HIDDEN_LAYER_SIZE, pre_activation);
    // 5. Activation
    if(activator)
        sigmoid(pre_activation, HIDDEN_LAYER_SIZE, gate_output);
    else
        tanhyp(pre_activation, HIDDEN_LAYER_SIZE, gate_output);    
}
