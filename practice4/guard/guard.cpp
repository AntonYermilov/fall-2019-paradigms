#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <iostream>
#include <vector>

unsigned int t = 100000;
pthread_mutex_t m;

void *decrease(void *) {
    while (true) {
        pthread_mutex_lock(&m);
        if (t == 0) {
            break;
        }
        --t;
        pthread_mutex_unlock(&m);
    }
    return NULL;
}

int main(int argc, const char **argv) {
    assert(argc == 2);
    int threads_num = atoi(argv[1]);

    pthread_mutex_init(&m, NULL);

    std::vector<pthread_t> threads(threads_num);
    for (int i = 0; i < threads_num; ++i) {
        assert(pthread_create(&threads[i], NULL, decrease, NULL) == 0);
    }
    
    for (int i = 0; i < threads_num; ++i) {
        assert(pthread_join(threads[i], NULL) == 0);
    }

    pthread_mutex_destroy(&m);

    std::cout << "Success!\n";

    return 0;
}


