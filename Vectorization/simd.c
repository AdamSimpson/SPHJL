#include "stdio.h"
#include "stdlib.h"

typedef struct {
    double x;
    double y;
    double z;
} AoS;

typedef struct {
    double *z;
    double *y;
    double *x;
} SoA;

int main(int argc, char **argv)
{
    int i;
    const int length = 10000000;

    // No luck getting LLVM to vectorize AoS
    AoS *restrict aos = malloc(length*sizeof(AoS));
    #pragma clang loop unroll(disable) vectorize(enable)
    for(i=0; i<length; i++) {
        aos[i].x = i;
        aos[i].y = 1.0;
    }
    printf("%f\n", aos[1].x);

    // SoA trivial to vectorize
    SoA soa;
    soa.x = malloc(length*sizeof(double));
    soa.y = malloc(length*sizeof(double));
    soa.z = malloc(length*sizeof(double));
    for(i=0; i<length; i++) {
        soa.x[i] = i;
        soa.y[i] = i+1.0;
        soa.z[i] = i+2.0;
    }   
    printf("%f\n", soa.x[1]);

    return 0;
}
