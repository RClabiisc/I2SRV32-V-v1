#include "header.h"

float ***conv2d_1(float img[][28][1], float filter[][5][1][32], float bias[])
{
    int filt_offset,img_offset,layer_output_offset;
    int output_row,output_col,output_depth;
    int output_row_size = 24;
    int output_col_size = 24;
    int output_depth_size = 32;

    int x,y,z;
    int x_max=5;
    int y_max=5;
    int z_max=1;

    float sum;
    int dim1= 24;
    int dim2=24;
    int dim3=32;
    int i,j;
    float ***layer_output = (float ***)malloc(dim1*sizeof(float**));

        for (i = 0; i< dim1; i++) {

         layer_output[i] = (float **) malloc(dim2*sizeof(float *));

          for (j = 0; j < dim2; j++) {

              layer_output[i][j] = (float *)malloc(dim3*sizeof(float));
          }

        }

    

    for (output_row=0;output_row<output_row_size;output_row++)
    {
        for(output_col=0;output_col<output_col_size;output_col++)
        {
            for(output_depth=0;output_depth<output_depth_size;output_depth++)
            {
                sum=0;
                for(x=0;y<x_max;x++)
                {
                    for(y=0;y<y_max;y++)
                    {
                        for(z=0;z<z_max;z++)
                        {
			    filt_offset = x*(y_max*z_max*output_depth_size)\
				    	+ y*(z_max*output_depth_size)\
					+ z*output_depth_size\
					+ output_depth;
			    img_offset  = (output_row+x)*(28*1) + (output_col+y)*1+z;
                            sum+= (*((float *)filter + filt_offset)) * (*((float *)img + img_offset));
                        }
                    }
                }
	    	layer_output_offset = output_row*(output_col_size*output_depth_size)	\
				    + output_col*(output_depth_size) \
				    + output_depth;
            	*((float *)layer_output+layer_output_offset)= relu(sum+bias[output_depth]);
            }
        }
    }
    return layer_output;
}


        
            
    
    
