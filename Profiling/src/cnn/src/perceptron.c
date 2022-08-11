#include "header.h"

int perceptron(float input[], int input_size)
{
    float mac;
    int idx;
    float output_probs[OUTPUT_SIZE];

    for (int i=0; i<OUTPUT_SIZE;i++)
    {
        mac=0;
        for (int j=0;j<input_size;j++)
        {
            mac+=input[j]*w1[j][i];
            //printf("Input[%d] = %f ; w1[%d][%d] = %f \n",j,input[j],j,i,w1[j][i]);
        }
        output_probs[i] = mac+b1[i];
    }
   // for (int k=0; k<10;k++)
     //   printf("OUtput[%d]=%f \n",k,output_probs[k]);
    idx = get_max_idx(output_probs);
    return idx;
}

int get_max_idx(float input_arr[OUTPUT_SIZE])
{
    int max_idx= 0;
    for(int i = 0;i < OUTPUT_SIZE;i++)
    {
        if (input_arr[i] > input_arr[max_idx])
            max_idx =i;
    }
    return max_idx;
}

