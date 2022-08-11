#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "header.h"

int main()
{
    float ***conv_op;
    int offset;
    int count=0;
    conv_op = conv2d_1(img,filter,bias);
    for (int i=0;i<24;i++)
        for (int j=0;j<24;j++)
        {
            printf("{");
            for(int k=0;k<32;k++)
            {   
                offset = i*24*32+j*32+k;
                count+=1;
                printf("Element [%d][%d][%d] : %f \n ",i,j,k, *((float *)conv_op+offset));
                //printf("%f ",*((float *)conv_op+offset));
            }
            printf("} ");
        }
    printf("\n");
    return 0;
}


