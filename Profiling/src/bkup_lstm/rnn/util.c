#include "header.h"

Vec* vmatmul(Vec *vect, Matrix2D *mat)
{
    // Multiply [ 1 x dim1] x [dim1 x dim2]
    int dim1=mat->dim1;
    int dim2=mat->dim2;
    int prod_size=dim2; 
    int mat_offset=0;
    Vec *prod = (Vec *)malloc(prod_size*sizeof(float));
    prod->dim=prod_size;
    float mac;
    for (int i=0;i<prod_size;i++)
    {
        mac=0;
        for(int j=0;j<dim1;j++)
        {
            mat_offset= compute_offset2D(dim2,j,i);                              // Compute Matrix Offset
            mac+= *((float *)(vect->data) + j) * (*( (float *)(mat->data) + mat_offset ));     //MAC operation
        }
        *((float *)(prod->data) + i) = mac;   //store result into product
    }
    return prod;
}

        
Matrix2D* matmul(Matrix2D *a, Matrix2D *b)
{
    // Matrix Multiplication of 2 x 2D Matrices of any dimension
    int a_dim1=a->dim1;
    int a_dim2=a->dim2;
    //int b_dim1=b->dim1;
    int b_dim2=b->dim2;

    int prod_size=a_dim1*b_dim2;

    int a_offset,b_offset,prod_offset;
    float mac=0;
    // Allocate Memory for product
    Matrix2D *prod = (Matrix2D *) malloc(sizeof(prod) + 2*sizeof(int) + prod_size*sizeof(float));
    
    prod->dim1=a_dim1;   //Define dimensions of product
    prod->dim2=b_dim2;

    for (int row=0; row<a_dim1; row++)
    {
        for (int col=0; col<a_dim2; col++)
        {
            mac=0;
            prod_offset=compute_offset2D(b_dim2,row,col);
            for (int k=0; k<a_dim2; k++)
            {
                a_offset=compute_offset2D(a_dim2,row,k);
                b_offset=compute_offset2D(b_dim2,k,col);
                mac+=(*((float *)(a->data) + a_offset)) * (*((float *)(b->data) + b_offset));
            }
            *((float *)(prod->data)+prod_offset)=mac;
        }
    }
    return prod;
}

Vec* vadd2(Vec *a,Vec *b)
{
    int size=a->dim;
    Vec* sum=(Vec *) malloc(sizeof(Vec) + sizeof(int) + size*sizeof(float));
    sum->dim=size;
    for (int i=0;i<size;i++)
    {
        *((float *)(sum->data)+i) = (*((float *)(a->data)+i)) + (*((float *)(b->data)+i));
    }
    return sum;
}

int compute_offset2D(int dim2,int a,int b)
{
    return a*dim2+b;
}

Vec* sigmoid(Vec *x)
{
    float exponent;
    int size=x->dim;
    Vec *y = (Vec *) malloc(sizeof(Vec) + sizeof(int) + size*sizeof(float));
    y->dim = size;
    for(int i=0; i<size; i++)
    {
        exponent=expf(*((float *)(x->data) + i) );
        *((float *)(y->data) + i) = exponent/(1+exponent);
    }
    return y;
}


Vec* tanhyp(Vec *x)
{
    float x_2;      //2x
    float exponent;
    int size=x->dim;
    Vec *y = (Vec *) malloc(sizeof(Vec) + sizeof(int) + size*sizeof(float));
    y->dim = size;
    for(int i=0; i<size; i++)
    {
        x_2 = 2 * (*((float *)(x->data) + i)) ;
        exponent=expf(x_2);
        *((float *)(y->data) + i) = (exponent - 1)/(1 + exponent);
    }
    return y;
}

Vec* hadamard_product(Vec *a, Vec *b)
{
    int size=a->dim;
    Vec* dot=(Vec *) malloc(sizeof(Vec) + sizeof(int) + size*sizeof(float));
    dot->dim=size;
    for (int i=0;i<size;i++)
    {   
        *((float *)(dot->data)+i) = (*((float *)(a->data)+i)) * (*((float *)(b->data)+i));
    }
    return dot;
}

int get_max_idx(Vec *input)
{
    int max_idx= 0;
    int size = input->dim;
    for(int i = 0;i < size;i++)
    {
        if ( (*((float *)(input->data) + i)) > (*((float *)(input->data) + max_idx)) )
            max_idx =i;
    }
    return max_idx;
}

