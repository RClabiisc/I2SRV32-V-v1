#include "header.h"

int perceptron(float input[])
{
    float mac1,mac2,mac3;
    int idx;
    float layer1[LAYER1_SIZE];
    float layer2[LAYER2_SIZE];
    float output_probs[LAYER3_SIZE];

      //First Layer
    for (int i=0; i<LAYER1_SIZE;i++)
    {
        mac1=0;
        for (int j=0;j<PCA_SIZE;j++)
            mac1+=input[j]*w1[j][i];
        layer1[i] = activation(mac1+b1[i]);
    }

    //Second Layer
    for (int i=0; i<LAYER2_SIZE;i++)
    {
        mac2=0;
        for (int j=0;j<LAYER1_SIZE;j++)
            mac2+=layer1[j]*w2[j][i];
        layer2[i] = activation(mac2+b2[i]);
    }

    //Third Layer
    for (int i=0; i<LAYER3_SIZE;i++)
    {
        mac3=0;
        for (int j=0;j<LAYER2_SIZE;j++)
            mac3+=layer2[j]*w3[j][i];
        output_probs[i] = mac3+b3[i];
    }
    // Find the Maximum Probability
    idx = get_max_idx(output_probs);
    //Print Result
    //for (int i=0; i<LAYER3_SIZE; i++)
    //    printf("%f\n",output_probs[i]);
    //printf("Image Classified as %d\n",idx);
    return idx;
}
