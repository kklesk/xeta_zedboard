//
// Created by ivan on 05.06.23.
//

#ifndef XETA_ZEDBOARD_XETA_H
#define XETA_ZEDBOARD_XETA_H
#include <stdint.h>

/* take 64 bits of data in v[0] and v[1] and 128 bits of key[0] - key[3] */

uint32_t* encipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) {
    unsigned int i;
    uint32_t v0=v[0], v1=v[1], sum=0, delta=0x9E3779B9;
    for (i=0; i < num_rounds; i++) {
        v0 += (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key[sum & 3]);
        sum += delta;
        v1 += (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key[(sum>>11) & 3]);
    }
    v[0]=v0; v[1]=v1;
#ifdef DEBUG
    printf("encipher() -> v[0]=%c\n",v[0]);
    printf("encipher() -> v[1]=%c\n",v[1]);
#endif
    return v;
}

uint32_t* decipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) {
    unsigned int i;
    uint32_t v0=v[0], v1=v[1], delta=0x9E3779B9, sum=delta*num_rounds;
    for (i=0; i < num_rounds; i++) {
        v1 -= (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key[(sum>>11) & 3]);
        sum -= delta;
        v0 -= (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key[sum & 3]);
    }
    v[0]=v0; v[1]=v1;
#ifdef DEBUG
    printf("decipher() -> v[0]=%c\n",v[0]);
    printf("decipher() -> v[1]=%c\n",v[1]);
#endif
    return v;
}
#endif //XETA_ZEDBOARD_XETA_H
