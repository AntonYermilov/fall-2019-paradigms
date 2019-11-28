#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

const int N = 500000000;
const int M = 10000;

struct Data {
    int64_t a = 0;
    int64_t b = 0;
    int64_t c = 0;
    int64_t d = 0;
};

Data data;

void* worker(void*) {
    for (int i = 0; i < N; i++) {
        data.d++;
        data.c++;
        data.b++;
        data.a++;
    }
    return NULL;
}

int main() {
    pthread_t id;
    assert(pthread_create(&id, NULL, worker, NULL) == 0);
    for (int i = 0; i < M; i++) {
        printf("data is (%d, %d, %d, %d) (in progress)\n", (int) data.a, (int) data.b, (int) data.c, (int) data.d);
    }
    assert(pthread_join(id, NULL) == 0);
    printf("data is (%d, %d, %d, %d)\n", (int) data.a, (int) data.b, (int) data.c, (int) data.d);
    return 0;
}
