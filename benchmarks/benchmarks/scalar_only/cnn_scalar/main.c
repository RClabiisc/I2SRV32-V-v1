#include "header.h"

// Define top of stack
extern unsigned __stacktop;
// initial stack pointer is first address of program
__attribute__((section(".stack"), used)) unsigned *__stack_init = &__stacktop;

int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  Y[LAYER1_SIZE];       // 1 x 32 Vector Result
int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  Y2[LAYER2_SIZE];    // 2nd layer output
int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  output;       // 1 x 32 Vector Result
int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  err_count;    // Errors in a layer
extern unsigned __VREG_START, __VREG_END;   // To be 
extern unsigned __VMEM_START, __VMEM_END;

int err_limit = 0x00028F5C;
    
int main(int argc, char* argv[])
{
    /* Layer 1 and 2  :Convolution 2D + Maxpool*/
    conv2d(Y, img, ker, IMG_SIZE, bias , N_FILT_LAYER1);
#ifdef VERIFY
    err_count =0;   //Init the error counter for this layer to 0
    for(int i=0;i<LAYER1_SIZE;i++)                                     
        if( (( Y[i] - expected_output[i]) > err_limit) || ((Y[i] - expected_output[i]) < -err_limit))
           err_count++;           
#endif    
    /* Layer 3 and 4  :Convolution 2D + Maxpool*/
    layer2(Y2, Y,  ker2, 13     , bias2, N_FILT_LAYER2, N_DIM_LAYER2);
#ifdef VERIFY
    err_count =0;   //Init the error counter for this layer to 0
    for(int i=0;i<LAYER2_SIZE;i++)                                     
        if( (( Y2[i] - expected_output2[i]) > err_limit) || ((Y2[i] - expected_output2[i]) < -err_limit))
           err_count++;                                              
#endif
    /* Layer 5  :Fully Connected layer*/
    output  = layer3( Y2, w3, 800, bias3, 10);

    return 0;
}

void ISR5_uart()
{
}
void ISR6_addr_exception()
{
}

