#include "header.h"

int main()
{
    Matrix3D *image;
    Matrix4D *filter1;
    Matrix4D *filter2;
    // Declaring Layer Output Matrices
    Matrix3D *conv1;      //  Conv2d_1 Output
    Matrix3D *max1;       //   Maxpool2_1 Output
    Matrix3D *conv2;      //  Conv2d_2 Output
    Matrix3D *max2;       //   Maxpool2_2 Output
    //FC Related
    //float fc_input[];
    int fc_size;
    int identified;

    // Create Strutures 
    // 1. Image
    image = (Matrix3D *)malloc(sizeof(image) \
                + 3*sizeof(int)\
                + image_dim1*image_dim2*image_dim3*sizeof(float));
    image->dim1=image_dim1;    
    image->dim2=image_dim2;    
    image->dim3=image_dim3;
    for (int i=0;i < image_dim1*image_dim2*image_dim3;i++)
        image->data[i]=img[i];

    //2. Filter 1
    filter1 = (Matrix4D *)malloc(sizeof(filter1)\
                                + 4*sizeof(int)\
                                + filter1_dim1*filter1_dim2*filter1_dim3*filter1_dim4*sizeof(float));
    filter1->dim1=filter1_dim1;
    filter1->dim2=filter1_dim2;
    filter1->dim3=filter1_dim3;
    filter1->dim4=filter1_dim4;
    for (int i=0; i<filter1_dim1*filter1_dim2*filter1_dim3*filter1_dim4; i++)
        filter1->data[i]=filt1[i];

    //3. Filter 2
    filter2 = (Matrix4D *)malloc(sizeof(filter2)\
                                + 4*sizeof(int)\
                                + filter2_dim1*filter2_dim2*filter2_dim3*filter2_dim4*sizeof(float));
    filter2->dim1=filter2_dim1;
    filter2->dim2=filter2_dim2;
    filter2->dim3=filter2_dim3;
    filter2->dim4=filter2_dim4;
    for (int i=0; i<filter2_dim1*filter2_dim2*filter2_dim3*filter2_dim4; i++)
        filter2->data[i]=filt2[i];


     // Operations
     conv1 = conv2d(image, filter1, bias1);    // Conv_layer 1
     max1  = maxpool2(conv1);                    // MaxPooling 1
     conv2 = conv2d(max1, filter2, bias2);     // Conv_layer 2
     max2  = maxpool2(conv2);                    // MaxPooling 2 

     fc_size = (max2->dim1) * (max2->dim2) * (max2->dim3) ;
     identified = perceptron(max2->data, fc_size);

     //printf("Ops Completed ...\n");
     //printf("Image Identified as %d\n",identified);
     //print3DMat(max1);
     free(image);
     free(filter1);
     free(filter2);
     free(conv1);
     free(conv2);
     free(max1);
     free(max2);
     return 0;
}

