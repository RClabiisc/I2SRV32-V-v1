#include "header.h"


void conv2d_1(float img[], float filter[], float bias[], float output[])
{
    //----------------------------Convolution----------------------------------
    //-------------------------------------------------------------------------
    float sum;
    int filt_offset,img_offset,layer_output_offset;
    for (int output_row=0;output_row<CONV1_DIM1;output_row++)
    {
        for(int output_col=0;output_col<CONV1_DIM2;output_col++)
        {
            for(int output_depth=0;output_depth<CONV1_DIM3;output_depth++)
            {
                sum=0;
                //----------------------------Inner Loop:Acc --------------------
                for(int x=0;x<FILT1_DIM1;x++)
                {
                    for(int y=0;y<FILT1_DIM2;y++)
                    {
                        for(int z=0;z<FILT1_DIM3;z++)
                        {
                        filt_offset = x*((FILT1_DIM2)*(FILT1_DIM3)*(FILT1_DIM4))\
                                    + y*((FILT1_DIM3)*(FILT1_DIM4))\
                                    + z*(FILT1_DIM4)\
                                    + output_depth;

                        img_offset  = (output_row+x)*((IMG_DIM2)*(IMG_DIM3))\
                                    + (output_col+y)*(IMG_DIM3)\
                                    + z;

                        sum+= filter[filt_offset] * img[img_offset];
                        }
                    }
                }
                //------------------------------Inner Loop Ends----------------
            layer_output_offset = output_row*((CONV1_DIM2)*(CONV1_DIM3))\
                    + output_col*(CONV1_DIM3) \
                    + output_depth;
            output[layer_output_offset] = relu(sum+bias[output_depth]);

            //---------------------------Matrix Output Print-------------------------------------------
            }
        }
    }
 }
