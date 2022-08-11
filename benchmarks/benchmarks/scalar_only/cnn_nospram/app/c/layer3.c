//----------------------------------------------------------------------
//Created  : 14th May 2021
//Engineer : Naveen Chander
//Research : DESE, IISc
//MLP and Output Layer : Layer 5 and 6
//RV32IM Vector Assembly for Matrix Vector Multiplication + bias + ReLu
//Function Prototype
//void* layer3(int output, int matrix[800],int weight[800][10],int matsize ,int bias[10], int bias_size)
//a0 : Output Address
//a1 : Input Matrix Address
//a2 : Input Weight Address
//a3 : Size of Matrix 
//a4 : Input Bias
//a5 : Bias Size
//----------------------------------------------------------------------
//Loop Variables : t0 : i --> Loops through Rows of the Output matrix   0 .. a7
//                 t1 : j --> Loops through Cols of the OUtput Matrix   0 .. a7
//                 t4 : k --> Loops through Filters of the Input Matrix 0 .. a6 
//                 s11: x --> Loops through Rows of the Kernel          0 .. 2 
//----------------------------------------------------------------------
#include "header.h"
int softmax(int input_arr[LAYER3_SIZE]);

int layer3( int matrix[800],int weight[800*10],int matsize ,int bias[10], int bias_size)
{
    int acc=0;
    int layer_out[LAYER3_SIZE];
    int pre_act[LAYER3_SIZE];
    int output;
    for(int col=0; col<10; col++)
    {
        acc=0;
        for ( int row=0; row<800; row++)
        {
            acc+=matrix[row]*weight[10*row +col];
        }
        pre_act[col]=acc+bias[col];
        if(pre_act[col] >0)
            layer_out[col] = pre_act[col];
        else
           layer_out[col] = 0; 
    }
    output= softmax(layer_out);
    return output;
}
int softmax(int input_arr[LAYER3_SIZE])
{
    int max_idx= 0;
    for(int i = 0;i < LAYER3_SIZE;i++)
    {
        if (input_arr[i] > input_arr[max_idx])
            max_idx =i;
    }
    return max_idx;
}

