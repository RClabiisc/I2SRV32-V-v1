#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "w1.h"
#include "w2.h"
#include "w3.h"
#include "b1.h"
#include "b2.h"
#include "b3.h"
#include "img.h"
#define INPUT_SIZE 784
#define LAYER1_SIZE 32 
#define LAYER2_SIZE 16 
#define LAYER3_SIZE 10
 
float activation(float val);
int get_max_idx(float input_arr[LAYER3_SIZE]);

extern float layer1[LAYER1_SIZE];
extern float layer2[LAYER2_SIZE];
extern float output_probs[LAYER3_SIZE];

