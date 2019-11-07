from typing import List


"""
Задание 1.
Дан массив целых чисел. 
Необходимо изменить его, оставив числа из отрезка [l, r] и возведя их в квадрат.
"""


def transform_simple(arr: List[int], l: int, r: int) -> List[int]:
    result = []
    for x in arr:
        if l <= x <= r:
            result.append(x * x)
    return result


def transform_list_comprehensions(arr: List[int], l: int, r: int) -> List[int]:
    return [x * x for x in arr if l <= x <= r]


def transform_generators(arr: List[int], l: int, r: int) -> List[int]:
    return list(map(lambda x: x * x, filter(lambda x: l <= x <= r, arr)))


"""
Задание 2.
Дан двумерный массив чисел. 
Нужно посчитать сумму квадратов чисел, кратных двум.
"""


def conditional_sum_2d_simple(arr: List[List[int]]) -> int:
    result = 0
    for row in arr:
        for x in row:
            if x % 2 == 0:
                result += x * x
    return result


def conditional_sum_2d(arr: List[List[int]]) -> int:
    return sum(x * x for row in arr for x in row if x % 2 == 0)


"""
Задание 3.
Дан массив. 
Требуется перевернуть подотрезок массива [l, r].
"""


def reverse_array(arr: list, l: int, r: int) -> list:
    left, center, right = arr[:l], arr[l:r + 1], arr[r + 1:]
    return left + center[::-1] + right


"""
Задание 4.
Дана строка. 
Если ее длина хотя бы 3, добавить в конец 'ing. 
Если же строка уже заканчивается на 'ing', то добавить в конец 'ly'.

Пример входа: 'read'
Пример выхода: 'reading'
"""


def verbing(s: str) -> str:
    if len(s) < 3:
        return s
    if s[-3:] == 'ing':
        return s + 'ly'
    return s + 'ing'


""" 
Задание 5.
Даны два списка a и b.

Требуется разбить оба списка на две части, а затем склеить их в порядке
a-front + b-front + a-back + b-back,
где front и back - это первые и последние элементы списков.

Если список четной длины, то front и back должны быть равны.
В противном случае front должен быть на 1 больше back.

Пример входа: [1, 2, 3, 4] [5, 6]
Пример выхода: [1, 2, 5, 3, 4, 6]
"""


def front_back(a: list, b: list) -> list:
    f = lambda arr: (len(arr) + 1) // 2
    a_front, a_back = a[:f(a)], a[f(a):]
    b_front, b_back = b[:f(b)], b[f(b):]
    return a_front + b_front + a_back + b_back


"""
Задание 6.
Удалить соседние равные элементы

Пример входа: [1, 2, 2, 3]
Пример выхода: [1, 2, 3]
"""


def remove_adjacent(a: list) -> list:
    # res = []
    # for i in range(len(a)):
    #     if i == 0 or a[i] != a[i - 1]:
    #         res.append(a[i])
    # return res

    res = [x for x, y in zip(a, a[1:]) if x != y] + [a[-1]]
    return res


def test_all():
    arr = list(range(10))
    assert transform_simple(arr, 5, 7) == [25, 36, 49]
    assert transform_list_comprehensions(arr, 5, 7) == [25, 36, 49]
    assert transform_generators(arr, 5, 7) == [25, 36, 49]

    arr = [[1, 2],
           [3, 4]]
    assert conditional_sum_2d_simple(arr) == 20
    assert conditional_sum_2d(arr) == 20

    assert reverse_array(list(range(10)), 3, 7) == [0, 1, 2, 7, 6, 5, 4, 3, 8, 9]

    assert verbing("play") == "playing"
    assert verbing("interesting") == "interestingly"
    assert verbing("hi") == "hi"

    assert front_back([1, 2, 3, 4], [5, 6, 7, 8, 9]) == [*[1, 2], *[5, 6, 7], *[3, 4], *[8, 9]]

    assert remove_adjacent([1, 2, 2, 3]) == [1, 2, 3]
    assert remove_adjacent([1, 1, 2, 2, 3, 3, 2, 2, 1, 1]) == [1, 2, 3, 2, 1]


if __name__ == '__main__':
    test_all()
