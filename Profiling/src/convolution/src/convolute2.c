#include "header.h"

void conv2d_2(float img[], float filter[], float bias[], float output[])
{
    float sum;
    int filt_offset,img_offset,layer_output_offset;
    //----------------------------Convolution----------------------------------
    //-------------------------------------------------------------------------
    for (int output_row=0;output_row<CONV2_DIM1;output_row++)
    {
        for(int output_col=0;output_col<CONV2_DIM2;output_col++)
        {
            for(int output_depth=0;output_depth<CONV2_DIM3;output_depth++)
            {
                sum=0;
                //----------------------------Inner Loop:Acc --------------------
                for(int x=0;x<FILT2_DIM1;x++)
                {
                    for(int y=0;y<FILT2_DIM2;y++)
                    {
                        for(int z=0;z<FILT2_DIM3;z++)
                        {
                        filt_offset = x*((FILT2_DIM2)*(FILT2_DIM3)*(FILT2_DIM4))\
                                    + y*((FILT2_DIM3)*(FILT2_DIM4))\
                                    + z*(FILT2_DIM4)\
                                    + output_depth;

                        img_offset  = (output_row+x)*((MAXPOOL1_DIM2)*(MAXPOOL1_DIM3))\
                                    + (output_col+y)*(MAXPOOL1_DIM3)\
                                    + z;

                        sum+= filter[filt_offset] * img[img_offset];
                        }
                    }
                }
                //------------------------------Inner Loop Ends----------------
            layer_output_offset = output_row*((CONV2_DIM2)*(CONV2_DIM3))\
                    + output_col*(CONV2_DIM3) \
                    + output_depth;
            output[layer_output_offset] = relu(sum+bias[output_depth]);

            //---------------------------Matrix Output Print-------------------------------------------
            }
        }
    }
 }
