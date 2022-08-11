#include "header.h"

int mlp_3(float input[],int input_dim, Param_mlp *weights)
{

    //Hidden layer
    float hidden_layer[LAYER3_SIZE];
    float output_layer[OUTPUT_SIZE];
    float temp[LAYER3_SIZE], temp1[LAYER3_SIZE], temp2[LAYER3_SIZE], temp4[OUTPUT_SIZE];
    int output;
    //Compute Forward Path
    vmatmul(input,*(weights->w1),INPUT_SIZE,LAYER3_SIZE,temp);    //w1*x
    vadd2(temp,*(weights->b1),LAYER3_SIZE,temp2);              //w1*b + b
    sigmoid(temp2,LAYER3_SIZE,hidden_layer);       //sigmoid(w1*x + b)
    vmatmul(hidden_layer,*(weights->w2),LAYER3_SIZE,OUTPUT_SIZE,temp4); //hidden_layer*w2
    vadd2(temp4,*(weights->b2),OUTPUT_SIZE,output_layer);          // add bias
    
    // Find the Maximum Probability
    output = get_max_idx(output_layer);
    return output;
}
