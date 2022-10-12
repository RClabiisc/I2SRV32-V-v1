#ifndef __H
#define __H


// Model Sizes
#define INP_SIZE 256
#define N_NEURONS 8 
#define IMG_SIZE 4
// UART Related Defines //
#define Baud_1M 1500000
#define UART_REG_RB  0x5F1006F0
#define LED_ADDR 0x5F100780
#define PWM_DC_REG 0x5F100800
#define ADC_REG 0x5F100804
#define REG_1 0x5F1007fc
#define REG_2 0x5F1007e0
#define BUZZER_REG 0x5F100810

#define UART_REG_RB  0x5F1006F0
#define UART_REG_LS  0x5F1006F6

//////////////////////////////////
// Model Related GlobVars
//////////////////////////////////
extern int inp[INP_SIZE];
extern int weights[INP_SIZE*N_NEURONS];
extern int bias[N_NEURONS];
extern int expected_output[N_NEURONS];

//////////////////////////////////
// UART Acqusition ISR Related GlobVars
//////////////////////////////////
extern int img_buf[IMG_SIZE*IMG_SIZE];
extern int recv_counter;
extern int recv_num_counter;
extern char read_val;
extern int pflag;
extern char header_count;
extern char start_read;
extern int digit_classified;


//////////////////////////////////
// Function Declaration 
//////////////////////////////////
// main function
int main(int argc, char* argv[]);

void perceptron(int Y[N_NEURONS],int inp[INP_SIZE], int weights[INP_SIZE*N_NEURONS], int inp_size,int n_neurons,int bias[N_NEURONS]);
// ISR Related Functions
void ISR6_addr_exception();
void ISR5_uart();    // UART Receive Interrupt handler
#endif
