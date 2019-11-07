from typing import List


def fibonacci(n: int, a0: int = 0, a1: int = 1) -> List[int]:
    res = [a0, a1]
    if n < 2:
        return res[:n]
    for i in range(2, n):
        res.append(res[-1] + res[-2])
    return res


if __name__ == '__main__':
    print(fibonacci(10))
    print(fibonacci(10, 'a', 'b'))
