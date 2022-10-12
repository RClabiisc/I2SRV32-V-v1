#include "header.h"
//#include "uart_lib.h"

// Define top of stack
extern unsigned __stacktop;
// initial stack pointer is first address of program
__attribute__((section(".stack"), used)) unsigned *__stack_init = &__stacktop;

int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  y_mat[MAT_SIZE];       // 1 x 32 Vector Result

int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  err_count;    // Errors in a layer
extern unsigned __VREG_START, __VREG_END;   // To be 
extern unsigned __VMEM_START, __VMEM_END;

int main(int argc, char* argv[])
{
    matmul32(y_mat, a_mat, b_mat, MAT_DIM);
    // Verify Results
    //int err_limit = 0x00028F5C;
    int err_limit = 10;
    err_count =0;   //Init the error counter for this layer to 0
    for(int i=0;i<MAT_SIZE;i++)                                     
        if( (( y_mat[i] - expected_output[i]) > err_limit) || ((y_mat[i] - expected_output[i]) < -err_limit))
           err_count++;                                              
    return 0;
}

void ISR5_uart()
{
    
}
void ISR6_addr_exception()
{
}

