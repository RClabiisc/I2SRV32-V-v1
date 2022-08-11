#include "header.h"

int main()
{
    float conv1[CONV1_SIZE];
    float conv2[CONV2_SIZE];
    float maxpool1[MAXPOOL1_SIZE];
    float maxpool2[MAXPOOL2_SIZE];
     int identified;
     // Operations
     conv2d_1(img, filt1, bias1,conv1);    // Conv_layer 1
     maxpool2_1(conv1, maxpool1);                    // MaxPooling 1
     conv2d_2(maxpool1, filt2, bias2,conv2);    // Conv_layer 1
     maxpool2_2(conv2, maxpool2);                    // MaxPooling 1
     identified = perceptron(maxpool2);

    // printf("Ops Completed ...\n");
     //printf("Image Identified as %d\n",identified);
     return 0;
}

