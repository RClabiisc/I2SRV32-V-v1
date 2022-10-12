#include "header.h"

// Define top of stack
extern unsigned __stacktop;
// initial stack pointer is first address of program
__attribute__((section(".stack"), used)) unsigned *__stack_init = &__stacktop;

int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  Y[N_NEURONS];       // 1 x 32 Vector Result
//int Y[N_NEURONS];
int main(int argc, char* argv[])
{
    perceptron(Y, inp, weights, INP_SIZE, N_NEURONS,bias);
    return 0;
}

void ISR5_uart()
{
}
void ISR6_addr_exception()
{
}

