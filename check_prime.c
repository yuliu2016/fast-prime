#include <stdint.h>
#include <stdbool.h>


int check_prime(uint32_t N) {
    if (N < 2) return 0;
    if (N == 2) return 1;
    if (N & 1 == 0) return 0;
    if (N == 3 || N == 5 || N == 7) return 1;

    uint32_t x = N;
    uint32_t S;
    do {
        S = 0;
        do {
            S += x & 3;
        } while((x = x >> 2));
        x = S;
    } while (x > 3);
    if (x == 3) return 0;

    uint32_t M = 0;
    uint32_t n = N;
    uint32_t G = 0;
    do {
        M = (M << 1) | (n & 1);
        G = G + 1;
    } while((n = n >> 1));

    uint32_t Q = 0;
    uint32_t E = 1 << (G & ~1);
    uint32_t X = N;
    uint32_t t;

    do {
        t = Q + E;
        if (X >= t) {
            X = X - t;
            Q = t + E;
        }
        Q = Q >> 1;
    } while((E = E >> 2));

    uint32_t U = Q;
    uint32_t D1 = 5;
    uint32_t D2 = 7;
    uint32_t J = 3;
    uint32_t L = G - 3;
    uint32_t m;
    uint32_t R1;
    uint32_t R2;

    for(;;) {
        m = M >> J;
        R1 = N >> L;
        R2 = R1;
        do {
            if (R1 >= D1) {
                R1 = R1 - D1;
            }
            if (R2 >= D2) {
                R2 = R2 - D2;
            }
            uint32_t temp = m & 1;
            R1 = temp | (R1 << 1);
            R2 = temp | (R2 << 1);
        } while ((m = m >> 1));
        if (R1 == 0 || R1 == D1) {
            return 0;
        }
        if (R2 == 0 || R2 == D2) {
            return 0;
        }
        D1 = D1 + 6;
        if (D1 > U) return 1;
        D2 = D2 + 6;
        if (D1 >> J) {
            J = J + 1;
            L = G - J;
        }
    }

    return 1;
}