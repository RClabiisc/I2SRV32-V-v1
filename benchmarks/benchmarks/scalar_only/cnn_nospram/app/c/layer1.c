// ----------------------------------------------------------------------
// Created  : 14th May 2021
// Engineer : Naveen Chander
// Research : DESE, IISc
// RV32IM Vector Assembly for Convolution + Maxpool2 of 32 x 32 Matrix with a 3 x 3 Kernel with 16 such filters
// Function Prototype
// void* conv2d(int output[13][13][16], int matrix[28][28], int kernel[3][3][16], int matsize, int bias[16], int n_filters);
// a0 : Output Address
// a1 : Input Matrix Address
// a2 : Input kernel Address
// a3 : Size of Matrix 
// a4 : Input Bias
// a5 : Number of Filters
// ----------------------------------------------------------------------
// 
// ----------------------------------------------------------------------
#include "header.h"
#include<stdio.h>
void conv2d(int output[13*13*16], int matrix[28*28], int kernel[3*3*16], int matsize, int bias[16], int n_filters)
{
    int acc1, acc2, acc3, acc4, max;
    int mat_offset1, mat_offset2,mat_offset3, mat_offset4, ker_offset, out_offset;
    for(int row=0;row<13;row++){
        for(int col=0;col<13;col++){
            out_offset=16*(13*row+col);
            for(int dim=0;dim<16;dim++){
                acc1=0;
                acc2=0;
                acc3=0;
                acc4=0;
                for(int k_row=0; k_row<3; k_row++){
                    for(int k_col=0;k_col<3;k_col++){
                        mat_offset1=(28*(2*row+k_row)  +(2*col+k_col));
                        mat_offset2=(28*(2*row+k_row  )+(2*col+1+k_col));
                        mat_offset3=(28*(2*row+1+k_row)+(2*col+k_col));
                        mat_offset4=(28*(2*row+1+k_row)+(2*col+1+k_col));
                        ker_offset=48*k_row+16*k_col+dim;
                        //printf("row : %d : col : %d : dim : %d, k_row : %d : k_col : %d | MAT_OFFSET : %d %d %d %d | KER_OFFSET : %d | OUT_OFFSET : %d\n", row, col, dim, k_row, k_col, mat_offset1, mat_offset2, mat_offset3, mat_offset4, ker_offset, out_offset );
                        acc1+=matrix[mat_offset1] * kernel[ker_offset];
                        acc2+=matrix[mat_offset2] * kernel[ker_offset];
                        acc3+=matrix[mat_offset3] * kernel[ker_offset];
                        acc4+=matrix[mat_offset4] * kernel[ker_offset];
                    }
                }
                /* Find the max of acc1[dim], acc2[dim], acc3[dim] and acc4[dim]*/
                max=acc1;
                if(acc2>max)
                    max=acc2;
                if(acc3>max)
                    max=acc3;
                if(acc4>max)
                    max=acc4;
                /* Add Bias and ReLu and Store Output*/
                max = max + bias[dim];
                if(max > 0)
                    output[out_offset+dim] = max;
                else
                    output[out_offset+dim] = 0;
            }
        }
    }
}

