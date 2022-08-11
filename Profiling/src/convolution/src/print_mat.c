#include "header.h"

void print3DMat(float mat[], int dim1_max, int dim2_max, int dim3_max)
{
    int offset;

    for (int i=0;i<dim1_max;i++)
    {
        for (int j=0;j<dim2_max;j++)
        {
            printf("Element[%d][%d][] =========\n ",i,j);
            for(int k=0;k<dim3_max;k++)
            {
                offset= (i*dim2_max*dim3_max)\
                      + (j*(dim3_max))\
                      + k;
                printf("%f ",mat[offset]);
            }
            printf("===============================\n");
        }
        printf("\n");
    }
}
