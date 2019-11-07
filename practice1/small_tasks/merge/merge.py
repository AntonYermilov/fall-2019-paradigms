from typing import List


"""
Задание.
Найти багу в реализации слияния двух сортированных списков.
Придумать и написать тест, который эта реализация не проходит.
Пофиксить багу, допущенную преподавателем в пять утра :)
"""


def merge(a: List[int], b: List[int]) -> List[int]:
    i, j, res = 0, 0, []
    while i < len(a) or j < len(b):
        if j == len(b) or (i < len(a) and a[i] < b[j]):
            res.append(a[i])
            i += 1
        elif i == len(a) or (j < len(b) and b[j] < a[i]):
            res.append(b[j])
            j += 1
        else:
            # ???
            break
    return res


if __name__ == '__main__':
    print(merge([1, 3, 5, 7], [2, 4, 6]))
