#ifndef __ONE
#define __ONE

//#define DEBUG 1
#define SELF_TEST 0 
extern char img[100][784];
extern int expected_output[100];
char uart_send(char img[784]);
#endif