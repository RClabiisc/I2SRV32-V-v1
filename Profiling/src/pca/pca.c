#include "header.h"

void pca(float img[],float out[])
{
    float mac_pca;
    //PCA Layer
    for (int i=0; i<PCA_SIZE;i++)
    {
        mac_pca=0;
        for (int j=0;j<INPUT_SIZE;j++)
            mac_pca+=img[j]*eigen_vectors[j][i];
        out[i] = mac_pca;
    }
}

