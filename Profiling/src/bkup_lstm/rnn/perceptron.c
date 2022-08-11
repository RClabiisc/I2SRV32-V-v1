#include "header.h"

int mlp_3(Vec *input, Param_mlp *weights)
{
    //Unpacking Weights
    Matrix2D *w1 = weights->w1;
    Matrix2D *w2 = weights->w2;
    Vec      *b1 = weights->b1;
    Vec      *b2 = weights->b2;
    //Hidden layer
    Vec *hidden_layer;
    Vec *output_layer;
    int output;
    Vec *temp, *temp2;
    //Vec *temp3;
    //Compute Forward Path
    temp = vmatmul(input,w1);
    temp2= vadd2(temp,b1);
    hidden_layer = sigmoid(temp2);
    free(temp);
    free(temp2);
    output_layer = vmatmul(hidden_layer,w2);
    //temp3 = vmatmul(hidden_layer,w2);
    //output_layer = vadd2(temp3,b2);
    
    // Find the Maximum Probability
    output = get_max_idx(output_layer);
    //free(temp3);
    free(hidden_layer);
    free(output_layer);
    return output;
}
