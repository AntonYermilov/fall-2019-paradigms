#include <iostream>
#include <vector>
#include <algorithm>
#include <cassert>
#include <random>
#include <pthread.h>

struct barrier_t {
    // TODO

    void init(int _barrier_count) {
        // TODO
    }

    void destroy() {
        // TODO
    }

    void wait() {
        // TODO
    }
};

barrier_t barrier;

void do_job() {
    const int N = 10000000;

    std::mt19937 rnd(std::hash<pthread_t>{}(pthread_self()));
    std::uniform_int_distribution<int> distr(N, N * 10);

    int n = distr(rnd);
    std::vector<int64_t> numbers(n);

    for (int i = 0; i < n; ++i)
        numbers[i] = rnd();

    std::sort(numbers.begin(), numbers.end());
}

void *job(void *) {
    std::cout << "Thread " << pthread_self() << " was created\n";
    // barrier.wait();
    do_job();
    std::cout << "Thread " << pthread_self() << " has finished its job\n";
    return NULL;
}

int main(int argc, const char **argv) {
    assert(argc == 2);

    int barrier_count = atoi(argv[1]);
    barrier.init(barrier_count);
    
    std::vector<pthread_t> threads;
    for (int new_threads; std::cin >> new_threads;) {
        assert(new_threads >= 0);
        for (int i = 0; i < new_threads; ++i) {
            threads.emplace_back();
            assert(pthread_create(&threads.back(), NULL, job, NULL) == 0);
        }
    }
    for (auto& thread : threads) {
        assert(pthread_join(thread, NULL) == 0);
    }

    barrier.destroy();
    return 0;
}
