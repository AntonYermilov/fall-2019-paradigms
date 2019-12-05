APPS=$(sort $(basename $(wildcard *.cpp)))

.PHONY: all clean

all: $(APPS)

%: %.cpp
	g++ $^ -std=c++11 -O0 -o $@ -Wall -Wextra -Werror -pthread -Wno-unknown-pragmas

clean:
	rm $(APPS) >/dev/null 2>&1 || true
