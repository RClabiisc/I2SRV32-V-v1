#include "header.h"

double ***conv2d_1( double **img, double ***filter, double bias)
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

    double sum;
    int dim1= 24;
    int dim2=24;
    int dim3=32;
    int i,j;
    double ***layer_output = (double ***)malloc(dim1*sizeof(double**));

        for (i = 0; i< dim1; i++) {

         layer_output[i] = (double **) malloc(dim2*sizeof(double *));

          for (j = 0; j < dim2; j++) {

              layer_output[i][j] = (double *)malloc(dim3*sizeof(double));
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
                            sum+= (*((double *)filter + filt_offset)) * (*((double *)img + img_offset));
                        }
                    }
                }
	    	layer_output_offset = output_row*(output_col_size*output_depth_size)	\
				    + output_col*(output_depth_size) \
				    + output_depth;
            	*((double *)layer_output+layer_output_offset)= relu(sum+bias[output_depth]);
            }
        }
    }
    return layer_output;
}


        
            
    
    
