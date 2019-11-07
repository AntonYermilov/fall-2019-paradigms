"""
Задача 1.
Найти количество клеток, достижимых на циклическом поле размера n x n, если разрешено ходить только по диагонали
"""


def solve(n: int) -> int:
    """Some code here"""

    """ Step 2. """
    # if n % 2 == 0:
    #     return n * n // 2

    """Some code here"""

    """ Step 1. """
    # if n == 0:
    #     return -1

    """Some code here"""

    """ Step 0. """
    return n * n


if __name__ == '__main__':
    n = int(input())
    print(solve(n))
