#ifndef __H
#define __H


// Model Sizes
#define IMG_SIZE 28
#define INP_SIZE IMG_SIZE*IMG_SIZE
#define KER_SIZE 3
#define N_FILT_LAYER1  16
#define N_FILT_LAYER2  32
#define N_DIM_LAYER2   16
#define LAYER1_SIZE 16*(IMG_SIZE-2)*(IMG_SIZE-2)/4
#define LAYER2_SIZE 5*5*32
#define LAYER3_SIZE 10

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
extern int ker2[KER_SIZE*KER_SIZE*N_FILT_LAYER1*N_FILT_LAYER2];
extern int w3[LAYER2_SIZE*LAYER3_SIZE];
extern int bias[N_FILT_LAYER1];
extern int bias2[N_FILT_LAYER2];
extern int bias3[LAYER3_SIZE];

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
void layer2(int output[LAYER2_SIZE], int matrix[LAYER1_SIZE], int kernel[KER_SIZE*KER_SIZE*N_FILT_LAYER1*N_FILT_LAYER2], int matsize, int bias[32], int n_filters, int n_dim);
void mycpy(void* dest, void* src, int NoW);
int layer3(int output, int matrix[800],int weight[LAYER2_SIZE*LAYER3_SIZE],int matsize ,int bias[LAYER3_SIZE], int bias_size);

// ISR Related Functions
void ISR6_addr_exception();
void ISR5_uart();    // UART Receive Interrupt handler

#endif
