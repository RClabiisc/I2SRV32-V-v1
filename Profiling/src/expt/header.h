#include <stdio.h>
#include <string.h>

#define TEN 10
typedef struct
{
    float (*a)[10];
    int a_dim;
    float (*b)[10];
    int b_dim;
}State;

void vecadd2(State* inp, State *out);
void vadd2(float a[],float b[],int dim,float y[]);
void add(float a[],float b[],float y[]);
