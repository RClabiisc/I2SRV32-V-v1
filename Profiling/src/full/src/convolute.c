#include "header.h"

Matrix3D* conv2d(Matrix3D *img, Matrix4D *filter, float bias[])
{
    //Extract Dimensions of Input Matrices
    //1. img
    int img_dim1=img->dim1;
    int img_dim2=img->dim2;
    int img_dim3=img->dim3;
    //2. filter
    int filter_dim1=filter->dim1;
    int filter_dim2=filter->dim2;
    int filter_dim3=filter->dim3;
    int filter_dim4=filter->dim4;
    //Define Output Dimensions
    // Formula : dim_op = dim_ip - dim_filt + 1 in row and col , dim4 of filter = depth of output
    int output_row_size   = img_dim1 - filter_dim1 + 1;
    int output_col_size   = img_dim2 - filter_dim2 + 1;
    int output_depth_size = filter_dim4 ;
    
    int filt_offset,img_offset,layer_output_offset;
    // Create Matrix for Layer Output
    Matrix3D *layer_output = (Matrix3D *)malloc( sizeof(layer_output)\
                           + 3*sizeof(int)\
                           + output_row_size*output_col_size*output_depth_size*sizeof(float));

    layer_output->dim1 = output_row_size;
    layer_output->dim2 = output_col_size;
    layer_output->dim3 = output_depth_size;


    //----------------------------Convolution----------------------------------
    //-------------------------------------------------------------------------
    float sum;
    for (int output_row=0;output_row<output_row_size;output_row++)
    {
        for(int output_col=0;output_col<output_col_size;output_col++)
        {
            for(int output_depth=0;output_depth<output_depth_size;output_depth++)
            {
                sum=0;
                //----------------------------Inner Loop:Acc --------------------
                for(int x=0;x<filter_dim1;x++)
                {
                    for(int y=0;y<filter_dim2;y++)
                    {
                        for(int z=0;z<filter_dim3;z++)
                        {
                        filt_offset = x*(filter_dim2*filter_dim3*filter_dim4)\
                                    + y*(filter_dim3*filter_dim4)\
                                    + z*filter_dim4\
                                    + output_depth;

                        img_offset  = (output_row+x)*(img_dim2*img_dim3)\
                                    + (output_col+y)*img_dim3\
                                    + z;

                        sum+= (*((float *)(filter->data) + filt_offset)) * (*((float *)(img->data) + img_offset));
                        }
                    }
                }
                //------------------------------Inner Loop Ends----------------
            layer_output_offset = output_row*(output_col_size*output_depth_size)\
                    + output_col*(output_depth_size) \
                    + output_depth;

            *((float *)(layer_output->data)+layer_output_offset)= relu(sum+bias[output_depth]);
            //---------------------------Matrix Output Print-------------------------------------------
            }
        }
    }
    return layer_output;

 }
