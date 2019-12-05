#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

const int THREADS = 2;
const int N = 1000000000;
const int L = 0, R = 10;

double result[THREADS];

double f(double x) {
    return 3.0 * x * x - 2.0 * x;
}

void *worker(void *thread_id) {
    int id = *static_cast<int *>(thread_id);

    double partial = 0.0f;
    double h = 1.0f * (R - L) / N;
    for (int i = id; i < N; i += THREADS) {
        double a = L + (1.0f * i / N) * (R - L);
        double b = L + (1.0f * (i + 1) / N) * (R - L);
        partial += h * (f(a) + f(b)) / 2.0f;
    }

    result[id] += partial;
    return nullptr;
}

int main() {
    pthread_t threads[THREADS];
    int thread_id[THREADS];

    for (int i = 0; i < THREADS; ++i) {
        thread_id[i] = i;
        assert(pthread_create(&threads[i], nullptr, worker, &thread_id[i]) == 0);
    }

    double total_result = 0.0f;
    for (int i = 0; i < THREADS; ++i) {
        assert(pthread_join(threads[i], nullptr) == 0);
        total_result += result[i];
    }

    printf("integral_{%d}^{%d} (3 x^2 - 2 x) dx = %.10f\n", L, R, total_result);
    return 0;
}

