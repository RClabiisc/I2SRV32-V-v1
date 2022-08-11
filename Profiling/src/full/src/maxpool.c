#include "header.h"

Matrix3D* maxpool2(Matrix3D* input)
{
    int op_offset;

    float *e1,*e2, *e3, *e4;

    //Create Output 3D Array of Size = Half the size of Input Matrix.
    int input_dim1=(input->dim1);
    int input_dim2=(input->dim2);
    int input_dim3=(input->dim3);

    int dim1=(input_dim1)/2;
    int dim2=(input_dim2)/2;
    int dim3=(input_dim3);
    Matrix3D *layer_output = (Matrix3D *)malloc(sizeof(layer_output)\
                            + 3*sizeof(int)\
                            + dim1*dim2*dim3*sizeof(float));
    layer_output->dim1=dim1;
    layer_output->dim2=dim2;
    layer_output->dim3=dim3;

    //printf("Maxpool Output Dim: (%d,%d,%d)\n",layer_output->dim1,layer_output->dim2,layer_output->dim3);

    // Maxpool Operation on output_layer
    for (int row=0; row<dim1;row++)
    {
        for (int col=0;col<dim2;col++)
        {
            for (int depth=0; depth<dim3;depth++)
            {
                e1 = (float *)(input->data) + row*2*input_dim2*input_dim3 + col*2*input_dim3 + depth;    //00
                e2 = (float *)(input->data) + row*2*input_dim2*input_dim3 + (col*2 + 1)*input_dim3 + depth;//01
                e3 = (float *)(input->data) + (row*2 + 1)*input_dim2*input_dim3 + col*2*input_dim3 + depth;   //10
                e4 = (float *)(input->data) + (row*2 + 1)*input_dim2*input_dim3 + (col*2 + 1)*input_dim3 + depth;//11

                op_offset = row*dim2*dim3 + col*dim3 + depth;
                *((float *)(layer_output->data) + op_offset) = max(e1,e2,e3,e4);
                //printf("out[%d][%d][%d]=%f\n",row,col,depth,max(e1,e2,e3,e4));
                /*printf("op[%d][%d][%d]=Max(a[%d][%d][%d],a[%d][%d][%d],a[%d][%d][%d],a[%d][%d][%d])=%f\n",\
                        row,col,depth,\
                        (2*row),(2*col),depth,(2*row), (2*col+1),depth,\
                        (2*row+1),(2*col),depth, (2*row+1),(2*col+1),depth,\
                        max(e1,e2,e3,e4));*/
               /*printf("a[%d][%d][%d]=%f\t,a[%d][%d][%d]=%f\t,a[%d][%d][%d]=%f\t,a[%d][%d][%d]=%f\n",\
                        (2*row),(2*col),depth, *e1,\
                        (2*row), (2*col+1),depth, *e2,\
                        (2*row+1),(2*col),depth, *e3,\
                        (2*row+1),(2*col+1),depth, *e4);*/
               /*printf("op[%d][%d][%d]=Max([%d][%d][%d]:%f\t[%d][%d][%d]:%f\t[%d][%d][%d]:%f\t[%d][%d][%d]:%f)=%f\n",\
                        row,col,depth,\
                        (2*row),(2*col),depth, *e1,\
                        (2*row), (2*col+1),depth, *e2,\
                        (2*row+1),(2*col),depth, *e3,\
                        (2*row+1),(2*col+1),depth, *e4\
                        ,max(e1,e2,e3,e4));*/

            }
        }
    }
    return layer_output;
}

float max(float *e1, float *e2, float *e3, float *e4)
{
    float max_val = *e1;
    if( *e2 > *e1 )
        max_val=*e2;
    if(*e3 > max_val)
        max_val = *e3;
    if(*e4 > max_val)
        max_val = *e4;
    return max_val;
}
                                                               
