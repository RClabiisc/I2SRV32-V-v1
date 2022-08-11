#include "header.h"

int compute_offset3D(int x1, int x2, int x3, int d1, int d2, int d3)
{
    int offset;
    offset=x1*d2*d3+x2*d3+x3;
    return offset;
}

int compute_offset4D(int x1, int x2, int x3, int x4, int d1, int d2, int d3, int d4)
{
    int offset;
    offset=x1*d2*d3*d4 + x2*d3*d4 +x3*d4 + x4;
    return offset;
}
 
float mac_op(float sum, float a, float b)
{
    return sum+(a*b);
}
