#include "header.h"

void vmatmul(float vect[], float mat[],int vdim, int mat_dim2, float res[])
{
    // Multiply [ 1 x dim1] x [dim1 x dim2]
    int mat_offset;
    float mac;
    float prod, mult_1, mult_2;
    for (int i=0;i<mat_dim2;i++)
    {
        mac=0;
        for(int j=0;j<vdim;j++)
        {
            //mat_offset = mat_dim2*i + j;
            //mat_offset = compute_offset2D(mat_dim2,j,i);            
            // Compute Matrix Offset
            //mult_1 = vect[j];
            //mult_1 = *(vect + j);
            //mult_2 = mat[mat_offset];
            //prod = mult_1*mult_2;
            //mult_2 = *(mat + mat_offset);
            //prod = multiplication(mult_1, mult_2);
            //prod = multiplication(vect[j],*(mat + mat_offset));
            mac += vect[j] * (*(mat + mat_dim2*i + j)); 
            //mac+=prod;
            //mac += vect[j] * (*(mat + mat_offset)); 
        }
        *(res+i) = mac;   //store result into product
    }
}

float multiplication(float a, float b)
{
    return a*b;
}

int compute_offset2D(int dim2,int a,int b)
{
    return a*dim2+b;
}

//////////////////////////Extras


/*        
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
*/

/*
void vadd2(float a[],float b[],int dim,float y[])
{
    for (int i=0;i<dim;i++)
    {
        *(y + i) = *(a + i) + *(b + i);
    }
}

int compute_offset2D(int dim2,int a,int b)
{
    return a*dim2+b;
}

void sigmoid(float x[], int dim, float y[])
{
    float exponent;
    for(int i=0; i<dim; i++)
    {
        exponent=expf(*(x + i) );
        *(y + i) = exponent/(1+exponent);
    }
}


void tanhyp(float x[], int dim, float y[])
{
    float x_2;      //2x
    float exponent;
    for(int i=0; i<dim; i++)
    {
        x_2 = 2 * (*(x + i)) ;
        exponent=expf(x_2);
        *(y + i) = (exponent - 1)/(1 + exponent);
    }
}

void hadamard_product(float a[], float b[], int dim, float y[])
{
    for (int i=0;i<dim;i++)
    {   
        *(y + i) = (*(a + i)) * (*(b + i));
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
*/
