from threading import Thread

a = 0

def foo():
    global a
    for _ in range(1000000):
        a += 1

ts = [Thread(target=foo), Thread(target=foo)]
for t in ts: 
    t.start()
for t in ts: 
    t.join()

print(a)
