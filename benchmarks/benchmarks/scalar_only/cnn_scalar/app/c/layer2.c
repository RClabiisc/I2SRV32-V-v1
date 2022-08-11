//----------------------------------------------------------------------
//Created  : 13th May 2021
//Engineer : Naveen Chander
//Research : DESE, IISc
//Convolution + maxpool 2 {Layers 3 and 4}
//RV32IM Vector Assembly for Convolution + Maxpool2 of 13 x 13 x 16 Matrix with a 3 x 3 x 16  Kernel with 32 such filters
//Function Prototype
//void* layer2(int output[5][5][32], int matrix[13][13][16], int kernel[3][3][16][32], int matsize, int bias[32], int n_filters, int n_filt_dim);
//a0 : Output Address
//a1 : Input Matrix Address
//a2 : Input kernel Address
//a3 : Size of Matrix 
//a4 : Input Bias
//a5 : Number of Filters
//a6 : Input Matrix Dimension
//----------------------------------------------------------------------
//Loop Variables : t0 : i --> Loops through Rows of the Output matrix   0 .. a7
//                 t1 : j --> Loops through Cols of the OUtput Matrix   0 .. a7
//                 t4 : k --> Loops through Filters of the Input Matrix 0 .. a6 
//                 s11: x --> Loops through Rows of the Kernel          0 .. 2 
//----------------------------------------------------------------------
#include "header.h"

void layer2(int output[5*5*32], int matrix[13*13*16], int kernel[3*3*16*32], int matsize, int bias[32], int n_filters, int n_filt_dim)
{
    int acc1, acc2, acc3, acc4, max;
    int  mat_offset1, mat_offset2,mat_offset3, mat_offset4, ker_offset, out_offset;
    for(int row=0;row<5;row++){
        for(int col=0;col<5;col++){
            out_offset=32*(5*row+col);
            for(int filt_dim=0;filt_dim<32;filt_dim++){
                acc1=0;
                acc2=0;
                acc3=0;
                acc4=0;
                for(int img_dim=0; img_dim<16;img_dim++){
                    for(int k_row=0; k_row<3; k_row++){
                        for(int k_col=0;k_col<3;k_col++){
                            mat_offset1=16*(13*(2*row+k_row)  +(2*col+k_col)) + img_dim;
                            mat_offset2=16*(13*(2*row+k_row  )+(2*col+1+k_col)) + img_dim;
                            mat_offset3=16*(13*(2*row+1+k_row)+(2*col+k_col)) + img_dim;
                            mat_offset4=16*(13*(2*row+1+k_row)+(2*col+1+k_col)) + img_dim;
                            ker_offset=1536*k_row+512*k_col+32*img_dim+filt_dim;
                            acc1+=matrix[mat_offset1] * kernel[ker_offset];
                            acc2+=matrix[mat_offset2] * kernel[ker_offset];
                            acc3+=matrix[mat_offset3] * kernel[ker_offset];
                            acc4+=matrix[mat_offset4] * kernel[ker_offset];
                        }
                    }
                }
                /* Find the max of acc1[filt_dim], acc2[filt_dim], acc3[filt_dim] and acc4[filt_dim]*/
                max = acc1;
               if(acc2>max)
                    max=acc2;
                if(acc3>max)
                    max=acc3;
                if(acc4>max)
                    max=acc4;
                /* Add Bias and ReLu and Store Output*/
                max = max + bias[filt_dim];
                if(max > 0)
                    output[out_offset+filt_dim] = max;
                else
                    output[out_offset+filt_dim] = 0;
            }
        }
    }
}
