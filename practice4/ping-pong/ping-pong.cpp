#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <algorithm>
#include <iostream>

const int T = 100;

int t;

void *ping(void *) {
    while (t < T) {
        if (t % 2 == 0) {
            t += 1;
            printf("ping ");
        }
    }
    return NULL;
}

void *pong(void *) {
    while (t < T) {
        if (t % 2 == 1) {
            printf("pong ");
            t += 1;
        }
    }
    return NULL;
}

int main() {
    pthread_t ping_thread;
    pthread_t pong_thread;

    assert(pthread_create(&ping_thread, NULL, ping, NULL) == 0);
    assert(pthread_create(&pong_thread, NULL, pong, NULL) == 0);
    
    assert(pthread_join(ping_thread, NULL) == 0);
    assert(pthread_join(pong_thread, NULL) == 0);

    return 0;
}


