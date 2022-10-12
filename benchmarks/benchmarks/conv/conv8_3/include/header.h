#ifndef __H
#define __H


// Model Sizes
#define IMG_SIZE 8
#define INP_SIZE IMG_SIZE*IMG_SIZE
#define KER_SIZE 3
#define N_FILT_LAYER1  16
#define N_DIM_LAYER2   16
#define LAYER1_SIZE 16*(IMG_SIZE-2)*(IMG_SIZE-2)

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
extern int img[INP_SIZE];
extern int ker[KER_SIZE*KER_SIZE*N_FILT_LAYER1];
extern int bias[N_FILT_LAYER1];
extern int expected_output[LAYER1_SIZE];

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
//convolutional Neural Network Related
int cnn(int img[IMG_SIZE*IMG_SIZE]);
void conv2d(int output[LAYER1_SIZE], int matrix[INP_SIZE], int kernel[KER_SIZE*KER_SIZE*N_FILT_LAYER1], int matsize, int bias[], int n_filters);
void mycpy(void* dest, void* src, int NoW);
// ISR Related Functions
void ISR6_addr_exception();
void ISR5_uart();    // UART Receive Interrupt handler

#endif
