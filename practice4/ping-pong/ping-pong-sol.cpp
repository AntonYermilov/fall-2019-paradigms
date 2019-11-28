#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <algorithm>
#include <iostream>

const int T = 100;

int t;
pthread_mutex_t m;

void *ping(void *) {
    while (t < T) {
        pthread_mutex_lock(&m);
        if (t % 2 == 0) {
            t += 1;
            printf("ping ");
        }
        pthread_mutex_unlock(&m);
    }
    return NULL;
}

void *pong(void *) {
    while (t < T) {
        pthread_mutex_lock(&m);
        if (t % 2 == 1) {
            printf("pong ");
            t += 1;
        }
        pthread_mutex_unlock(&m);
    }
    return NULL;
}

int main() {
    pthread_t ping_thread;
    pthread_t pong_thread;

    pthread_mutex_init(&m, NULL);
    assert(pthread_create(&ping_thread, NULL, ping, NULL) == 0);
    assert(pthread_create(&pong_thread, NULL, pong, NULL) == 0);
    
    assert(pthread_join(ping_thread, NULL) == 0);
    assert(pthread_join(pong_thread, NULL) == 0);
    pthread_mutex_destroy(&m);
    

    return 0;
}


