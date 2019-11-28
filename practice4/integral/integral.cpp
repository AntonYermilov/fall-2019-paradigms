#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 1000000000;
const int L = 0, R = 10;

double f(double x) {
    return 3.0 * x * x - 2.0f * x;
}

int main() {
    double result = 0.0f;
    double h = 1.0f * (R - L) / N;
    for (int i = 0; i < N; ++i) {
        double a = L + (1.0f * i / N) * (R - L);
        double b = L + (1.0f * (i + 1) / N) * (R - L);
        result += h * (f(a) + f(b)) / 2.0f;
    }

    printf("integral_{%d}^{%d} (3 x^2 - 2 x) dx = %.10f\n", L, R, result);
    return 0;
}
