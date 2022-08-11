#include "header.h"

    //load_data
    Matrix2D *wix1, *wfx1,  *wox1, *wgx1;
    Matrix2D *wix2, *wfx2,  *wox2, *wgx2;
    Matrix2D *wih1, *wfh1,  *woh1, *wgh1;
    Matrix2D *wih2, *wfh2,  *woh2, *wgh2;
    Matrix2D *wp1,  *wp2;

    Vec      *bi1,  *bf1,   *bo1,  *bg1;
    Vec      *bi2,  *bf2,   *bo2,  *bg2;
    Vec      *bp1,  *bp2;
    Vec      *x_0,  *x_1,   *h_0,  *c_0;

    State    *t0;
    Param    *layer1_param, *layer2_param;
    Param_mlp *mlp_param;
void init()
{
    //----------------------------------------------------
    // Allocate Memory for all params, states and inputs -- All are GlobVars
    //All Matrix2Ds
    wix1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + INPUT_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wfx1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + INPUT_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wox1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + INPUT_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wgx1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + INPUT_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));

    wix2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wfx2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wox2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wgx2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));

    wih1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wfh1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    woh1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wgh1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));

    wih2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wfh2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    woh2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    wgh2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE*sizeof(float));
    
    wp1 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + HIDDEN_LAYER_SIZE*LAYER3_SIZE*sizeof(float));
    wp2 = (Matrix2D *)malloc(sizeof(Matrix2D) + 2*sizeof(int) + LAYER3_SIZE*OUTPUT_SIZE*sizeof(float));

    // All Vecs
    bi1 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    bf1 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    bo1 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    bg1 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));

    bi2 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    bf2 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    bo2 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    bg2 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    
    bp1 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + LAYER3_SIZE*sizeof(float));
    bp2 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + OUTPUT_SIZE*sizeof(float));

    x_0 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + INPUT_SIZE*sizeof(float));
    x_1 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + INPUT_SIZE*sizeof(float));
    h_0 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));
    c_0 = (Vec *)malloc(sizeof(Vec) + 1*sizeof(int) + HIDDEN_LAYER_SIZE*sizeof(float));

    layer1_param = (Param *) malloc(sizeof(Param) + 8*sizeof(Matrix2D) + 4*sizeof(Vec));
    layer2_param = (Param *) malloc(sizeof(Param) + 8*sizeof(Matrix2D) + 4*sizeof(Vec));
    mlp_param = (Param_mlp *)malloc(sizeof(Param_mlp) + 2*sizeof(Matrix2D) + 2*sizeof(Vec));
    t0 = (State *)malloc(sizeof(State)+2*sizeof(Vec));

    //Initiallizing States

    //------------------wix1-------------------------------
    wix1->dim1=INPUT_SIZE;
    wix1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<INPUT_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wix1->data) + i) = w_ix_1[i];
    //------------------wfx1-------------------------------
    wfx1->dim1=INPUT_SIZE;
    wfx1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<INPUT_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wfx1->data) + i) = w_fx_1[i];
    //------------------wox1-------------------------------
    wox1->dim1=INPUT_SIZE;
    wox1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<INPUT_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wox1->data) + i) = w_ox_1[i];
    //------------------wgx1-------------------------------
    wgx1->dim1=INPUT_SIZE;
    wgx1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<INPUT_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wgx1->data) + i) = w_gx_1[i];


    //------------------wih1-------------------------------
    wih1->dim1=HIDDEN_LAYER_SIZE;
    wih1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wih1->data) + i) = w_ih_1[i];
    //------------------wfh1-------------------------------
    wfh1->dim1=HIDDEN_LAYER_SIZE;
    wfh1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wfh1->data) + i) = w_fh_1[i];
    //------------------woh1-------------------------------
    woh1->dim1=HIDDEN_LAYER_SIZE;
    woh1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(woh1->data) + i) = w_oh_1[i];
    //------------------wgh1-------------------------------
    wgh1->dim1=HIDDEN_LAYER_SIZE;
    wgh1->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wgh1->data) + i) = w_gh_1[i];


    //------------------wix2-------------------------------
    wix2->dim1=HIDDEN_LAYER_SIZE;
    wix2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wix2->data) + i) = w_ix_2[i];
    //------------------wfx2-------------------------------
    wfx2->dim1=HIDDEN_LAYER_SIZE;
    wfx2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wfx2->data) + i) = w_fx_2[i];
    //------------------wox2-------------------------------
    wox2->dim1=HIDDEN_LAYER_SIZE;
    wox2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wox2->data) + i) = w_ox_2[i];
    //------------------wgx2-------------------------------
    wgx2->dim1=HIDDEN_LAYER_SIZE;
    wgx2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wgx2->data) + i) = w_gx_2[i];


    //------------------wih2-------------------------------
    wih2->dim1=HIDDEN_LAYER_SIZE;
    wih2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wih2->data) + i) = w_ih_2[i];
    //------------------wfh2-------------------------------
    wfh2->dim1=HIDDEN_LAYER_SIZE;
    wfh2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wfh2->data) + i) = w_fh_2[i];
    //------------------woh2-------------------------------
    woh2->dim1=HIDDEN_LAYER_SIZE;
    woh2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(woh2->data) + i) = w_oh_2[i];
    //------------------wgh2-------------------------------
    wgh2->dim1=HIDDEN_LAYER_SIZE;
    wgh2->dim2=HIDDEN_LAYER_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*HIDDEN_LAYER_SIZE; i++)
        *( (float *)(wgh2->data) + i) = w_gh_2[i];

    //-------------------bi1-------------------------------
    bi1->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bi1->data) + i) = b_ix_1[i]; 
    //-------------------bf1-------------------------------
    bf1->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bf1->data) + i) = b_fx_1[i]; 
    //-------------------bo1-------------------------------
    bo1->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bo1->data) + i) = b_ox_1[i]; 
    //-------------------bg1-------------------------------
    bg1->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bg1->data) + i) = b_gx_1[i]; 

    //-------------------bi2-------------------------------
    bi2->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bi2->data) + i) = b_ix_2[i]; 
    //-------------------bf2-------------------------------
    bf2->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bf2->data) + i) = b_fx_2[i]; 
    //-------------------bo2-------------------------------
    bo2->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bo2->data) + i) = b_ox_2[i]; 
    //-------------------bg2-------------------------------
    bg2->dim=HIDDEN_LAYER_SIZE;
    for (int i=0;i<HIDDEN_LAYER_SIZE;i++)
        *( (float *)(bg2->data) + i) = b_gx_2[i]; 

    //--------------------x_0------------------------------
    x_0->dim=INPUT_SIZE;
        for (int i=0; i< INPUT_SIZE; i++)
            *( (float *)(x_0->data) + i) = input[i];
    //--------------------x_1------------------------------
    x_1->dim=INPUT_SIZE;
        for (int i=0; i< INPUT_SIZE; i++)
            *( (float *)(x_1->data) + i) = input[i];
    //--------------------h_0------------------------------
    h_0->dim=HIDDEN_LAYER_SIZE;
        for (int i=0; i< HIDDEN_LAYER_SIZE; i++)
            *( (float *)(h_0->data) + i) = 0;
    //--------------------c_0------------------------------
    c_0->dim=HIDDEN_LAYER_SIZE;
        for (int i=0; i< HIDDEN_LAYER_SIZE; i++)
            *( (float *)(c_0->data) + i) = 0;

    //----------------PERCEPTRON RELATED-------------------
    //------------------wp1-------------------------------
    wp1->dim1=HIDDEN_LAYER_SIZE;
    wp1->dim2=LAYER3_SIZE;
    for (int i=0; i<HIDDEN_LAYER_SIZE*LAYER3_SIZE; i++)
        *( (float *)(wp1->data) + i) = w3[i];
    //------------------wp2-------------------------------
    wp2->dim1=LAYER3_SIZE;
    wp2->dim2=OUTPUT_SIZE;
    for (int i=0; i<LAYER3_SIZE*OUTPUT_SIZE; i++)
        *( (float *)(wp2->data) + i) = w4[i];
    //--------------------bp2------------------------------
    bp2->dim=OUTPUT_SIZE;
        for (int i=0; i< OUTPUT_SIZE; i++)
            *( (float *)(bp2->data) + i) = b4[i];
    //--------------------bp1------------------------------
    bp1->dim=LAYER3_SIZE;
        for (int i=0; i< LAYER3_SIZE; i++)
            *( (float *)(bp1->data) + i) = b3[i];
    //Pack Params
    mlp_param->w1=wp1;
    mlp_param->w2=wp2;
    mlp_param->b1=bp1;
    mlp_param->b2=bp2;
    //-----------------------------------------------------    
    //------------------PARAMETER PACKING FOR LSTMS--------
    //-------------------layer1_param----------------------
    layer1_param->w_ix=wix1;
    layer1_param->w_fx=wfx1;
    layer1_param->w_ox=wox1;
    layer1_param->w_gx=wgx1;

    layer1_param->w_ih=wih1;
    layer1_param->w_fh=wfh1;
    layer1_param->w_oh=woh1;
    layer1_param->w_gh=wgh1;

    layer1_param->b_i=bi1;
    layer1_param->b_f=bf1;
    layer1_param->b_o=bo1;
    layer1_param->b_g=bg1;

    //-------------------layer2_param----------------------
    layer2_param->w_ix=wix2;
    layer2_param->w_fx=wfx2;
    layer2_param->w_ox=wox2;
    layer2_param->w_gx=wgx2;
 
    layer2_param->w_ih=wih2;
    layer2_param->w_fh=wfh2;
    layer2_param->w_oh=woh2;
    layer2_param->w_gh=wgh2;

    layer2_param->b_i=bi2;
    layer2_param->b_f=bf2;
    layer2_param->b_o=bo2;
    layer2_param->b_g=bg2;

    //-----------------Initial State------------------------
    t0->h =h_0;
    t0->c =c_0;

}
