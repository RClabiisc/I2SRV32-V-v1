#include "header.h"

Vec *gate(Vec *x, Vec *h, Matrix2D *w_x, Matrix2D *w_h, Vec *bias, int activator)
{
    //This unit performs 
    // y = activation(w_x * x(t) + w_h * h(t-1) + bias)
    Vec *x_w;    //x*w
    Vec *h_w;    //h*w
    Vec *sum;    //
    Vec *pre_activation;
    Vec *gate_output;

    // 1. M * x
    x_w = vmatmul(x,w_x);
    // 2. W * h
    h_w = vmatmul(h,w_h);
    // 3. Wx + Wh
    sum = vadd2(x_w,h_w);
    // 4. Wx + Wh + b
    pre_activation = vadd2(sum,bias);
    // 5. Activation
    if(activator)
        gate_output = sigmoid(pre_activation);
    else
        gate_output = tanhyp(pre_activation);    
    // Return Activation(w_x * x(t) + w_h * h(t-1) + bias)
    //Free Memory
    free(w_x);
    free(h_w);
    free(sum);
    free(pre_activation);
    return gate_output;
}
