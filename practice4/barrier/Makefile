.PHONY: all clean

all: barrier

barrier: barrier.cpp
	g++ barrier.cpp -std=c++11 -O0 -o barrier -Wall -Wextra -pthread -Wno-unknown-pragmas

clean:
	rm barrier
