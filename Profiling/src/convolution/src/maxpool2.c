#include "header.h"

void maxpool2_2(float input[], float output[])
{
    int op_offset;

    int e1,e2,e3,e4;

    // Maxpool Operation on output_layer
    for (int row=0; row<MAXPOOL2_DIM1;row++)
    {
        for (int col=0;col<MAXPOOL2_DIM2;col++)
        {
            for (int depth=0; depth<MAXPOOL2_DIM3;depth++)
            {
                e1 =  row*2*(CONV2_DIM2)*(CONV2_DIM3) + col*2*(CONV2_DIM3) + depth;    //00
                e2 =  row*2*(CONV2_DIM2)*(CONV2_DIM3) + (col*2 + 1)*(CONV2_DIM3) + depth;//01
                e3 =  (row*2 + 1)*(CONV2_DIM2)*(CONV2_DIM3) + col*2*(CONV2_DIM3) + depth;   //10
                e4 =  (row*2 + 1)*(CONV2_DIM2)*(CONV2_DIM3) + (col*2 + 1)*(CONV2_DIM3) + depth;//11

                op_offset = row*(MAXPOOL2_DIM2)*(MAXPOOL2_DIM3) + col*(MAXPOOL2_DIM3) + depth;
                output[op_offset] = max4(input[e1],input[e2],input[e3],input[e4]);
            }
        }
    }
}

                                                               
