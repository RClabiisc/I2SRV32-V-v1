#include "header.h"

/*float activation(float val)
{
    float output;
    //relu activation
    if(val >=0)
        output = val;
    else
        output = 0;
    return output;
}*/

int get_max_idx(float input_arr[LAYER3_SIZE])
{
    int max_idx= 0;
    for(int i = 0;i < LAYER3_SIZE;i++)
    {
        if (input_arr[i] > input_arr[max_idx])
            max_idx =i;
    }
    return max_idx;
}

float activation(float val)
{
    float output;
    //sigmoid activtion
    float exponent=expf(val);
    output = (exponent/(1+exponent));
    return output;
}
