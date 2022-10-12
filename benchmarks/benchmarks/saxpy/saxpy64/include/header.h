#ifndef __H
#define __H


// Model Sizes
#define VEC_SIZE 64

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
extern int x_vec[VEC_SIZE];
extern int y_vec[VEC_SIZE];
extern int expected_output[VEC_SIZE];
//////////////////////////////////
// Function Declaration 
//////////////////////////////////
// main function
int main(int argc, char* argv[]);
//convolutional Neural Network Related
void saxpy(int y_vec[VEC_SIZE], int a, int x_vec[VEC_SIZE], int size);
// ISR Related Functions
void ISR6_addr_exception();
void ISR5_uart();    // UART Receive Interrupt handler

#endif
