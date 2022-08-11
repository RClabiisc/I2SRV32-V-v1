#include "header.h"

void vmatmul(float vect[], float mat[],int vdim, int mat_dim2, float res[])
{
    // Multiply [ 1 x dim1] x [dim1 x dim2]
    //int mat_offset;
    float mac;
//    float prod, mult_1, mult_2;
    for (int i=0;i<mat_dim2;i++)
    {
        mac=0;
        for(int j=0;j<vdim;j++)
        {
            mac += vect[j] * (*(mat + mat_dim2*j + i)); 
        }
        *(res+i) = mac;   //store result into product
    }
}

void vadd2(float a[],float b[],int dim,float y[])
{
    for (int i=0;i<dim;i++)
    {
        *(y + i) = *(a + i) + *(b + i);
    }
}

int get_max_idx(float input[])
{
    int max_idx= 0;
    for(int i = 0;i < OUTPUT_SIZE; i++)
    {
        if ( (*(input + i)) > (*(input + max_idx)) )
            max_idx =i;
    }
    return max_idx;
}
float max4(float e1, float e2, float e3, float e4)
{
    float max_val = e1;
    if( e2 > e1 )
        max_val=e2;
    if(e3 > max_val)
        max_val = e3;
    if(e4 > max_val)
        max_val = e4;
    return max_val;
}
float relu(float num)
{
    if(num>0)
        return num;
    else
        return 0;
}

