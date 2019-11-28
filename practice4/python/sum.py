import sys
from threading import Thread

def foo():
    a = 0
    for i in range(1000000):
        a += i * i
    return a


N = int(sys.argv[1])
ts = []

for i in range(N):
    ts.append(Thread(target=foo))

for t in ts: 
    t.start()
for t in ts: 
    t.join()
