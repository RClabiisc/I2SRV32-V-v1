#include <stdint.h>
int main()
{

/*    uint8_t x1=(uint8_t)(inp[0] & 0x000000FF);
    uint8_t x2=(uint8_t)((inp[0] & 0x0000FF00)>8);
    uint8_t x3=(uint8_t)((inp[0] & 0x000FF000)>16);
    uint8_t x4=(uint8_t)((inp[0] & 0xFF000000)>24);
    uint8_t d1=(uint8_t)(inp[1] & 0x000000FF);
    uint8_t d2=(uint8_t)((inp[2] & 0x0000FF00)>8);
    uint8_t d3=(uint8_t)((inp[3] & 0x000FF000)>16);
*/

    int offset;
    int x1=10;
    int x2=20;
    int x3=30;
    int x4=40;
    int d2=100;
    int d3=200;
    int d4=400;


    offset=x1*d2*d3*d4 + x2*d3*d4 +x3*d4 + x4;

    return offset;
}

