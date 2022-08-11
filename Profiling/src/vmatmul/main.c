#include "header.h"
#include <stdio.h>
int main()
{
    float vec[VEC_SIZE];
    float mat[MAT_SIZE];
    float prod[MAT_DIM_2];
    //Initiallizing vec
    for (int i = 0;i<VEC_SIZE;i++)
        vec[i]=1;
    //Init mat
    for (int j = 0;j < MAT_SIZE; j++)
       mat[j]= 1; 

    vmatmul(vec,mat,VEC_SIZE,MAT_DIM_2,prod);
    for (int i =0;i<MAT_DIM_2;i++)
        printf("%f ",prod[i]);
    printf("\n");
    return 0;
}

