#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#include "header.h"

int main()
{
    Vec   *h_1, *h_2, *c_1, *c_2;
    State *t1, *t2;
    int output;
    //Initiallize All Inputs and Parameters
    init();
    //Compute Forward Path
    t1 = lstm(t0, x_0, layer1_param);

    t2 = lstm(t1, x_1, layer2_param);
    // Diagonostics
    h_1 = t1->h;
    c_1 = t1->c;
    h_2 = t2->h;
    c_2 = t2->c;
    // MLP
    output = mlp_3(h_2,mlp_param);
    //printf("Output= %d\n",output);
    free(t1);
    free(t2);
    free(h_1);
    free(c_1);
    free(h_2);
    free(c_2);
    //free_mem();

    return 0;
}


