#include "header.h"
#include "uart_lib.h"

// Define top of stack
extern unsigned __stacktop;
// initial stack pointer is first address of program
__attribute__((section(".stack"), used)) unsigned *__stack_init = &__stacktop;

int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  Y[LAYER1_SIZE];       // 1 x 32 Vector Result
int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  output;       // 1 x 32 Vector Result

int __attribute__((aligned(32))) __attribute__((section(".vmem_data")))  err_count;    // Errors in a layer
extern unsigned __VREG_START, __VREG_END;   // To be 
extern unsigned __VMEM_START, __VMEM_END;

    
    int img_buf[IMG_SIZE*IMG_SIZE];
    int recv_counter = 0;
    int recv_num_counter = 0;
    char read_val;
    int  pflag=0;
    char header_count = 0;
    char start_read = 0;
    int digit_classified;
    char welcome_msg[] ="*******************UART Terminal ***************** \
    \n Waiting for UART packets...\n\
    ****************************************************************************\n";

int main(int argc, char* argv[])
{
    // Initiallize UART
    UART_init(57600,1);
    // Put Welcome Message on UART
//	UARTCharPut('N');
    //Run Benchmark Program
    conv2d_5(Y, img, ker, IMG_SIZE);
    // Verify Results
    //int err_limit = 0x00028F5C;
    int err_limit = 10;
    err_count =0;   //Init the error counter for this layer to 0
    for(int i=0;i<LAYER1_SIZE;i++)                                     
        if( (( Y[i] - expected_output[i]) > err_limit) || ((Y[i] - expected_output[i]) < -err_limit))
           err_count++;                                              
    return 0;
}

void ISR5_uart()
{
       read_val = (*(volatile char *)((uint32_t)(UART_REG_RB)));     // Read the next character from the UART
       UARTCharPut(read_val);
       // Store the image into Global Buffer
       recv_counter++;
       if (start_read == 0)
       {
           // Header Decoding STate Machine
           if(header_count ==0)
           {
               if(read_val == 0xAA)
               {
                   header_count = 1;
                   start_read =0;
               }
               else
               {
                   header_count = 0;
                   start_read =0;
               }
           }
           else if(header_count==1)
           {
               if(read_val == 0x55)
               {
                   header_count = 2;
                   start_read = 0;
               }
               else
               {
                   header_count = 0;
                   start_read = 0;
               }
           }
           else if(header_count ==2)
           {
               if(read_val == 0xBB)
               {
                   header_count = 3;
                   start_read = 0;
               }
               else
               {
                   header_count = 0;
                   start_read = 0;
               }
           }
           else if(header_count ==3)
           {
               if(read_val == 0x66)
               {
                   header_count = 4;
                   start_read = 1;
               }
               else
               {
                   header_count = 0;
                   start_read = 0;
               }
           }
       }
       else
       {
           img_buf[recv_num_counter]=((int )read_val)<<16;  // Q24.8 Format : For inputs <1
           recv_num_counter++;
       }
       //-------------------------------------------------------------//
       // Check for full buffer
       if (recv_num_counter==IMG_SIZE*IMG_SIZE)
       {
               pflag=1;
               recv_num_counter=0;
               recv_counter=0;
               start_read=0;
               header_count=0;
        }
        else
               pflag=0;
    
}
void ISR6_addr_exception()
{
}

