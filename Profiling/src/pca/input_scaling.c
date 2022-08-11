#include "header.h"

void scaler(float inp[],float scaled[])
{
    for (int i=0;i<INPUT_SIZE;i++)
    {
        if (feature_sd[i] !=0)
        {
            scaled[i] = (inp[i] - feature_mean[i])/ feature_sd[i];
        }
        else
        {
            scaled[i] = inp[i];
        }
    }
}
