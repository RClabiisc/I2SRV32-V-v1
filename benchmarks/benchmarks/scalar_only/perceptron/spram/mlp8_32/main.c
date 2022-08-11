#include "header.h"

// Define top of stack
extern unsigned __stacktop;
// initial stack pointer is first address of program
__attribute__((section(".stack"), used)) unsigned *__stack_init = &__stacktop;
int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  err_count;    // Errors in a layer

int Y[N_NEURONS];
int err_limit=10;
int main(int argc, char* argv[])
{
    int sum =0;
    for (int i=0; i <N_NEURONS; i++)
    {
        sum=0;
        for (int j=0; j<INP_SIZE; j++)
            sum+=inp[j]*weights[N_NEURONS*j+i];
        ///////////////////////////////////////
        //Add Bias
        Y[i] = sum + bias[i];
        // Apply ReLu activation
        if (sum >0)
            Y[i] = Y[i];
        else
            Y[i] =0;
    }
    // Verify Output
#ifdef VERIFY
    err_count = 0;
    for(int i=0;i<N_NEURONS;i++)
    {
        if( (( Y[i] - expected_output[i]) > err_limit) || ((Y[i] - expected_output[i]) < -err_limit))
        {
            err_count++;
        }
    }
#endif
    return 0;
}

void ISR5_uart()
{
}
void ISR6_addr_exception()
{
}

