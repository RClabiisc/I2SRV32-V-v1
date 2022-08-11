#include "header.h"

void free_mem()
{
    free(wix1);
    free(wfx1);
    free(wox1);
    free(wgx1);

    free(wih1);
    free(wfh1);
    free(woh1);
    free(wgh1);

    free(wix2);
    free(wfx2);
    free(wox2);
    free(wgx2);

    free(wih2);
    free(wfh2);
    free(woh2);
    free(wgh2);

    free(bi1);
    free(bf1);
    free(bo1);
    free(bg1);

    free(bi2);
    free(bf2);
    free(bo2);
    free(bg2);

    free(wp1);
    free(wp2);
    free(bp1);
    free(bp2);
    
    free(layer1_param);
    free(layer2_param);
    free(mlp_param);
    free(t0);

}
