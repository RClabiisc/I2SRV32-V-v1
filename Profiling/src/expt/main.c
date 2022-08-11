#include <stdio.h>
#include "header.h"


int main()
{   
    float a[TEN]={1,2,3,4,5,6,7,8,9,10};
    float b[10]={11,12,13,14,15,16,17,18,19,20};
    float c[10];
    float d[10];
    int a_dim=10;
    int b_dim=10;
    State inp;
    State out;
    State *input  = &inp;
    State *output = &out;
    input->a=&a;
    input->b=&b;
    input->a_dim=a_dim;
    input->b_dim=b_dim;
    output->a=&c;
    output->b=&d;
    output->a_dim=a_dim;
    output->b_dim=b_dim;
    printf("Structure:--\n");
    printf("Address of a is %p\n",input->a);
    vecadd2(input,output);
    printf("Outputs:\n");
    for (int i=0;i<10;i++)
    {

        printf("a[%d] + b[%d] = %f\n",i,i,*((float *)(output->a) + i));
        printf("a[%d] - b[%d] = %f\n",i,i,*((float *)(output->b) + i));
    }
    vadd2(a,b,a_dim,c);
    printf("Outputs_2:\n");
    for (int i=0;i<10;i++)
    {

        printf("a[%d] + b[%d] = %f\n",i,i,c[i]);
    }
    return 0;
}

void vecadd2(State* inp, State *out)
{
    //printf("Input a is %p\n",inp->a);
    
    //Unpack
    int a_dim=inp->a_dim;
    //int b_dim=inp->b_dim;

    //Output Creator
    
    for(int i=0;i<a_dim;i++)
    {
        *((float *)(out->a) + i) = *((float *)(inp->a) + i) + *((float *)(inp->b) + i);
        *((float *)(out->b) + i) = *((float *)(inp->a) + i) - *((float *)(inp->b) + i);
    }
    
}

void vadd2(float a[],float b[],int dim,float y[])
{
    for (int i=0;i<dim;i++)
    {
        add(a,b,y);
        //*(y + i) = *(a + i) + *(b + i);
    }
}
void add(float a[],float b[],float y[])
{
    for (int i=0;i<10;i++)
    {
        *(y + i) = *(a + i) + *(b + i);
    }
}
