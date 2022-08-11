#include "header.h"

void print3DMat(Matrix3D* mat)
{
    int offset;
    int dim1_max=mat->dim1;
    int dim2_max=mat->dim2;
    int dim3_max=mat->dim3;


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
                printf("%f ",*((mat->data)+offset));
            }
            printf("===============================\n");
        }
        printf("\n");
    }
}
