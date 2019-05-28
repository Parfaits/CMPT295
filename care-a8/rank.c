#include <stdlib.h>

typedef struct swag
{
    float f;
    int index;
} swag;

int compar(const void * a, const void * b){
    swag *swagA = (swag *)a;
    swag *swagB = (swag *)b;

    return (swagA->f < swagB->f) - (swagA->f > swagB->f);
}


void compute_ranks(float *F, int N, int *R, float *avg, float *passing_avg, int *num_passed) {
    int i;
    // *num_passed = 0;
    // *avg = 0.0;
    // *passing_avg = 0.0;

    float tmp_passing_avg = 0.0;
    int tmp_num_passed = 0;
    float tmp_avg = 0.0;
    // int over_fifty[11] = {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1};

    // init ranks
    // for (i = 0; i < N; i++) {
    //     R[i] = 1;
    // }
    // for (i = 0; i < N; i += 4) {
    //     R[i] = 1;
    //     R[i+1] = 1;
    //     R[i+2] = 1;
    //     R[i+3] = 1;
    // }

    // compute ranks
    // for (i = 0; i < N; i++) {
    //     for (j = 0; j < N; j++) {
    //         if (F[i] < F[j]) {
    //             R[i] += 1;
    //         }
    //     }
    // }
    swag tmp_F[N];                              // create a new datatype to simulate a dictionary where
    for (int i = 0; i < N-5; i += 5)            // the key is keeping track of the index of the original array F[]
    {                                           // and the value f
        tmp_F[i].f = F[i];
        tmp_F[i+1].f = F[i+1];                  // This loop to copy the value and indexes into the datatype array loop unrolling
        tmp_F[i+2].f = F[i+2];                  
        tmp_F[i+3].f = F[i+3];
        tmp_F[i+4].f = F[i+4];
        // tmp_F[i+5].f = F[i+5];
        // tmp_F[i+6].f = F[i+6];
        // tmp_F[i+7].f = F[i+7];
        // tmp_F[i+8].f = F[i+8];
        // tmp_F[i+9].f = F[i+9];
        tmp_F[i].index = i;
        tmp_F[i+1].index = i+1;
        tmp_F[i+2].index = i+2;
        tmp_F[i+3].index = i+3;
        tmp_F[i+4].index = i+4;
        // tmp_F[i+5].index = i+5;
        // tmp_F[i+6].index = i+6;
        // tmp_F[i+7].index = i+7;
        // tmp_F[i+8].index = i+8;
        // tmp_F[i+9].index = i+9;
    }
    for (; i < N; ++i)                          // Remainder elements
    {
        tmp_F[i].f = F[i];
        tmp_F[i].index = i;
    }
    qsort(tmp_F, N, sizeof(swag), compar);      // Sort the datatype array
    for (int i = 0; i < N; i++)                 // then rank by the value f in ascending order
    {   
        if (i && tmp_F[i].f == tmp_F[i-1].f)    // keeps track of same grades to rank them the same
        {
            R[tmp_F[i].index] = R[tmp_F[i-1].index];
            // continue;
        } else R[tmp_F[i].index] = i+1;
        if (tmp_F[i].f >= 50.0)                 // Also might aswell calculate the number of passed and passing avg and overall avg
        {
            tmp_passing_avg += tmp_F[i].f;
            tmp_num_passed += 1;
        }
        tmp_avg += tmp_F[i].f;
        // R[tmp_F[i].index] = i+1;
    }

    // compute averages
    // for (i = 0; i < N; i++) {
    //     *avg += F[i];
    //     if (F[i] >= 50.0) {
    //         *passing_avg += F[i];
    //         *num_passed += 1;
    //     }
    // }
    // for (i = 0; i < N; i++) {
    //     tmp_avg += F[i];
    //     tmp_passing_avg += F[i]*over_fifty[(((int) F[i])/10)];
    //     tmp_num_passed += 1*over_fifty[(((int) F[i])/10)];
    // }
    // for (i = 0; i < N; i++) {
    //     tmp_avg += F[i];
    //     if (F[i] >= 50.0) {
    //         tmp_passing_avg += F[i];
    //         tmp_num_passed += 1;
    //     }
    // }
    // tmp_avg = sum[0] + sum[1] + sum[2] + sum[3] + sum[4];

    // check for div by 0
    // if (N > 0) *avg /= N;
    // if (*num_passed) *passing_avg /= *num_passed;
    if (N) tmp_avg /= N;
    if (tmp_num_passed) tmp_passing_avg /= tmp_num_passed;
    *avg = tmp_avg;                                                     // reduced memory access and memory aliasing
    *passing_avg = tmp_passing_avg;
    *num_passed = tmp_num_passed;


} // compute_ranks

