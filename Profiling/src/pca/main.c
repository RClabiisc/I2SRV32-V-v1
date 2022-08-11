#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include "header.h"

int main()
{
    float scaled[INPUT_SIZE];
    float pca_op[PCA_SIZE];
    int output;

    scaler(img,scaled);
    pca(scaled,pca_op);
    output=perceptron(pca_op);

    return 0;
}

